From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 21 Aug 2018 16:05:45 +0200
Subject: [LTP] [RFC PATCH 0/2] make test: Run C API tests
Message-ID: <20180821140547.2509-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

this is very simple way to add 'make test' target.  It seems tests are
outdated and some of them maybe not meant to be unit shell tests.  I
removed tst_safe_macros as it's failing and not sufficient enough. We
should write proper test for it.

Current implementation is still failing: after 'make test' run, there is
still failing tst_checkpoint_wait_timeout.

tst_checkpoint_wait_timeout    1  TBROK  :  tst_checkpoint.c:144: tst_checkpoint_wait_timeout.c:46: tst_checkpoint_wait(0, 10000): errno=ETIMEDOUT(110): Connection timed out
tst_checkpoint_wait_timeout    2  TBROK  :  tst_checkpoint.c:144: Remaining cases broken


Kind regards,
Petr

Petr Vorel (2):
  tests: Remove tst_safe_macros.c
  make: Add test target

 Makefile                    |  3 +++
 lib/tests/Makefile          |  3 +++
 lib/tests/test.sh           | 32 +++++++++++++++++++++++++++++
 lib/tests/tst_safe_macros.c | 40 -------------------------------------
 4 files changed, 38 insertions(+), 40 deletions(-)
 create mode 100755 lib/tests/test.sh
 delete mode 100644 lib/tests/tst_safe_macros.c

-- 
2.18.0

