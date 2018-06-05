From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Tue,  5 Jun 2018 16:06:22 +0200
Subject: [LTP] [PATCH 0/2] Create new library helper: tst_getconf
Message-ID: <20180605140624.7114-1-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello everyone,

I previously sent a patch to fix the issue I got with "getconf"
which may not available in some embedded systems [1][2].

Cyril proposed to implement a tst_getconf to implement subset of
variables [3]. Based on his remark, I implemented it and I use "sysconf"
function that allows to retrieve configuration's variables at runtime[4].
Thanks to that, we are not depending anymore on a binary and we can retrieve
variables such as PAGESIZE or _SC_NPROCESSORS_ONLN.

The first patch adds this new library and the second patch replaces
"getconf" by "tst_getconf" in all the tests.

If you have any review/remark, do not hesitate!
Thank you in advance,
Mylène

[1]: http://lists.linux.it/pipermail/ltp/2018-April/007836.html
[2]: http://lists.linux.it/pipermail/ltp/2018-April/007835.html
[3]: http://lists.linux.it/pipermail/ltp/2018-April/007842.html
[4]: http://man7.org/linux/man-pages/man3/sysconf.3.html

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
 testcases/lib/tst_getconf.c                        | 57 ++++++++++++++++++++++
 11 files changed, 83 insertions(+), 10 deletions(-)
 create mode 100644 testcases/lib/tst_getconf.c

-- 
2.11.0

