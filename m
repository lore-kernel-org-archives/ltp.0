From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 10:30:47 +0200
Subject: [LTP] [PATCH v6 0/5] 	Run tests in CI
Message-ID: <20210715083052.7138-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

changes v5->v6:
* add new commit suggested by Cyril: "lib: Print Summary: into stderr"
* fix final error evaluation for C tests in runtest.sh
* run C and shell test separately (test-c and test-shell instead of
  test). Having them separate helps to easily navigate in CI. This
  required to add support to build.sh.

Hope this is a final version.

Kind regards,
Petr

Petr Vorel (5):
  lib: Print Summary: into stderr
  lib: Add script for running tests
  make: Add make test{, -c, -shell} targets
  build.sh: Add support for make test{,-c,-shell}
  CI: Run also make test-c, test-shell

 .github/workflows/ci.yml    |  10 ++
 Makefile                    |  23 +++++
 build.sh                    |  24 ++++-
 lib/newlib_tests/runtest.sh | 182 ++++++++++++++++++++++++++++++++++++
 lib/tst_test.c              |  12 +--
 5 files changed, 244 insertions(+), 7 deletions(-)
 create mode 100755 lib/newlib_tests/runtest.sh

-- 
2.32.0

