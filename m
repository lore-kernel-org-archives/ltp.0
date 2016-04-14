From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 14 Apr 2016 13:39:23 +0800
Subject: [LTP] [PATCH] waitpid/waitpid10: break test if fork failed
In-Reply-To: <20160413123625.GD10941@rei.lan>
References: <20160413071111.GA26897@localhost.localdomain>
 <20160413123625.GD10941@rei.lan>
Message-ID: <20160414053923.GH17476@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 13, 2016 at 02:36:25PM +0200, Cyril Hrubis wrote:
> > +static void kill_children();
>                            ^
> 			   missing void
> >  static int fail;
> > +static int fork_kid_pid[MAXKIDS] = { 0 };
>                                         ^
> 					global variables are
> 					initialized to 0 automatically,
> 					no need for explicit
> 					initialization.
> 
> >  #ifdef UCLINUX
> >  static char *argv0;
> > @@ -92,7 +94,7 @@ int main(int ac, char **av)
> >  {
> >  	int kid_count, ret_val, status, nkids;
> >  	int i, j, k, found;
> > -	int fork_kid_pid[MAXKIDS], wait_kid_pid[MAXKIDS];
> > +	int wait_kid_pid[MAXKIDS];
> >  	int runtime;		/* time(sec) to run this process */
> >  
> >  	int lc;
> > @@ -178,7 +180,8 @@ int main(int ac, char **av)
> >  #endif
> >  			}
> >  			if (ret_val < 0) {
> > -				tst_resm(TFAIL, "Fork kid 0 failed. errno = "
> > +				tst_brkm(TBROK|TERRNO, cleanup,
> > +					 "Fork kid 0 failed. errno = "
> >  					 "%d", errno);
> >  
> >  			}
> > @@ -196,8 +199,10 @@ int main(int ac, char **av)
> >  #endif
> >  			}
> >  			if (ret_val < 0) {
> > -				tst_resm(TFAIL, "Fork kid 1 failed. errno = "
> > -					 "%d", errno);
> > +				tst_resm(TBROK|TERRNO, "Fork kid 1 failed");
> > +				kill_children();
> > +				cleanup();
> > +				tst_exit();
> 
> This is too ugly. What about killing the children in the test cleanup()
> instead and zeroing the array that stores the pids at end of the test
> iteration. We have to zero it anyway so that this works correctly when
> test is executed with -i or -I. Then we could simply do
> tst_brkm(TBROK|TERRNO, cleanup, "fork() failed"); here instead.
> 

Thanks. Please review this new patch.

From 2614c4011a194cbb1c48461a5691905c072a08b8 Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Wed, 13 Apr 2016 11:25:20 +0800
Subject: [PATCH] waitpid/waitpid10: break test if fork failed

Or a lot of processes will be killed when -1 passed as pid to kill()

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid10.c | 43 ++++++++++++++++-----------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid10.c b/testcases/kernel/syscalls/waitpid/waitpid10.c
index 6378ab9..2725aaf 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid10.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid10.c
@@ -83,6 +83,7 @@ static void do_sleep(void);
 static void do_mkdir(void);
 
 static int fail;
+static int fork_kid_pid[MAXKIDS];
 
 #ifdef UCLINUX
 static char *argv0;
@@ -92,7 +93,7 @@ int main(int ac, char **av)
 {
 	int kid_count, ret_val, status, nkids;
 	int i, j, k, found;
-	int fork_kid_pid[MAXKIDS], wait_kid_pid[MAXKIDS];
+	int wait_kid_pid[MAXKIDS];
 	int runtime;		/* time(sec) to run this process */
 
 	int lc;
@@ -178,8 +179,8 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 0 failed. errno = "
-					 "%d", errno);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "Fork kid 0 failed.");
 
 			}
 
@@ -196,8 +197,8 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 1 failed. errno = "
-					 "%d", errno);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "Fork kid 1 failed.");
 
 			}
 
@@ -214,8 +215,8 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 2 failed. errno = "
-					 "%d", errno);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "Fork kid 2 failed.");
 
 			}
 
@@ -232,8 +233,8 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 3 failed. errno = "
-					 "%d", errno);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "Fork kid 3 failed.");
 
 			}
 
@@ -250,8 +251,8 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 4 failed. errno = "
-					 "%d", errno);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "Fork kid 4 failed.");
 
 			}
 
@@ -268,8 +269,8 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 5 failed. errno = "
-					 "%d", errno);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "Fork kid 5 failed.");
 
 			}
 
@@ -286,8 +287,8 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 6 failed. errno = "
-					 "%d", errno);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "Fork kid 6 failed.");
 
 			}
 
@@ -304,8 +305,8 @@ int main(int ac, char **av)
 #endif
 			}
 			if (ret_val < 0) {
-				tst_resm(TFAIL, "Fork kid 7 failed. errno = "
-					 "%d", errno);
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "Fork kid 7 failed.");
 
 			}
 
@@ -330,6 +331,8 @@ int main(int ac, char **av)
 				}
 			}
 
+			memset(fork_kid_pid, 0, sizeof(fork_kid_pid));
+
 			/* Wait till all kids have terminated. */
 			kid_count = 0;
 			errno = 0;
@@ -401,6 +404,12 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	int i;
+
+	for (i = 0; i < MAXKIDS; i++) {
+		if (fork_kid_pid[i] > 0)
+			kill(fork_kid_pid[i], 9);
+	}
 }
 
 static void alrmhandlr(void)
-- 
1.9.3

