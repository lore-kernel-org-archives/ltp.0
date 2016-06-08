From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jun 2016 15:55:29 +0200
Subject: [LTP] [PATCH v2] lib/tst_test.c: Run test in child process
In-Reply-To: <1570517895.4619774.1465392983796.JavaMail.zimbra@redhat.com>
References: <20160607115806.GA1740@rei.lan>
 <969277405.4512739.1465373864678.JavaMail.zimbra@redhat.com>
 <20160608123056.GA26573@rei.lan>
 <1836941003.4597191.1465390741285.JavaMail.zimbra@redhat.com>
 <20160608131515.GA27367@rei.lan>
 <1570517895.4619774.1465392983796.JavaMail.zimbra@redhat.com>
Message-ID: <20160608135528.GB27367@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Ah, right, that is since what was previously main_pid has been split
> > into the library process and main test process.
> > 
> > Indeed the cleanup_ipc() should be called from the library in the
> > tst_vbrk_().
> ...
> > Looks good to me, acked.
> 
> Pushed.

And looking at the code closely, this is not enough, since we have:

        if (WIFEXITED(status) && WEXITSTATUS(status))
		exit(WEXITSTATUS(status));

in the tst_run_tcases(). So we have to call cleanup_ipc() before the
exit() here as well.


Also we do not count the TBROK in results structure, since the TBROK is
propagated only by exit value so do_exit() will exit with 0 in case that
we TBROK in the test library.

This is getting more complicated than I would like.

Minimal patch to fix this would be:

diff --git a/lib/tst_test.c b/lib/tst_test.c
index f7485bd..67d778e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -237,7 +237,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
 		do_test_cleanup();
 
 	if (getpid() == lib_pid)
-		do_exit();
+		cleanup_ipc();
 
 	exit(TTYPE_RESULT(ttype));
 }
@@ -718,8 +718,10 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	do_cleanup();
 
-	if (WIFEXITED(status) && WEXITSTATUS(status))
+	if (WIFEXITED(status) && WEXITSTATUS(status)) {\
+		cleanup_ipc();
 		exit(WEXITSTATUS(status));
+	}
 
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
 		tst_res(TINFO, "If you are running on slow machine, "



Or we may change do_exit() to take parameter so that we can actually
pass the TBROK to it, in a case that you want to print the statistics in
this case as well...

-- 
Cyril Hrubis
chrubis@suse.cz
