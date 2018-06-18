From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Jun 2018 19:37:01 +0200
Subject: [LTP] [PATCH 0/6] Migrate tests using virt_lib.sh and ipsec_lib.sh
	to new API
Message-ID: <20180618173707.30351-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this is a big patch rewriting virt_lib.sh and ipsec_lib.sh libraries +
23 tests depending on it. It was needed to migrate it all in once, as
macsec0{1,2}.sh tests are using both libraries.
I tried to use TST_TEST_DATA as much as I could, but still there are
tests which needs to use for loop and thus have the same TST_CNT number
for many iterations.

Comments are welcome.
Testing is even more welcome. It took me some time to fix all bugs, but
there might be still some.


Kind regards,
Petr

Petr Vorel (6):
  net/ipsec: Improve log info messages
  tst_test.sh: Introduce TST_LIB_LOADED
  tst_net.sh: Harden against multiple loading
  net/ipsec: Use ':' as array separator for -s parameter
  net/{stress,virt}: Use SPDX-License-Identifier GPL-2.0-or-later
  net/{stress,virt}: Migrate tests using virt_lib.sh and ipsec_lib.sh

 runtest/net_stress.ipsec_dccp                 | 212 +++++++++---------
 runtest/net_stress.ipsec_icmp                 | 168 +++++++-------
 runtest/net_stress.ipsec_sctp                 | 212 +++++++++---------
 runtest/net_stress.ipsec_tcp                  | 212 +++++++++---------
 runtest/net_stress.ipsec_udp                  | 208 ++++++++---------
 testcases/lib/tst_net.sh                      |  59 +++--
 testcases/lib/tst_test.sh                     |   1 +
 testcases/network/stress/dccp/dccp_ipsec.sh   |  34 +--
 .../network/stress/dccp/dccp_ipsec_vti.sh     |  34 +--
 .../network/stress/icmp/icmp-uni-basic.sh     |  54 ++---
 testcases/network/stress/icmp/icmp-uni-vti.sh |  39 ++--
 testcases/network/stress/ipsec/ipsec_lib.sh   | 155 ++++++-------
 testcases/network/stress/sctp/sctp_ipsec.sh   |  35 +--
 .../network/stress/sctp/sctp_ipsec_vti.sh     |  35 +--
 testcases/network/stress/tcp/tcp_ipsec.sh     |  37 +--
 testcases/network/stress/tcp/tcp_ipsec_vti.sh |  36 +--
 testcases/network/stress/udp/udp_ipsec.sh     |  39 +---
 testcases/network/stress/udp/udp_ipsec_vti.sh |  39 +---
 testcases/network/virt/geneve01.sh            |  57 ++---
 testcases/network/virt/gre01.sh               |  49 ++--
 testcases/network/virt/ipvlan01.sh            |  27 +--
 testcases/network/virt/macsec01.sh            |  45 ++--
 testcases/network/virt/macsec02.sh            |  47 ++--
 testcases/network/virt/macvlan01.sh           |  32 +--
 testcases/network/virt/macvtap01.sh           |  32 +--
 testcases/network/virt/virt_lib.sh            | 170 ++++++--------
 testcases/network/virt/vlan01.sh              |  35 +--
 testcases/network/virt/vlan02.sh              |  28 +--
 testcases/network/virt/vlan03.sh              |  65 +++---
 testcases/network/virt/vxlan01.sh             |  31 +--
 testcases/network/virt/vxlan02.sh             |  31 +--
 testcases/network/virt/vxlan03.sh             |  52 ++---
 32 files changed, 965 insertions(+), 1345 deletions(-)

-- 
2.17.1

