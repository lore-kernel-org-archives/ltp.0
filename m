From: Jan Stancek <jstancek@redhat.com>
Date: Wed,  8 Jun 2016 17:03:59 +0200
Subject: [LTP] [PATCH 2/2] lib/tst_test.c: do all cleanup in do_exit
In-Reply-To: <fa495176ab2cdec819046bb813af0066435ca88c.1465398038.git.jstancek@redhat.com>
References: <fa495176ab2cdec819046bb813af0066435ca88c.1465398038.git.jstancek@redhat.com>
Message-ID: <ae852d6bd04c7caa6e2e5be7fa319961ad220fd7.1465398038.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since previous patch, library process can exit only by calling
do_exit(). This patch moves all cleanup to do_cleanup(),
which is called only from a single place at do_exit().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 6e6d41738ebb..9f9a41b20919 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -64,6 +64,7 @@ char *const tst_ipc_envp[] = {ipc_path, NULL};
 
 static char shm_path[1024];
 
+static void do_cleanup(void);
 static void do_exit(int ret) __attribute__ ((noreturn));
 
 static void setup_ipc(void)
@@ -460,7 +461,7 @@ static void do_exit(int ret)
 	if (results->warnings)
 		ret |= TWARN;
 
-	cleanup_ipc();
+	do_cleanup();
 
 	exit(ret);
 }
@@ -577,6 +578,8 @@ static void do_cleanup(void)
 		tst_futexes = NULL;
 		tst_rmdir();
 	}
+
+	cleanup_ipc();
 }
 
 static void run_tests(void)
@@ -714,8 +717,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 
 	alarm(0);
 
-	do_cleanup();
-
 	if (WIFEXITED(status) && WEXITSTATUS(status))
 		do_exit(WEXITSTATUS(status));
 
-- 
1.8.3.1

