From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Jun 2021 23:48:03 +0200
Subject: [LTP] [PATCH v3 0/5] Run tests in CI
Message-ID: <20210629214808.18760-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

changes v2->v3:
* going back to simplest changes in make
* adding lib/newlib_tests/runtest.sh (instead fighting with our build
  system I concentrated on runtest.sh)
* removing tst_fuzzy_sync01 as it sporadically fails

Tested:
https://github.com/pevik/ltp/actions/runs/984224611

TODO: Not what's wrong with PATH on CentOS 7:
/__w/ltp/ltp/lib/newlib_tests/runtest.sh: line 78: ./test05: No such file or directory
./shell/net/../../../../testcases/lib/tst_test.sh: line 149: tst_rod: command not found

Maybe it's in different directory?
It uses old make 3.82, there is something incompatible.

Kind regards,
Petr

Petr Vorel (5):
  tst_device: Require root
  lib: Add script for running tests
  make: Add make test{, -c, -shell} targets
  build.sh: Add support for make test
  CI: Run also make test

 .github/workflows/ci.yml      |   3 +
 Makefile                      |  10 +++
 build.sh                      |  18 ++++-
 lib/newlib_tests/runtest.sh   | 120 ++++++++++++++++++++++++++++++++++
 lib/newlib_tests/tst_device.c |   1 +
 5 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100755 lib/newlib_tests/runtest.sh

-- 
2.32.0

