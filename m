From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Jul 2019 13:10:22 +0200
Subject: [LTP] [PATCH v3 0/5] net/route: rewrite route-change-{dst, gw,
 if} into new API
Message-ID: <20190725111027.18716-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

hope this version could be sufficient enough.

I've added some support to tst_net.sh for general IP address handling.

I'm thinking about adding support for adding general vlan support to
tst_net.sh instead of using add_macvlan() (virt_lib.sh, ipsec_lib.sh and dhcp_lib.sh would use it),
but that would be in separate patchset.

Kind regards,
Petr

Petr Vorel (5):
  tst_net.sh: enhance tst_add_ipaddr(), add tst_del_ipaddr()
  tst_net.sh: Add -m option to return mask in tst_ipaddr_un()
  network/route: Rewrite route-change-dst into new API
  network/route: Rewrite route-change-gw into new API
  network/route: Rewrite route-change-if into new API

 runtest/net_stress.route                      |  12 +-
 testcases/lib/tst_net.sh                      |  81 +++--
 .../network/stress/route/00_Descriptions.txt  |  54 +--
 .../network/stress/route/route-change-dst     |  33 ++
 .../network/stress/route/route-change-gw      |  38 ++
 .../network/stress/route/route-change-if      |  87 +++++
 testcases/network/stress/route/route-lib.sh   |  17 +
 .../network/stress/route/route4-change-dst    | 276 ---------------
 .../network/stress/route/route4-change-gw     | 292 ----------------
 .../network/stress/route/route4-change-if     | 324 ------------------
 .../network/stress/route/route6-change-dst    | 272 ---------------
 .../network/stress/route/route6-change-gw     | 292 ----------------
 .../network/stress/route/route6-change-if     | 323 -----------------
 13 files changed, 249 insertions(+), 1852 deletions(-)
 create mode 100755 testcases/network/stress/route/route-change-dst
 create mode 100755 testcases/network/stress/route/route-change-gw
 create mode 100755 testcases/network/stress/route/route-change-if
 create mode 100644 testcases/network/stress/route/route-lib.sh
 delete mode 100644 testcases/network/stress/route/route4-change-dst
 delete mode 100644 testcases/network/stress/route/route4-change-gw
 delete mode 100644 testcases/network/stress/route/route4-change-if
 delete mode 100644 testcases/network/stress/route/route6-change-dst
 delete mode 100644 testcases/network/stress/route/route6-change-gw
 delete mode 100644 testcases/network/stress/route/route6-change-if

-- 
2.22.0

