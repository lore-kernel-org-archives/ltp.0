From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:19:57 +0200
Subject: [LTP] [PATCH v5 0/4] Run tests in CI
Message-ID: <20210714142001.20566-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v4->v5:
* don't exit on test failure, but continue testing (Cyril)
* rename tst_{brk,res}() to runtest_{brk,res}() (Cyril)
* rewritten summary, put everything to the end
* merged 3 already acked commits

$ make test
...

runtest TINFO: === C TEST RESULTS ===
runtest TINFO: 13x TPASS: test05 test07 test09 test12 test15 test18 tst_bool_expr test_exec test_timer tst_res_hexd tst_strstatus tst_fuzzy_sync02 tst_fuzzy_sync03
runtest TINFO: 0x TFAIL:
runtest TINFO: 0x TBROK:
runtest TINFO: 0x TWARN:
runtest TINFO: 0x TCONF:

...

runtest TINFO: === SHELL TEST RESULTS ===
runtest TINFO: 2x TPASS: shell/tst_check_driver.sh shell/net/tst_ipaddr_un.sh
runtest TINFO: 0x TFAIL:
runtest TINFO: 0x TBROK:
runtest TINFO: 0x TWARN:
runtest TINFO: 1x TCONF: shell/net/tst_rhost_run.sh

runtest TINFO: === FINAL TEST RESULTS ===
runtest TPASS: All C tests TCONF/TPASS
runtest TPASS: All shell tests TCONF/TPASS

Petr Vorel (4):
  lib: Add script for running tests
  make: Add make test{, -c, -shell} targets
  build.sh: Add support for make test
  CI: Run also make test

 .github/workflows/ci.yml    |   5 ++
 Makefile                    |  23 +++++
 build.sh                    |  22 ++++-
 lib/newlib_tests/runtest.sh | 175 ++++++++++++++++++++++++++++++++++++
 4 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100755 lib/newlib_tests/runtest.sh

-- 
2.32.0

