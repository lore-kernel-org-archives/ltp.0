From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Jul 2021 12:13:31 +0200
Subject: [LTP] [PATCH v4 0/7] Run tests in CI
Message-ID: <20210713101338.6985-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v3->v4:
* don't run on cross compile build
* add 2 commits to fix tests on (tst_net.sh on dash and tst_strstatus.c
  on alpine)
* partly rewrite runtest.sh

tested
https://github.com/pevik/ltp/actions/runs/1026124767

Kind regards,
Petr

Petr Vorel (7):
  tst_device: Require root
  tst_net.sh: Declare prefix variable as empty
  tst_strstatus.c: Use musl compatible status number
  lib: Add script for running tests
  make: Add make test{, -c, -shell} targets
  build.sh: Add support for make test
  CI: Run also make test

 .github/workflows/ci.yml         |   5 ++
 Makefile                         |  23 +++++
 build.sh                         |  22 ++++-
 lib/newlib_tests/runtest.sh      | 148 +++++++++++++++++++++++++++++++
 lib/newlib_tests/tst_device.c    |   1 +
 lib/newlib_tests/tst_strstatus.c |   3 +-
 testcases/lib/tst_net.sh         |   2 +-
 7 files changed, 201 insertions(+), 3 deletions(-)
 create mode 100755 lib/newlib_tests/runtest.sh

-- 
2.32.0

