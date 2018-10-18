From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Oct 2018 13:24:33 +0200
Subject: [LTP] [PATCH 6/6] posix: Update README
In-Reply-To: <20181018112433.9554-1-pvorel@suse.cz>
References: <20181018112433.9554-1-pvorel@suse.cz>
Message-ID: <20181018112433.9554-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Robust Mutex Tests has been removed in
a0896f695 ("Remove the robust thread posix testcases.")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../functional/threads/pi_test/README         | 20 -------------------
 1 file changed, 20 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/README b/testcases/open_posix_testsuite/functional/threads/pi_test/README
index dca5b5f2f..ae644c96c 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/README
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/README
@@ -28,26 +28,6 @@ watchdog timer to kill the pi mutex tests if they fail.
 For different tests, there are different result analysis methods. The
 following two sections will describe this in detail.
 
-Robust Mutex Tests
-------------------------
-The tests are under <rtnptl-tests>/robust_test directory.
-
-rt-nptl supports 'robust' behavior, there will be two robust modes,
-one is PTHREAD_MUTEX_ROBUST mode, the other is
-PTHREAD_MUTEX_ROBUST_SUN_NP mode. When the owner of a mutex dies in
-the first mode, the waiter will set the mutex to ENOTRECOVERABLE
-state, while in the second mode, the waiter needs to call
-pthread_mutex_setconsistency_np to change the state manually.
-
-The tests with name robust*-sun are used to test the
-PTHREAD_MUTEX_ROBUST mode, other tests with name robust*-mode2 are
-used to test the PTHREAD_MUTEX_ROBUST_SUN_NP mode. Please refer to the
-description in the tests for the detailed information.
-
-Using run.sh under <rtnptl-tests>/robust_test to run the robust mutex
-tests automatically, the PASS or FAIL result can be obtained from the
-stdout.
-
 Priority Inheritance Mutex Tests
 --------------------------
 The tests are under <rtnptl-tests>/pi_test directory.
-- 
2.19.1

