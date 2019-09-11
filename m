From: Wu,Haiqiang <frequentemail@126.com>
Date: Wed, 11 Sep 2019 20:13:39 +0800
Subject: [LTP] [PATCH] [Fixes]:#570
Message-ID: <20190911121339.1359-1-frequentemail@126.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
 testcases/kernel/syscalls/dup2/dup201.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
index 4507ac19a..066428edf 100644
--- a/testcases/kernel/syscalls/dup2/dup201.c
+++ b/testcases/kernel/syscalls/dup2/dup201.c
@@ -75,9 +75,6 @@ int maxfd;
 int goodfd = 5;
 int badfd = -1;
 int mystdout = 0;
-int fd, fd1;
-int mypid;
-char fname[20];
 
 struct test_case_t {
 	int *ofd;
@@ -86,17 +83,14 @@ struct test_case_t {
 	void (*setupfunc) ();
 } TC[] = {
 	/* First fd argument is less than 0 - EBADF */
-	{
-	&badfd, &goodfd, EBADF, NULL},
+	{&badfd, &goodfd, EBADF, NULL},
 	    /* First fd argument is getdtablesize() - EBADF */
-	{
-	&maxfd, &goodfd, EBADF, NULL},
+	{&maxfd, &goodfd, EBADF, NULL},
 	    /* Second fd argument is less than 0 - EBADF */
-	{
-	&mystdout, &badfd, EBADF, NULL},
+	{&mystdout, &badfd, EBADF, NULL},
 	    /* Second fd argument is getdtablesize() - EBADF */
-	{
-&mystdout, &maxfd, EBADF, NULL},};
+	{&mystdout, &maxfd, EBADF, NULL},
+};
 
 int main(int ac, char **av)
 {
@@ -137,12 +131,6 @@ int main(int ac, char **av)
 					 strerror(TC[i].error));
 			}
 		}
-		/* cleanup things in case we are looping */
-		for (j = fd1; j < maxfd; j++) {
-			sprintf(fname, "dup201.%d.%d", j, mypid);
-			(void)close(j);
-			(void)unlink(fname);
-		}
 	}
 	cleanup();
 
@@ -163,7 +151,6 @@ void setup(void)
 
 	/* get some test specific values */
 	maxfd = getdtablesize();
-	mypid = getpid();
 }
 
 /*
@@ -172,6 +159,5 @@ void setup(void)
  */
 void cleanup(void)
 {
-
 	tst_rmdir();
 }
-- 
Wu,Haiqiang<frequentemail@126.com>

