From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Wed, 13 Apr 2016 14:58:18 +0800
Subject: [LTP] [PATCH] waitpid/waitpid03: break test if fork failed
In-Reply-To: <20160412155230.GB2917@rei.suse.cz>
References: <20160412132256.GA7441@localhost.localdomain>
 <20160412155230.GB2917@rei.suse.cz>
Message-ID: <20160413065818.GF17476@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 12, 2016 at 05:52:41PM +0200, Cyril Hrubis wrote:
> Hi!
> > -				tst_resm(TFAIL, "cannot open fork #%d", ikids);
> > +				tst_brkm(TBROK|TERRNO, cleanup,
> > +					 "cannot open fork #%d", ikids);
> 
> I guess that we should kill any of the allready sleeping children at this point.
> 
> If we move the pid[] array to be global we can create a kill_children()
> function to send a signal to all pids in pid[] that are > 0 and call it
> if fork fails with SIGKILL as well as from the main loop with the
> SIGTERM as well.
> 
I think this one is better, please have a look. Thanks.


From aff8c1decee88bae37a8460ddce8d10a7a8f3d1a Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Tue, 12 Apr 2016 11:12:28 +0800
Subject: [PATCH] waitpid/waitpid03: break test if fork failed

If continue after the fork failure, a lot of processes may be killed by
the kill() on line 125.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid03.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid03.c b/testcases/kernel/syscalls/waitpid/waitpid03.c
index 2599a92..7e9d45c 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid03.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid03.c
@@ -106,7 +106,16 @@ int main(int argc, char **argv)
 				if (DEBUG)
 					tst_resm(TINFO, "child # %d", ikids);
 			} else if (pid[ikids] == -1) {
-				tst_resm(TFAIL, "cannot open fork #%d", ikids);
+				int i;
+
+				tst_resm(TBROK|TERRNO, "cannot open fork #%d",
+					 ikids);
+
+				for (i = 1; i < ikids; i++)
+					kill(pid[i], 9);
+
+				cleanup();
+				tst_exit();
 			} else {
 #ifdef UCLINUX
 				if (self_exec(argv[0], "d", ikids) < 0) {
-- 
1.9.3

