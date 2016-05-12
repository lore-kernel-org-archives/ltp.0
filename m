From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 12 May 2016 16:14:23 +0300
Subject: [LTP] [PATCH V2 1/4] memcg_process_stress: cleanup
Message-ID: <1463058866-17188-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Plus added simple error handling for sigaction() calls.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * left the getpagesize() call as is

 .../memcg/stress/memcg_process_stress.c            |   33 +++++++++----------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
index 92627fe..eaed5a8 100644
--- a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
+++ b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
@@ -28,16 +28,14 @@
 #include <string.h>
 #include <unistd.h>
 
-int flag_exit;
-int flag_ready;
-
-int interval;
-unsigned long memsize;
-
-char **pages;
-int nr_page;
-
-void touch_memory()
+static volatile int flag_exit;
+static volatile int flag_ready;
+static int interval;
+static unsigned long memsize;
+static char **pages;
+static int nr_page;
+
+static void touch_memory(void)
 {
 	int i;
 
@@ -45,7 +43,7 @@ void touch_memory()
 		pages[i][0] = 0xef;
 }
 
-void sigusr_handler(int __attribute__ ((unused)) signo)
+static void sigusr_handler(int __attribute__ ((unused)) signo)
 {
 	int i;
 	int pagesize;
@@ -56,19 +54,19 @@ void sigusr_handler(int __attribute__ ((unused)) signo)
 
 	pages = calloc(nr_page, sizeof(char *));
 	if (pages == NULL)
-		errx(1, "calloc failed");
+		err(1, "calloc");
 
 	for (i = 0; i < nr_page; i++) {
 		pages[i] = mmap(NULL, pagesize, PROT_WRITE | PROT_READ,
 				MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 		if (pages[i] == MAP_FAILED)
-			err(1, "map failed\n");
+			err(1, "mmap");
 	}
 
 	flag_ready = 1;
 }
 
-void sigint_handler(int __attribute__ ((unused)) signo)
+static void sigint_handler(int __attribute__ ((unused)) signo)
 {
 	flag_exit = 1;
 }
@@ -91,14 +89,15 @@ int main(int argc, char *argv[])
 	if (interval <= 0)
 		interval = 1;
 
-	/* TODO (garrcoop): add error handling. */
 	memset(&sigint_action, 0, sizeof(sigint_action));
 	sigint_action.sa_handler = &sigint_handler;
-	sigaction(SIGINT, &sigint_action, NULL);
+	if (sigaction(SIGINT, &sigint_action, NULL))
+		err(1, "sigaction(SIGINT)");
 
 	memset(&sigusr_action, 0, sizeof(sigusr_action));
 	sigusr_action.sa_handler = &sigusr_handler;
-	sigaction(SIGUSR1, &sigusr_action, NULL);
+	if (sigaction(SIGUSR1, &sigusr_action, NULL))
+		err(1, "sigaction(SIGUSR1)");
 
 	while (!flag_exit) {
 		sleep(interval);
-- 
1.7.1

