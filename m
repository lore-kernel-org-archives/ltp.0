From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 09:28:33 +0200
Subject: [LTP] [RFC PATCH v6 0/5] Add TST_TEST_DATA and	TST_TEST_DATA_IFS +
	cleanup
Message-ID: <20180601072838.13196-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Changes v5->v6:
Fixes bugs reported by Alexey:
* Removed wrong _tst_i increment in for loop
* Fix doc:
-When '$TST_TEST_DATA' is used with '$TST_CNT', here used with space as default
-'$TST_TEST_DATA_IFS' value Similar it would be using these variables with
-separate functions.
+'$TST_TEST_DATA' can be used with '$TST_CNT'. If '$TST_TEST_DATA_IFS' not specified,
+space as default value is used. Of course, it's possible to use separate functions.

Hopefully ready to merge.

Kind regards,
Petr


Petr Vorel (5):
  tst_test.sh: Hide "private" variables with "_tst_" prefix
  tst_test.sh: Warn about using "private" variable or function
  tst_test.sh: Filter out commented out lines from warnings
  tst_test.sh: s/resm/res/
  tst_test.sh: Add TST_TEST_DATA and TST_TEST_DATA_IFS

 doc/test-writing-guidelines.txt |  79 ++++++++++++++++++++++++++---
 testcases/lib/tst_test.sh       | 110 +++++++++++++++++++++++++---------------
 2 files changed, 141 insertions(+), 48 deletions(-)

-- 
2.16.3

