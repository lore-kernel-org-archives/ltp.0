From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Jul 2018 09:42:00 +0200
Subject: [LTP] [PATCH v3 0/9] Migrate tests using virt_lib.sh
	and	ipsec_lib.sh to new API
Message-ID: <20180703074209.911-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I addressed issues noted by Alexey
changes v2->v3:
* tst_net.sh: Added TST_LIB_NET_LOADED and simplify that commit.
* tst_net.sh: changes in tst_net.sh split into 2 commits (TST_LIB_NET_LOADED related
one and "Harden library against deadlocks")
* macsec_lib.sh: Move code from virt_macsec_setup to macsec_lib_setup
* virt_lib.sh: Remove unused client_requests=20000

@cyril: tst_test.sh: We use TST_LIB_NET_LOADED (3/8), but I kept TST_LIB_LOADED
(2/8) as I think it's an improvement, even not used yet.

Petr Vorel (9):
  net/ipsec: Improve log info messages
  tst_test.sh: Introduce TST_LIB_LOADED
  tst_net.sh: Introduce TST_LIB_NET_LOADED
  tst_net.sh: Harden library against deadlocks
  net/ipsec: Use ':' as array separator for -s parameter
  net/{stress,virt}: Use SPDX-License-Identifier GPL-2.0-or-later
  net/virt_lib.sh: Remove possibility to pass custom sizes to
    virt_netperf_msg_sizes()
  net/{stress,virt}: Migrate virt_lib.sh, ipsec_lib.sh + tests using
    them
  net/virt: Introduce macsec_lib.sh to reduce duplicity

 runtest/net_stress.ipsec_dccp                 | 212 ++++++++---------
 runtest/net_stress.ipsec_icmp                 | 168 +++++++-------
 runtest/net_stress.ipsec_sctp                 | 212 ++++++++---------
 runtest/net_stress.ipsec_tcp                  | 212 ++++++++---------
 runtest/net_stress.ipsec_udp                  | 208 ++++++++---------
 testcases/lib/tst_net.sh                      |  35 ++-
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
 testcases/network/virt/macsec_lib.sh          |  55 +++++
 testcases/network/virt/macvlan01.sh           |  29 +--
 testcases/network/virt/macvtap01.sh           |  29 +--
 testcases/network/virt/virt_lib.sh            | 213 ++++++------------
 testcases/network/virt/vlan01.sh              |  35 +--
 testcases/network/virt/vlan02.sh              |  28 +--
 testcases/network/virt/vlan03.sh              |  65 +++---
 testcases/network/virt/vxlan01.sh             |  31 +--
 testcases/network/virt/vxlan02.sh             |  32 +--
 testcases/network/virt/vxlan03.sh             |  53 ++---
 33 files changed, 984 insertions(+), 1412 deletions(-)
 create mode 100755 testcases/network/virt/macsec_lib.sh

-- 
2.18.0

