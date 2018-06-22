From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jun 2018 17:10:39 +0200
Subject: [LTP] [PATCH v2 0/8]	Migrate tests using virt_lib.sh and
	ipsec_lib.sh to new API
Message-ID: <20180622151047.13002-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Changes v1->v2
Changes requested by Alexey:
* ipsec_lib.sh: remove IPSEC_SIZE_ARRAY and pass -s directly to TST_TEST_DATA, remove now unused IPSEC_LIB_IGNORE_IPSEC_SIZE_ARRAY
* Cleanup useless do_test as TST_TESTFUNC when can be avoided + move code to setup functions (gre01.sh, macsec01.sh, macsec02.sh)
* USE TST_TEST_DATA{,_IFS} for virt_test_0[12] + cleanup unused params

Changes requested by Cyril:
* Return when tst_lib.sh already loaded

Other changes:
* New commit net/virt_lib.sh: Remove possibility to pass custom sizes
* New commit adding macsec_lib.sh
* Remove left TCID


Kind regards,
Petr

Petr Vorel (8):
  net/ipsec: Improve log info messages
  tst_test.sh: Introduce TST_LIB_LOADED
  tst_net.sh: Harden against multiple loading
  net/ipsec: Use ':' as array separator for -s parameter
  net/{stress,virt}: Use SPDX-License-Identifier GPL-2.0-or-later
  net/virt_lib.sh: Remove possibility to pass custom sizes
  net/{stress,virt}: Migrate virt_lib.sh, ipsec_lib.sh + tests using
    them
  net/virt: Introduce macsec_lib.sh to reduce duplicity

 runtest/net_stress.ipsec_dccp                 | 212 +++++++++---------
 runtest/net_stress.ipsec_icmp                 | 168 +++++++-------
 runtest/net_stress.ipsec_sctp                 | 212 +++++++++---------
 runtest/net_stress.ipsec_tcp                  | 212 +++++++++---------
 runtest/net_stress.ipsec_udp                  | 208 ++++++++---------
 testcases/lib/tst_net.sh                      |  59 +++--
 testcases/lib/tst_test.sh                     |   3 +
 testcases/network/stress/dccp/dccp_ipsec.sh   |  34 +--
 .../network/stress/dccp/dccp_ipsec_vti.sh     |  34 +--
 .../network/stress/icmp/icmp-uni-basic.sh     |  54 ++---
 testcases/network/stress/icmp/icmp-uni-vti.sh |  39 ++--
 testcases/network/stress/ipsec/ipsec_lib.sh   | 171 +++++++-------
 testcases/network/stress/sctp/sctp_ipsec.sh   |  35 +--
 .../network/stress/sctp/sctp_ipsec_vti.sh     |  35 +--
 testcases/network/stress/tcp/tcp_ipsec.sh     |  37 +--
 testcases/network/stress/tcp/tcp_ipsec_vti.sh |  36 +--
 testcases/network/stress/udp/udp_ipsec.sh     |  39 +---
 testcases/network/stress/udp/udp_ipsec_vti.sh |  39 +---
 testcases/network/virt/geneve01.sh            |  57 ++---
 testcases/network/virt/gre01.sh               |  46 ++--
 testcases/network/virt/ipvlan01.sh            |  29 +--
 testcases/network/virt/macsec01.sh            |  44 +---
 testcases/network/virt/macsec02.sh            |  47 +---
 testcases/network/virt/macsec_lib.sh          |  60 +++++
 testcases/network/virt/macvlan01.sh           |  29 +--
 testcases/network/virt/macvtap01.sh           |  29 +--
 testcases/network/virt/virt_lib.sh            | 212 ++++++------------
 testcases/network/virt/vlan01.sh              |  35 +--
 testcases/network/virt/vlan02.sh              |  28 +--
 testcases/network/virt/vlan03.sh              |  65 +++---
 testcases/network/virt/vxlan01.sh             |  31 +--
 testcases/network/virt/vxlan02.sh             |  32 +--
 testcases/network/virt/vxlan03.sh             |  53 ++---
 33 files changed, 999 insertions(+), 1425 deletions(-)
 create mode 100755 testcases/network/virt/macsec_lib.sh

-- 
2.17.1

