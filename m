From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Oct 2017 17:05:14 +0200
Subject: [LTP] [PATCH 6/6] lib: drop tst_ipc_envp
In-Reply-To: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
References: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
Message-ID: <4a1551be48b06fc8bb607b44d84126ed9027c2a0.1507647255.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There are no users left.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/tst_checkpoint.h | 1 -
 lib/tst_test.c           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
index fdce2d6f70b6..d6f7607abade 100644
--- a/include/tst_checkpoint.h
+++ b/include/tst_checkpoint.h
@@ -37,6 +37,5 @@
         tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0);
 
 extern const char *tst_ipc_path;
-extern char *const tst_ipc_envp[];
 
 #endif /* TST_CHECKPOINT__ */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 78cce19b6e4a..184a9f06aa72 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -64,7 +64,6 @@ extern unsigned int tst_max_futexes;
 
 static char ipc_path[1024];
 const char *tst_ipc_path = ipc_path;
-char *const tst_ipc_envp[] = {ipc_path, NULL};
 
 static char shm_path[1024];
 
-- 
1.8.3.1

