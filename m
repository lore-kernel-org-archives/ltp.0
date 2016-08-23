From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 23 Aug 2016 14:25:53 +0300
Subject: [LTP] [PATCH V2 2/4] memcg/functional/memcg_process: cleanup
In-Reply-To: <1471951555-4230-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1471951555-4230-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1471951555-4230-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
No changes since V1.

 .../controllers/memcg/functional/memcg_process.c   |   49 ++++++++++----------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_process.c b/testcases/kernel/controllers/memcg/functional/memcg_process.c
index c12fae1..4ad2d6f 100644
--- a/testcases/kernel/controllers/memcg/functional/memcg_process.c
+++ b/testcases/kernel/controllers/memcg/functional/memcg_process.c
@@ -35,20 +35,20 @@
 #include <string.h>
 #include <unistd.h>
 
-int fd;
+static int fd;
 
-int flag_exit;
-int flag_allocated;
+static volatile int flag_exit;
+static volatile int flag_allocated;
 
-int opt_mmap_anon;
-int opt_mmap_file;
-int opt_mmap_lock1;
-int opt_mmap_lock2;
-int opt_shm;
-int opt_hugepage;
+static int opt_mmap_anon;
+static int opt_mmap_file;
+static int opt_mmap_lock1;
+static int opt_mmap_lock2;
+static int opt_shm;
+static int opt_hugepage;
 
-int key_id;			/* used with opt_shm */
-unsigned long memsize;
+static int key_id;			/* used with opt_shm */
+static unsigned long memsize;
 
 #define FILE_HUGEPAGE	"/hugetlb/hugepagefile"
 
@@ -59,7 +59,7 @@ unsigned long memsize;
 #define SHM		(SCHAR_MAX + 5)
 #define HUGEPAGE	(SCHAR_MAX + 6)
 
-const struct option long_opts[] = {
+static const struct option long_opts[] = {
 	{"mmap-anon", 0, NULL, MMAP_ANON},
 	{"mmap-file", 0, NULL, MMAP_FILE},
 	{"mmap-lock1", 0, NULL, MMAP_LOCK1},
@@ -74,7 +74,7 @@ const struct option long_opts[] = {
 /*
  * process_options: read options from user input
  */
-void process_options(int argc, char *argv[])
+static void process_options(int argc, char *argv[])
 {
 	int c;
 	char *end;
@@ -117,7 +117,7 @@ void process_options(int argc, char *argv[])
 /*
  * touch_memory: force allocating phy memory
  */
-void touch_memory(char *p, int size)
+static void touch_memory(char *p, int size)
 {
 	int i;
 	int pagesize = getpagesize();
@@ -126,7 +126,7 @@ void touch_memory(char *p, int size)
 		p[i] = 0xef;
 }
 
-void mmap_anon()
+static void mmap_anon(void)
 {
 	static char *p;
 
@@ -142,7 +142,7 @@ void mmap_anon()
 	}
 }
 
-void mmap_file()
+static void mmap_file(void)
 {
 	static char *p;
 	static int fd_hugepage;
@@ -177,7 +177,7 @@ void mmap_file()
 	}
 }
 
-void mmap_lock1()
+static void mmap_lock1(void)
 {
 	static char *p;
 
@@ -193,7 +193,7 @@ void mmap_lock1()
 	}
 }
 
-void mmap_lock2()
+static void mmap_lock2(void)
 {
 	static char *p;
 
@@ -215,7 +215,7 @@ void mmap_lock2()
 	}
 }
 
-void shm()
+static void shm(void)
 {
 	static char *p;
 	static int shmid;
@@ -258,7 +258,7 @@ void shm()
 /*
  * sigint_handler: handle SIGINT by set the exit flag.
  */
-void sigint_handler(int __attribute__ ((unused)) signo)
+static void sigint_handler(int __attribute__ ((unused)) signo)
 {
 	flag_exit = 1;
 }
@@ -272,7 +272,7 @@ void sigint_handler(int __attribute__ ((unused)) signo)
  * When we receive SIGUSR again, we will free all the allocated
  * memory.
  */
-void sigusr_handler(int __attribute__ ((unused)) signo)
+static void sigusr_handler(int __attribute__ ((unused)) signo)
 {
 	if (opt_mmap_anon)
 		mmap_anon();
@@ -303,14 +303,15 @@ int main(int argc, char *argv[])
 	memset(&sigint_action, 0, sizeof(sigint_action));
 	memset(&sigusr_action, 0, sizeof(sigusr_action));
 
-	/* TODO: add error handling below. */
 	sigemptyset(&sigint_action.sa_mask);
 	sigint_action.sa_handler = &sigint_handler;
-	sigaction(SIGINT, &sigint_action, NULL);
+	if (sigaction(SIGINT, &sigint_action, NULL))
+		err(1, "sigaction(SIGINT)");
 
 	sigemptyset(&sigusr_action.sa_mask);
 	sigusr_action.sa_handler = &sigusr_handler;
-	sigaction(SIGUSR1, &sigusr_action, NULL);
+	if (sigaction(SIGUSR1, &sigusr_action, NULL))
+		err(1, "sigaction(SIGUSR1)");
 
 	process_options(argc, argv);
 
-- 
1.7.1

