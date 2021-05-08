From: Li Wang <liwang@redhat.com>
Date: Sat,  8 May 2021 13:51:05 +0800
Subject: [LTP] [PATCH v3 0/4] shell: Fix orphan timeout sleep processes
Message-ID: <20210508055109.16914-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I fix up tiny issues of Joerg's patch and resend with combine my
two follow-up new fixes together to be review.

V2 --> v3
 use sleep command in timeout tests
 fix code indent issue
 fix a bug in _tst_kill_test for kill looping
 limit the "kill $sleep_pid; eixt" action

Joerg Vehlow (2):
  shell: Extend timeout tests
  shell: Prevent orphan timeout sleep processes

Li Wang (2):
  lib: ignore SIGINT in _tst_kill_test
  lib: reset SIGTERM to original disposition if timeout occured

 lib/newlib_tests/shell/test_timeout.sh | 178 ++++++++++++++++++++++---
 lib/newlib_tests/shell/timeout03.sh    |   4 +-
 lib/newlib_tests/shell/timeout04.sh    |  22 +++
 testcases/lib/tst_test.sh              |  32 +++--
 4 files changed, 204 insertions(+), 32 deletions(-)
 create mode 100755 lib/newlib_tests/shell/timeout04.sh

-- 
2.30.2

