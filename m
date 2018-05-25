From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 May 2018 23:57:20 +0200
Subject: [LTP] [RFC PATCH v5 0/5] tst_test.sh: Add TST_TEST_DATA and
	TST_TEST_DATA_IFS + cleanup
Message-ID: <20180525215725.7218-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

hope I replaced all variables, which are needed and updated all places
in docs.

changes v4->v5:
* Loop in TST_TEST_DATA with for loop instead of while. It's needed to
allow having empty parameter (needed for IPsec network tests). This
brought dependencies to: cut tr wc.
* Updated docs correctly.
* Added commit "tst_test.sh: Filter out commented out lines from warnings"
* Added commit "tst_test.sh: s/resm/res/"


Kind regards,
Petr

Petr Vorel (5):
  tst_test.sh: Hide "private" variables with "_tst_" prefix
  tst_test.sh: Warn about using "private" variable or function
  tst_test.sh: Filter out commented out lines from warnings
  tst_test.sh: s/resm/res/
  tst_test.sh: Add TST_TEST_DATA and TST_TEST_DATA_IFS

 doc/test-writing-guidelines.txt |  80 ++++++++++++++++++++++++++---
 testcases/lib/tst_test.sh       | 111 +++++++++++++++++++++++++---------------
 2 files changed, 143 insertions(+), 48 deletions(-)

-- 
2.16.3

