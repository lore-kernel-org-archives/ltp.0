From: frequent <frequentemail@126.com>
Date: Tue, 10 Sep 2019 18:20:33 +0800 (CST)
Subject: [LTP] [PATCH] buffer overflow detected ***: dup201 terminated
Message-ID: <424f5bc4.776d.16d1ab07134.Coremail.frequentemail@126.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Issues related to this mail: https://github.com/linux-test-project/ltp/issues/570


According to the bactrace in the issue description, we could easily find out that the problem is due to the codes in dup201.c  line 80 and 142. 
As metan-cuw commented, the loop at line 142 is of no use and probablely is a leftover.  So we could safely remove these codes. 


This patch does :
        1).  remove the leftover, and of course, the issue 570 will be eventually go over.
        2).  removed unused global variables.


The patch goes as:


diff --git a/testcases/kernel/syscalls/dup2/dup201.c b/testcases/kernel/syscalls/dup2/dup201.c
index 4507ac1..762ad86 100644
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
@@ -86,22 +83,19 @@ struct test_case_t {
        void (*setupfunc) ();
 } TC[] = {
        /* First fd argument is less than 0 - EBADF */
-       {
-       &badfd, &goodfd, EBADF, NULL},
-           /* First fd argument is getdtablesize() - EBADF */
-       {
-       &maxfd, &goodfd, EBADF, NULL},
-           /* Second fd argument is less than 0 - EBADF */
-       {
-       &mystdout, &badfd, EBADF, NULL},
-           /* Second fd argument is getdtablesize() - EBADF */
-       {
-&mystdout, &maxfd, EBADF, NULL},};
+       {&badfd, &goodfd, EBADF, NULL},
+       /* First fd argument is getdtablesize() - EBADF */
+       {&maxfd, &goodfd, EBADF, NULL},
+       /* Second fd argument is less than 0 - EBADF */
+       {&mystdout, &badfd, EBADF, NULL},
+       /* Second fd argument is getdtablesize() - EBADF */
+       {&mystdout, &maxfd, EBADF, NULL},
+};


 int main(int ac, char **av)
 {
        int lc;
-       int i, j;
+       int i;


        tst_parse_opts(ac, av, NULL, NULL);


@@ -137,12 +131,6 @@ int main(int ac, char **av)
                                         strerror(TC[i].error));
                        }
                }
-               /* cleanup things in case we are looping */
-               for (j = fd1; j < maxfd; j++) {
-                       sprintf(fname, "dup201.%d.%d", j, mypid);
-                       (void)close(j);
-                       (void)unlink(fname);
-               }
        }
        cleanup();


@@ -163,7 +151,6 @@ void setup(void)


        /* get some test specific values */
        maxfd = getdtablesize();
-       mypid = getpid();
 }


 /*
@@ -172,6 +159,5 @@ void setup(void)
  */
 void cleanup(void)
 {
-
        tst_rmdir();
 }

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190910/35edc0c8/attachment.htm>
