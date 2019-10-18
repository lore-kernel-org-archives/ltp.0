From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Fri, 18 Oct 2019 14:44:57 +0200
Subject: [LTP] [PATCH v4 0/5] tst_test.sh: Use LTP_TIMEOUT_MUL in
 TST_RETRY_FN()
Message-ID: <20191018124502.25599-1-cfamullaconrad@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* tst_test.sh:
  Force one parameter and fix bashisms.
  But I still need two time eval.
* test_timeout_mul.sh:
  Formatting, but don't add PATH somewhere, as we wait for a runner.
* Mention LTP_TIMEOUT_MUL usage in TST_RETRY_FN() in doc


Clemens Famulla-Conrad (5):
  tst_test.sh: Use LTP_TIMEOUT_MUL in TST_RETRY_FN()
  tst_test.c: Add tst_multiply_timeout()
  tst_common.h: Use tst_multiply_timeout in TST_RETRY_FN()
  Add newlib shell test for tst_multiply_timeout()
  Adopt doc for TST_RETRY_FUNC for LTP_TIMEOUT_MUL

 doc/test-writing-guidelines.txt            |  3 ++-
 include/tst_common.h                       |  6 +++--
 include/tst_test.h                         |  1 +
 lib/newlib_tests/shell/test_timeout_mul.sh | 43 ++++++++++++++++++++++++++++++
 lib/tst_test.c                             | 43 ++++++++++++++++++++++--------
 testcases/lib/tst_test.sh                  | 34 ++++++++++++++++-------
 6 files changed, 106 insertions(+), 24 deletions(-)
 create mode 100755 lib/newlib_tests/shell/test_timeout_mul.sh

--
2.16.4

