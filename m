From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Tue, 12 Apr 2016 21:19:05 +0800
Subject: [LTP] [PATCH] ptrace/ptrace05: preventing kill other processes
 if fork failed
In-Reply-To: <20160412100858.GC24915@rei.lan>
References: <20160412030734.GA11627@localhost.localdomain>
 <20160412100858.GC24915@rei.lan>
Message-ID: <20160412131905.GD17476@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 12, 2016 at 12:08:59PM +0200, Cyril Hrubis wrote:
> Hi!
> > If fork failed, we should try next signum. Or the kill(-1, 9) on line
> > 196 will kill a lot of processes.
> > 
> > Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
> > ---
> >  testcases/kernel/syscalls/ptrace/ptrace05.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
> > index d610cc0..e717319 100644
> > --- a/testcases/kernel/syscalls/ptrace/ptrace05.c
> > +++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
> > @@ -99,7 +99,7 @@ int main(int argc, char **argv)
> >  		switch (child = fork()) {
> >  		case -1:
> >  			tst_resm(TBROK | TERRNO, "Failed to fork properly.");
> > -			break;
> > +			continue;
> 
> I would just change this to tst_brkm(). There is no point in continuing
> the test if fork() starts failing.
> 
Please review the new patch. Thanks.


From ee7ba40a79644a9039d0cc581f78e8708aef8b06 Mon Sep 17 00:00:00 2001
From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Tue, 12 Apr 2016 09:13:57 +0800
Subject: [PATCH] ptrace/ptrace05: preventing kill other processes if fork
 failed

If fork failed, we should try next signum. Or the kill(-1, 9) on line
196 will kill a lot of processes.

Signed-off-by: Han Pingtian <hanpt@linux.vnet.ibm.com>
---
 testcases/kernel/syscalls/ptrace/ptrace05.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
index d610cc0..db611e7 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace05.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
@@ -98,8 +98,8 @@ int main(int argc, char **argv)
 
 		switch (child = fork()) {
 		case -1:
-			tst_resm(TBROK | TERRNO, "Failed to fork properly.");
-			break;
+			tst_brkm(TBROK | TERRNO, NULL, 
+				 "Failed to fork properly.");
 		case 0:
 
 			if (ptrace(PTRACE_TRACEME, 0, NULL, NULL) != -1) {
-- 
1.9.3

