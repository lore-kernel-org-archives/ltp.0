From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Tue, 12 Apr 2016 21:13:24 +0800
Subject: [LTP] [PATCH] waitpid/waitpid02: check if fork failed
In-Reply-To: <20160412100536.GB24915@rei.lan>
References: <20160412030310.GA10416@localhost.localdomain>
 <20160412100536.GB24915@rei.lan>
Message-ID: <20160412131324.GC17476@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 12, 2016 at 12:05:36PM +0200, Cyril Hrubis wrote:
> Hi!
> >  		} else {
> > +			if (pid < 0) {
> > +				tst_brkm(TBROK|TERRNO, cleanup, "fork failed");
> > +			}
> 
> The check should be done right after the fork() and not in the else
> branch. Also there shoudln't be the curly braces around the tst_brkm()
> since it's just a signle line.
> 
> Otherwise it's fine.
> 
Thanks. This is the new patch.


From 9785b11acc164725a5e93766ec08d199831fd7e5 Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Mon, 11 Apr 2016 23:46:34 +0800
Subject: [PATCH] waitpid/waitpid02: check if fork failed

Break the test if fork failed. Or this test case will kill a lot of
processes on the system.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/waitpid/waitpid02.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid02.c b/testcases/kernel/syscalls/waitpid/waitpid02.c
index e5d7957..7d3a65c 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid02.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid02.c
@@ -88,6 +88,9 @@ int main(int argc, char **argv)
 
 		pid = FORK_OR_VFORK();
 
+		if (pid < 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "fork failed");
+
 		if (pid == 0) {
 #ifdef UCLINUX
 			self_exec(argv[0], "");
-- 
1.9.3

