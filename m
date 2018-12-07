From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Dec 2018 13:35:10 +0100
Subject: [LTP] [PATCH v2 0/6] DHCP tests and AppArmor/SELinux improvements
Message-ID: <20181207123516.30867-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this further enhances patchset "DHCP tests and AppArmor improvements" [1]
Main change is adding tst_security.sh and using it (last 2 commits).

Thanks for review.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=70357&state=*

Petr Vorel (6):
  net/dhcp: Rename setup & cleanup functions
  net/dhcp: Use paths allowed by AppArmor for dnsmasq
  net/dhcp: Move print_dhcp_log() into dhcp library
  ver_linux: Print AppArmor and SELinux status
  shell: Add tst_security.sh helper
  net: Add security warning flag to some net tests

 testcases/lib/tst_security.sh                 | 64 +++++++++++++++++++
 testcases/lib/tst_test.sh                     | 14 +++-
 testcases/network/dhcp/dhcp_lib.sh            | 15 +++--
 testcases/network/dhcp/dhcpd_tests.sh         |  7 +-
 testcases/network/dhcp/dnsmasq_tests.sh       | 28 +++++---
 testcases/network/mpls/mpls02.sh              |  1 +
 testcases/network/mpls/mpls_lib.sh            |  1 +
 .../network/stress/icmp/icmp-uni-basic.sh     |  1 +
 testcases/network/stress/icmp/icmp-uni-vti.sh |  1 +
 .../network/stress/interface/if-mtu-change    |  1 +
 .../network/stress/interface/if4-addr-change  |  1 +
 testcases/network/traceroute/traceroute01.sh  |  1 +
 ver_linux                                     | 46 +++++++++++--
 13 files changed, 158 insertions(+), 23 deletions(-)
 create mode 100644 testcases/lib/tst_security.sh

-- 
2.19.2

