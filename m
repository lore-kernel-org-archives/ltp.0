From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 20:41:43 +0100
Subject: [LTP] [RFC PATCH v2 5/6] tst_test.sh: Run _tst_setup_timer after
 $TST_SETUP
In-Reply-To: <20210129194144.31299-1-pvorel@suse.cz>
References: <20210129194144.31299-1-pvorel@suse.cz>
Message-ID: <20210129194144.31299-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Postpone starting timer a bit after the execution allow to setup
timer in test setup. This is useful if test length depends on input
decided during setup.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

Hi,

I'm ok, if you consider this risky.
Next commit can be then changed to have TST_TIMEOUT=-1.

Kind regards,
Petr

 doc/test-writing-guidelines.txt | 5 ++++-
 testcases/lib/tst_test.sh       | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index f3a55cf26..61dccd400 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2398,7 +2398,10 @@ simply by setting right '$TST_NEEDS_FOO'.
 | 'TST_TIMEOUT'      | Maximum timeout set for the test in sec. Must be int >= 1,
                        or -1 (special value to disable timeout), default is 300.
                        Variable is meant be set in tests, not by user.
-                       It's equivalent of `tst_test.timeout` in C.
+                       It's equivalent of `tst_test.timeout` in C, but (unlike
+                       the C API) it can be set also in the setup function.
+                       This is useful if test length depends on input decided
+                       during setup.
 |=============================================================================
 
 NOTE: Network tests (see testcases/network/README.md) use additional variables
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 69f007d89..4fa1674cd 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -552,8 +552,6 @@ tst_run()
 			tst_brk TCONF "test requires kernel $TST_MIN_KVER+"
 	fi
 
-	_tst_setup_timer
-
 	[ "$TST_NEEDS_DEVICE" = 1 ] && TST_NEEDS_TMPDIR=1
 
 	if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
@@ -594,6 +592,8 @@ tst_run()
 		fi
 	fi
 
+	_tst_setup_timer
+
 	#TODO check that test reports some results for each test function call
 	while [ $TST_ITERATIONS -gt 0 ]; do
 		if [ -n "$TST_TEST_DATA" ]; then
-- 
2.30.0

