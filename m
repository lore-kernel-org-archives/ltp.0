From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Fri, 13 Jul 2018 11:09:31 +0200
Subject: [LTP] [PATCH v3 0/2] Create new library helper: tst_getconf
Message-ID: <20180713090933.11409-1-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello everyone,

This is a V3 of my series that handles the fact that "getconf"
may not available in some embedded systems. It creates a new
helper: tst_getconf.

Changes since v2:
   - use SPDX header
   - remove optind's code (Cyril Hrubis's review)
   - update the documentation (Cyril Hrubris's review)
   - handle both PAGE_SIZE/PAGESIZE (Li Wang's review)
   - update some part of the code such as new line (Li Wang's review)
   - add the two Reviewed-by of Li Wang
Changes since v1:
   - handle invalid arguments in tst_getconf
   - correct arguments in mkswap01.sh and numa01.sh

If you have any review/remark, do not hesitate!
Thank you in advance,
Mylène

Mylène Josserand (2):
  testcase: lib: Create tst_getconf to replace "getconf"
  testcases: Replace "getconf" by "tst_getconf"

 doc/test-writing-guidelines.txt                    | 14 ++++++
 testcases/commands/du/du01.sh                      |  2 +-
 testcases/commands/mkswap/mkswap01.sh              |  2 +-
 .../controllers/cpuset/cpuset_regression_test.sh   |  2 +-
 .../memcg/control/memcg_control_test.sh            |  2 +-
 .../controllers/memcg/functional/memcg_lib.sh      |  4 +-
 testcases/kernel/numa/numa01.sh                    |  2 +-
 testcases/lib/.gitignore                           |  1 +
 testcases/lib/Makefile                             |  3 +-
 testcases/lib/test.sh                              |  4 +-
 testcases/lib/tst_getconf.c                        | 51 ++++++++++++++++++++++
 11 files changed, 77 insertions(+), 10 deletions(-)
 create mode 100644 testcases/lib/tst_getconf.c

-- 
2.11.0

