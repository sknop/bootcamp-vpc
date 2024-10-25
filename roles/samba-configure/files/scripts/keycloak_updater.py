import configparser
import logging
import sys
import os

from keycloak import KeycloakAdmin

C3_SSO_LOGIN='c3_sso_login'
REDIRECT_URIS='redirectUris'
ENDPOINT='/api/metadata/security/1.0/oidc/authorization-code/callback'

class KeycloakUpdater:
    def __init__(self, config_file):
        self.config_file = config_file
        self.logger = logging.getLogger('bootcamp')
        self.init_logging()
        self.initialise()

    def initialise(self):
        parser = configparser.ConfigParser()
        with open(self.config_file) as f:
            lines = '[top]\n' + f.read()  # hack, do not want [top] in config file, so add it here
            parser.read_string(lines)

        # we expect certain entries in the config file, or we will bail. There are no defaults

        parser = parser['top']
        self.set_config('keycloak_username', parser)
        self.set_config('keycloak_password', parser)
        self.set_config('keycloak_url', parser)
        self.set_config('keycloak_bootcamp_realm', parser)

        self.logger.info("Environment: ")
        for name, value in os.environ.items():
            self.logger.info("{0}:{1}".format(name, value))

    def init_logging(self):
        self.logger.setLevel(logging.INFO)  # change to INFO or DEBUG for more output

        handler = logging.StreamHandler()
        handler.setLevel(logging.INFO)

        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        handler.setFormatter(formatter)

        self.logger.addHandler(handler)

    def set_config(self, key, parser):
        if key not in parser:
            self.logger.error(f"Cannot find {key} in config file. Aborting")
            sys.exit(2)
        self.__setattr__(key, parser[key])
        self.logger.info(f"{key} : {parser[key]}")

    def update_c3_client(self, request_uri):
        admin = KeycloakAdmin(
            server_url=self.keycloak_url,
            username=self.keycloak_username,
            password=self.keycloak_password,
            client_id='admin-cli',
            grant_type='password',
            verify='/home/ubuntu/root-ca.pem')

        admin.change_current_realm(self.keycloak_bootcamp_realm)

        c3_sso_login_id = admin.get_client_id(C3_SSO_LOGIN)
        c3_sso_login_client = admin.get_client(c3_sso_login_id)
        redirect_uris = c3_sso_login_client[REDIRECT_URIS]

        if not request_uri.endswith(ENDPOINT):
            request_uri += ENDPOINT

        redirect_uris.append(request_uri)
        c3_sso_login_client[REDIRECT_URIS] = redirect_uris

        admin.update_client(c3_sso_login_id, c3_sso_login_client)

