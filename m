From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Sep 2019 16:16:03 +0200
Subject: [LTP] [PATCH v4 0/7] net/route: rewrite route-change-{dst, gw,
 if} into new API
Message-ID: <20190903141610.28887-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

this version address functionality problems you pointed out.
But yet there might need to be another version as I'm not sure about
tst_ipaddr_un() API changes.

Changes v3-v4:
* enhanced tst_ipaddr_un() with -b, -h -l, -m, -n and -p options (-p was
previous -m)
* use tst_ipaddr_un() options to fix address clash on host_id, net_id clash fix
by adjusting $1 in test (this is really inconsistent, see note at 3/7).
* added tests for tst_ipaddr_un()
* quiet EXPECT_PASS ping$TST_IPV6

Kind regards,
Petr

Petr Vorel (7):
  tst_net.sh: enhance tst_add_ipaddr(), add tst_del_ipaddr()
  tst_net.sh: Add -p option to return prefix in tst_ipaddr_un()
  tst_net.sh: Add (mostly) HOST_ID related options to tst_ipaddr_un
  net: Add tst_ipaddr_un.sh test
  network/route: Rewrite route{4,6}-change-dst into new shell API
  network/route: Rewrite route{4,6}-change-gw into new shell API
  network/route: Rewrite route{4,6}-change-if into new API

 lib/newlib_tests/net/tst_ipaddr_un.sh         | 239 +++++++++++++
 runtest/net_stress.route                      |  15 +-
 testcases/lib/tst_net.sh                      | 196 +++++++++--
 .../network/stress/route/00_Descriptions.txt  |  54 +--
 .../network/stress/route/route-change-dst.sh  |  34 ++
 .../network/stress/route/route-change-gw.sh   |  39 +++
 .../network/stress/route/route-change-if.sh   |  90 +++++
 testcases/network/stress/route/route-lib.sh   |  17 +
 .../network/stress/route/route4-change-dst    | 276 ---------------
 .../network/stress/route/route4-change-gw     | 292 ----------------
 .../network/stress/route/route4-change-if     | 324 ------------------
 .../network/stress/route/route6-change-dst    | 272 ---------------
 .../network/stress/route/route6-change-gw     | 292 ----------------
 .../network/stress/route/route6-change-if     | 323 -----------------
 14 files changed, 595 insertions(+), 1868 deletions(-)
 create mode 100755 lib/newlib_tests/net/tst_ipaddr_un.sh
 create mode 100755 testcases/network/stress/route/route-change-dst.sh
 create mode 100755 testcases/network/stress/route/route-change-gw.sh
 create mode 100755 testcases/network/stress/route/route-change-if.sh
 create mode 100644 testcases/network/stress/route/route-lib.sh
 delete mode 100644 testcases/network/stress/route/route4-change-dst
 delete mode 100644 testcases/network/stress/route/route4-change-gw
 delete mode 100644 testcases/network/stress/route/route4-change-if
 delete mode 100644 testcases/network/stress/route/route6-change-dst
 delete mode 100644 testcases/network/stress/route/route6-change-gw
 delete mode 100644 testcases/network/stress/route/route6-change-if

-- 
2.22.1

