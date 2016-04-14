From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Thu, 14 Apr 2016 11:09:28 +0800
Subject: [LTP] [PATCH] waitpid/waitpid03: break test if fork failed
In-Reply-To: <20160413125535.GF10941@rei.lan>
References: <20160412132256.GA7441@localhost.localdomain>
 <20160412155230.GB2917@rei.suse.cz>
 <20160413065818.GF17476@localhost.localdomain>
 <20160413125535.GF10941@rei.lan>
Message-ID: <20160414030928.GG17476@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 13, 2016 at 02:55:35PM +0200, Cyril Hrubis wrote:
> Hi!
> > Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> > ---
> >  testcases/kernel/syscalls/waitpid/waitpid03.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/testcases/kernel/syscalls/waitpid/waitpid03.c b/testcases/kernel/syscalls/waitpid/waitpid03.c
> > index 2599a92..7e9d45c 100644
> > --- a/testcases/kernel/syscalls/waitpid/waitpid03.c
> > +++ b/testcases/kernel/syscalls/waitpid/waitpid03.c
> > @@ -106,7 +106,16 @@ int main(int argc, char **argv)
> >  				if (DEBUG)
> >  					tst_resm(TINFO, "child # %d", ikids);
> >  			} else if (pid[ikids] == -1) {
> > -				tst_resm(TFAIL, "cannot open fork #%d", ikids);
> > +				int i;
> > +
> > +				tst_resm(TBROK|TERRNO, "cannot open fork #%d",
> > +					 ikids);
> > +
> > +				for (i = 1; i < ikids; i++)
> > +					kill(pid[i], 9);
> > +
> > +				cleanup();
> > +				tst_exit();
> 
> This one is ugly. Why don't we kill the children in the test cleanup()
> here as well. This should be easy, just store the number of allready
> forked kids in a global variable and reset it to zero right after they
> were killed in the main loop.
> 
Thanks. Please reveiw this new patch.


From 8b7c289ac51ec2e169bbe0147d4c1c3d1f08aa0b Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Tue, 12 Apr 2016 11:12:28 +0800
Subject: [PATCH] waitpid/waitpid03: break test if fork failed

If continue after the fork failure, a lot of processes may be killed by
the kill() on line 125.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid03.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid03.c b/testcases/kernel/syscalls/waitpid/waitpid03.c
index 2599a92..4b3f7a7 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid03.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid03.c
@@ -64,6 +64,8 @@ int TST_TOTAL = 1;
 
 #define	MAXUPRC	25
 
+static int ikids;
+static int pid[MAXUPRC];
 static int condition_number;
 
 #ifdef UCLINUX
@@ -75,7 +77,7 @@ int main(int argc, char **argv)
 {
 	int lc;
 
-	int status, pid[25], ret;
+	int status, ret;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
 #ifdef UCLINUX
@@ -87,7 +89,6 @@ int main(int argc, char **argv)
 	/* check for looping state if -i option is given */
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		/* reset tst_count in case we are looping */
-		int ikids = 0;
 		tst_count = 0;
 
 		/*
@@ -106,7 +107,9 @@ int main(int argc, char **argv)
 				if (DEBUG)
 					tst_resm(TINFO, "child # %d", ikids);
 			} else if (pid[ikids] == -1) {
-				tst_resm(TFAIL, "cannot open fork #%d", ikids);
+				tst_brkm(TBROK|TERRNO, cleanup, "cannot open "
+					"fork #%d", ikids);
+
 			} else {
 #ifdef UCLINUX
 				if (self_exec(argv[0], "d", ikids) < 0) {
@@ -125,6 +128,7 @@ int main(int argc, char **argv)
 			kill(pid[ikids], 15);
 		}
 
+		ikids = 0;
 		condition_number = 1;
 
 		/* Wait on one specific child */
@@ -185,4 +189,6 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	while (ikids-- > 1)
+		kill(pid[ikids], 9);
 }
-- 
1.9.3

