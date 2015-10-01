From: TAKAHASHI Tetsuya <takahashi.tetsuya.cis@canon-is.co.jp>
Date: Thu, 1 Oct 2015 04:28:07 +0000
Subject: [LTP] [PATCH] syscalls/mallopt: Does not work correctly?
Message-ID: <330BE2030BD7834286495D8B7FCF1FB71C99B4FB@mbx01.itr.canon-is.co.jp>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello.

About testcase "syscalls/mallopt", I had 2 questions.
(Are there bugs?)
1. System call mallopt() returns 1 on Success, and 0 on Failure.
   But, testcase does not check it's. 
2. In case of using "M_MXFAST" param, allowed values are in the range 0 to 80*sizeof(size_t)/4.
   (since glibc 2.3)
   http://linux.die.net/man/3/mallopt
   But, testcase sets fixed value "2048".
   "mallopt(M_MXFAST, 2048)" always return FAIL. 

Therefore, I suggest to adding following functions.
1. Checking mallopt() return values.
2. Setting tests value is 0 and 80*sizeof(size_t)/4. 


--- a/testcases/kernel/syscalls/mallopt/mallopt01.c 2015-09-08 18:37:03.000000000 +0900
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c 2015-09-10 16:20:44.471493667 +0900
@@ -51,6 +51,7 @@
 
 #define FAILED 0
 #define PASSED 1
+#define MAX_FAST_SIZE (80 * sizeof(size_t) / 4)
 
 int local_flag = PASSED;
 
@@ -71,7 +72,8 @@ int main(int argc, char *argv[])
 
  tst_tmpdir();
 
- buf = SAFE_MALLOC(NULL, 20480);
+ if ((buf = SAFE_MALLOC(NULL, 20480)) == NULL)
+  tst_brkm(TBROK, NULL, "malloc failed");
 
  /*
   * Check space usage.
@@ -86,16 +88,41 @@ int main(int argc, char *argv[])
   printinfo();
   tst_resm(TFAIL, "mallinfo failed: smblks != 0");
  }
+ if (info.uordblks >= 20480 && info.smblks == 0)
+  tst_resm(TPASS, "mallinfo() succeeded");
  free(buf);
 
  /*
   * Test mallopt's M_MXFAST and M_NLBLKS cmds.
   */
- mallopt(M_MXFAST, 2048);
- mallopt(M_NLBLKS, 50);
- buf = SAFE_MALLOC(NULL, 1024);
+ if (mallopt(M_MXFAST, MAX_FAST_SIZE) == 0)
+  tst_resm(TFAIL, "mallopt(M_MXFAST, %d) failed", MAX_FAST_SIZE);
+ else
+  tst_resm(TPASS, "mallopt(M_MXFAST, %d) succeeded", MAX_FAST_SIZE);
+
+ if (mallopt(M_NLBLKS, 50) == 0)
+  tst_resm(TFAIL, "mallopt(M_NLBLKS, 50) failed");
+ else
+  tst_resm(TPASS, "mallopt(M_NLBLKS, 50) succeeded");
+
+ if ((buf = SAFE_MALLOC(NULL, 1024)) == NULL)
+  tst_resm(TFAIL, "malloc(1024) failed");
+ else {
+  tst_resm(TPASS, "malloc(1024) succeeded");
+  free(buf);
+ }
 
- free(buf);
+ if (mallopt(M_MXFAST, 0) == 0)
+  tst_resm(TFAIL, "mallopt(M_MXFAST, 0) failed");
+ else
+  tst_resm(TPASS, "mallopt(M_MXFAST, 0) succeeded");
+
+ if ((buf = SAFE_MALLOC(NULL, 1024)) == NULL)
+  tst_resm(TFAIL, "malloc(1024) failed");
+ else {
+  tst_resm(TPASS, "malloc(1024) succeeded");
+  free(buf);
+ }
 
  unlink("core");
  tst_rmdir();
