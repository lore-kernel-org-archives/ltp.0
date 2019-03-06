From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  6 Mar 2019 16:24:29 +0100
Subject: [LTP] [RFC PATCH 1/2] tst_test: Add test multiplex function
Message-ID: <20190306152430.25219-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test multiplex function is intended for running the test function in
a loop for a different settings. The indended purpose is to run tests
for both libc wrapper and raw syscall as well as for different syscall
variants.

The commit itself adds a test_multiplex() function into the tst_test
structure, if set this function is called in a loop before each test
iteration and is responsible for changing the test variant into next
one. The iterations continue until the function returns zero.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Mark Salyzyn <salyzyn@android.com>
CC: Steve Muckle <smuckle@google.com>
CC: Jan Stancek <jstancek@redhat.com>
---
 include/tst_test.h | 14 ++++++++++++++
 lib/tst_test.c     | 11 +++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index da41f776d..b747b24d5 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -146,6 +146,20 @@ struct tst_test {
 	 */
 	int all_filesystems:1;
 
+	/*
+	 * If set this function is used to mutiplex between different test
+	 * variants.
+	 *
+	 * Multiplexers are the way how to run the same test for different
+	 * settings. The intended use is to test different syscall
+	 * wrappers/variants but the API is generic and does not limit the
+	 * usage in any way.
+	 *
+	 * Each time the function is called it switches to next test variant,
+	 * returns zero if all variants has been iterated over.
+	 */
+	int (*test_multiplex)(void);
+
 	/* Minimal device size in megabytes */
 	unsigned int dev_min_size;
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 7dd890b8d..6b033c879 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1009,8 +1009,15 @@ static void testrun(void)
 		if (!cont)
 			break;
 
-		run_tests();
-		heartbeat();
+		if (tst_test->test_multiplex) {
+			while (tst_test->test_multiplex()) {
+				run_tests();
+				heartbeat();
+			}
+		} else {
+			run_tests();
+			heartbeat();
+		}
 	}
 
 	do_test_cleanup();
-- 
2.19.2

