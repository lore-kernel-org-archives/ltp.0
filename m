From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 15:24:25 +0200
Subject: [LTP] [PATCH v5 0/8] net/route: rewrite route-change-{dst, gw,
 if} into new API
Message-ID: <20191011132433.24197-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v4->v5:
addressed these Alexey's requests:
* tst_ipadd_un() now handles both host_id and net_id, with
-h MIN,MAX, -n MIN,MAX
(instead of -b, -f, -n which handled only host_id)

* add -q to tst_add_ipaddr() (silence test output)

* introduce EXPECT_{FAIL,PASS}_BRK() to shell API and use it to stop
test on first error.

@Cyril the only commit for you: "shell: Introduce EXPECT_{FAIL,PASS}_BRK()"

Kind regards,
Petr

Petr Vorel (8):
  tst_net.sh: enhance tst_add_ipaddr(), add tst_del_ipaddr()
  tst_net.sh: Add -p option to return prefix in tst_ipaddr_un()
  tst_net.sh: Add -h -n options to tst_ipaddr_un()
  net: Add tst_ipaddr_un.sh test
  shell: Introduce EXPECT_{FAIL,PASS}_BRK()
  network/route: Rewrite route{4,6}-change-dst into new shell API
  network/route: Rewrite route{4,6}-change-gw into new shell API
  network/route: Rewrite route{4,6}-change-if into new API

 doc/test-writing-guidelines.txt               |   5 +-
 lib/newlib_tests/shell/net/tst_ipaddr_un.sh   | 167 +++++++++
 runtest/net_stress.route                      |  15 +-
 testcases/lib/tst_net.sh                      | 173 +++++++---
 testcases/lib/tst_test.sh                     |  34 +-
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
 16 files changed, 528 insertions(+), 1879 deletions(-)
 create mode 100755 lib/newlib_tests/shell/net/tst_ipaddr_un.sh
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
2.23.0

