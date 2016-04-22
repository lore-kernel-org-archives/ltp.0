From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 22 Apr 2016 18:23:08 +0300
Subject: [LTP] [PATCH 2/4] memcg_process_stress: allocate memory not in the
	signal handler
In-Reply-To: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1461338590-1309-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1461338590-1309-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since it's considered as bad practice.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../memcg/stress/memcg_process_stress.c            |   32 +++++++++++++-------
 1 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
index c2569bb..9c93f0d 100644
--- a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
+++ b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
@@ -35,22 +35,14 @@ static unsigned long memsize;
 static char **pages;
 static int nr_page;
 
-static void touch_memory(void)
-{
-	int i;
-
-	for (i = 0; i < nr_page; i++)
-		pages[i][0] = 0xef;
-}
-
-static void sigusr_handler(int __attribute__ ((unused)) signo)
+static void alloc_memory(void)
 {
 	int i;
 	int pagesize;
 
 	pagesize = sysconf(_SC_PAGE_SIZE);
 
-	nr_page = ceil((double)memsize / pagesize);
+	nr_page = memsize / pagesize;
 
 	pages = calloc(nr_page, sizeof(char *));
 	if (pages == NULL)
@@ -62,7 +54,18 @@ static void sigusr_handler(int __attribute__ ((unused)) signo)
 		if (pages[i] == MAP_FAILED)
 			err(1, "mmap");
 	}
+}
 
+static void touch_memory(void)
+{
+	int i;
+
+	for (i = 0; i < nr_page; i++)
+		pages[i][0] = 0xef;
+}
+
+static void sigusr_handler(int __attribute__ ((unused)) signo)
+{
 	flag_ready = 1;
 }
 
@@ -76,6 +79,7 @@ int main(int argc, char *argv[])
 	char *end;
 	struct sigaction sigint_action;
 	struct sigaction sigusr_action;
+	int allocated = 0;
 
 	if (argc != 3)
 		errx(1, "wrong argument num");
@@ -102,8 +106,14 @@ int main(int argc, char *argv[])
 	while (!flag_exit) {
 		sleep(interval);
 
-		if (flag_ready)
+		if (flag_ready) {
+			if (!allocated) {
+				alloc_memory();
+				allocated = 1;
+			}
+
 			touch_memory();
+		}
 	}
 
 	return 0;
-- 
1.7.1

