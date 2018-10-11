From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Oct 2018 00:05:21 +0200
Subject: [LTP] [PATCH 0/4] DHCP tests and AppArmor improvements
Message-ID: <20181011220525.24628-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

here are some more DHCP tests polishing.

Kind regards,
Petr

Petr Vorel (4):
  net/dhcp: Use paths allowed by AppArmor for dnsmasq
  net/dhcp: Move print_dhcp_log() into dhcp library
  ver_linux: Print AppArmor and SELinux status
  tst_net.sh: Warn about enabled AppArmor

 testcases/lib/tst_net.sh                |  5 +++
 testcases/network/dhcp/dhcp_lib.sh      |  7 ++++
 testcases/network/dhcp/dhcpd_tests.sh   |  7 +---
 testcases/network/dhcp/dnsmasq_tests.sh | 13 +++----
 ver_linux                               | 46 ++++++++++++++++++++++---
 5 files changed, 60 insertions(+), 18 deletions(-)

-- 
2.19.0

