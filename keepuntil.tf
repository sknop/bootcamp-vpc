resource "time_offset" "expiry" {
  offset_years = 2
}

locals {
  keep_until_date = formatdate("YYYY-MM-DD", time_offset.expiry.rfc3339)
}
