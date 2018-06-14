From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Thu, 14 Jun 2018 09:22:04 +0200
Subject: [LTP] [PATCH v2 0/2] Create new library helper: tst_getconf
Message-ID: <20180614072206.23393-1-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello everyone,

This is a V2 of my series that handles the fact that "getconf"
may not available in some embedded systems.

I updated the patches according to Li Wang's review:
   - handle invalid arguments in tst_getconf
   - correct arguments in mkswap01.sh and numa01.sh

If you have any review/remark, do not hesitate!
Thank you in advance,
Mylène

Mylène Josserand (2):
  testcase: lib: Create tst_getconf to replace "getconf"
  testcases: Replace "getconf" by "tst_getconf"

 doc/test-writing-guidelines.txt                    | 14 +++++
 testcases/commands/du/du01.sh                      |  2 +-
 testcases/commands/mkswap/mkswap01.sh              |  2 +-
 .../controllers/cpuset/cpuset_regression_test.sh   |  2 +-
 .../memcg/control/memcg_control_test.sh            |  2 +-
 .../controllers/memcg/functional/memcg_lib.sh      |  4 +-
 testcases/kernel/numa/numa01.sh                    |  2 +-
 testcases/lib/.gitignore                           |  1 +
 testcases/lib/Makefile                             |  3 +-
 testcases/lib/test.sh                              |  4 +-
 testcases/lib/tst_getconf.c                        | 66 ++++++++++++++++++++++
 11 files changed, 92 insertions(+), 10 deletions(-)
 create mode 100644 testcases/lib/tst_getconf.c

-- 
2.11.0

