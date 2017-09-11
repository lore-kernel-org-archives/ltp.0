From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Sep 2017 16:53:42 +0200
Subject: [LTP] [PATCH] [COMMITTED] mtest06/shmat1: Fix build for undefined
	struct ucontext
Message-ID: <20170911145342.28035-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The struct ucontext was never supposed to be used, the only supported way how
to use this structure is to use ucontext_t instead.

This fixes build on i586 where we access the structure members (see the
ifdefs in the signal handler).

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/mtest06/shmat1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/mem/mtest06/shmat1.c b/testcases/kernel/mem/mtest06/shmat1.c
index 0d6d7a47a..875643083 100644
--- a/testcases/kernel/mem/mtest06/shmat1.c
+++ b/testcases/kernel/mem/mtest06/shmat1.c
@@ -109,7 +109,7 @@ int done_shmat = 0;		/* disallow read and writes before shmat      */
 /*									      */
 /******************************************************************************/
 static void sig_handler(int signal,	/* signal number, set to handle SIGALRM       */
-			int code, struct ucontext *ut)
+			int code, ucontext_t *ut)
 {				/* contains pointer to sigcontext structure   */
 #ifdef __i386__
 	unsigned long except;	/* exception type.                            */
-- 
2.13.0

