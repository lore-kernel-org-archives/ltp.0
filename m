From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Oct 2017 08:17:19 -0400 (EDT)
Subject: [LTP] [PATCH 2/2 v2] security/dirtyc0w: synchronize parent and
 child
In-Reply-To: <20171009144307.GC25633@rei.lan>
References: <94518262a76edca533440acb73611eb93184dc90.1507290372.git.jstancek@redhat.com>
 <0d87a0f1b598e710e21ebbabf316c39610e5d47f.1507290372.git.jstancek@redhat.com>
 <20171009144307.GC25633@rei.lan>
Message-ID: <1756862615.28187529.1507637839493.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > +		(void)execvpe(TEST_APP, av, tst_ipc_envp);
> > +		tst_brk(TBROK|TERRNO, "exec failed");
> 
> Can we please add SAFE_EXECVPE() to the library?
> 
> Other than that it looks good to me, acked.

I ran into a problem with older distros - execvpe() does not
exist there. How about we stay with execlp() and export
LTP_IPC_PATH by default, so that child inherits it?

Regards,
Jan

---

Subject: [PATCH/RFC] lib: add LTP_IPC_PATH to env. variables by default

Child started by exec() that needs to do tst_reinit() in order
to use checkpoints will inherit LTP_IPC_PATH by default.
Parent can choose to override/omit it in envp array when calling
exec[lvp]e().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 233b370794a6..27a0b7c36679 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -100,10 +100,12 @@ static void setup_ipc(void)
        results = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, ipc_fd, 0);

        /* Checkpoints needs to be accessible from processes started by exec() */
-       if (tst_test->needs_checkpoints)
+       if (tst_test->needs_checkpoints) {
                sprintf(ipc_path, IPC_ENV_VAR "=%s", shm_path);
-       else
+               putenv(ipc_path);
+       } else {
                SAFE_UNLINK(shm_path);
+       }

        SAFE_CLOSE(ipc_fd);

