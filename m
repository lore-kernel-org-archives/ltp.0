From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Oct 2017 17:05:13 +0200
Subject: [LTP] [PATCH 5/6] creat07: no need to pass tst_ipc_envp anymore
In-Reply-To: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
References: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
Message-ID: <70f47d3c63fb849eeba0a6bb4f2760d4815db3cb.1507647255.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Now that env. variable LTP_IPC_PATH is inherited by default,
it's not necessary to pass tst_ipc_envp anymore.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/creat/creat07.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat07.c b/testcases/kernel/syscalls/creat/creat07.c
index e1b267661c39..236f4edf843f 100644
--- a/testcases/kernel/syscalls/creat/creat07.c
+++ b/testcases/kernel/syscalls/creat/creat07.c
@@ -38,9 +38,7 @@ static void verify_creat(void)
 
 	pid = SAFE_FORK();
 	if (pid == 0) {
-		char *av[] = {TEST_APP, NULL};
-		(void)execve(TEST_APP, av, tst_ipc_envp);
-		perror("execve failed");
+		SAFE_EXECLP(TEST_APP, TEST_APP, NULL);
 		exit(1);
 	}
 
-- 
1.8.3.1

