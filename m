From: TAKAHASHI Tetsuya <takahashi.tetsuya.cis@canon-is.co.jp>
Date: Thu, 17 Dec 2015 05:54:55 +0000
Subject: [LTP] [PATCH] syscalls/creat/creat09: fix error check of create
 syscall
Message-ID: <330BE2030BD7834286495D8B7FCF1FB71D338D22@mbx01.itr.canon-is.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello.

I think that a create syscall check of syscalls/creat/creat09 is wrong.

When create syscall cannot make a file, the test result becomes PASS.
In this case, the test result becomes FAIL is right.


diff -uprN a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
--- a/testcases/kernel/syscalls/creat/creat09.c	2015-12-03 05:53:41.000000000 +0900
+++ b/testcases/kernel/syscalls/creat/creat09.c	2015-12-06 01:48:34.757125367 +0900
@@ -139,9 +139,13 @@ int main(int ac, char **av)
 
 		TEST(creat(fname, 0700));
 
-		if (TEST_RETURN == -1) {
+		if (TEST_RETURN != -1) {
 			tst_resm(TPASS, "creat(%s, 0700) returned %ld",
 				 fname, TEST_RETURN);
+		} else {
+			tst_resm(TFAIL | TTERRNO, "creat(%s, 0700) FAILED",
+				 fname);
+			continue;
 		}
 
 		/* close and remove file, possibly for next loop */


