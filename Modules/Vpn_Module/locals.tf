locals {
  tunnel_bgp_ips = [
    {
      cip   = "169.254.21.5"
      oip   = "169.254.21.4"
      index = 0
      mask  = "/31"
    },
    {
      cip   = "169.254.21.5"
      oip   = "169.254.21.6"
      mask  = "/30"
      index = 1
    }
  ]

}
