From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 5 Aug 2021 11:48:41 +0800
Subject: [LTP] [PATCH v1 1/3] libs/libnewipc: Alter get_used_queues api
Message-ID: <1628135323-3722-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rename get_used_queues as get_used_sysvipc and add a proc file argument, so we can use
GET_USED_QUEQUES() and GET_USED_SEGMENTS() to get the corresponding used sysvipc resource
total. Since no new api cases used get_used_queues(), we don't need to change anything.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/libnewipc.h           |  6 ++++--
 libs/libltpnewipc/libnewipc.c | 16 ++++++++--------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/libnewipc.h b/include/libnewipc.h
index 075364f85..52e054c51 100644
--- a/include/libnewipc.h
+++ b/include/libnewipc.h
@@ -49,9 +49,11 @@ key_t getipckey(const char *file, const int lineno);
 #define GETIPCKEY() \
 	getipckey(__FILE__, __LINE__)
 
-int get_used_queues(const char *file, const int lineno);
+int get_used_sysvipc(const char *file, const int lineno, const char *sysvipc_file);
 #define GET_USED_QUEUES() \
-	get_used_queues(__FILE__, __LINE__)
+	get_used_sysvipc(__FILE__, __LINE__, "/proc/sysvipc/msg")
+#define GET_USED_SEGMENTS() \
+	get_used_sysvipc(__FILE__, __LINE__, "/proc/sysvipc/shm")
 
 void *probe_free_addr(const char *file, const int lineno);
 #define PROBE_FREE_ADDR() \
diff --git a/libs/libltpnewipc/libnewipc.c b/libs/libltpnewipc/libnewipc.c
index d0974bbe0..583291ee0 100644
--- a/libs/libltpnewipc/libnewipc.c
+++ b/libs/libltpnewipc/libnewipc.c
@@ -48,25 +48,25 @@ key_t getipckey(const char *file, const int lineno)
 	return key;
 }
 
-int get_used_queues(const char *file, const int lineno)
+int get_used_sysvipc(const char *file, const int lineno, const char *sysvipc_file)
 {
 	FILE *fp;
-	int used_queues = -1;
+	int used = -1;
 	char buf[BUFSIZE];
 
-	fp = safe_fopen(file, lineno, NULL, "/proc/sysvipc/msg", "r");
+	fp = safe_fopen(file, lineno, NULL, sysvipc_file, "r");
 
 	while (fgets(buf, BUFSIZE, fp) != NULL)
-		used_queues++;
+		used++;
 
 	fclose(fp);
 
-	if (used_queues < 0) {
-		tst_brk(TBROK, "can't read /proc/sysvipc/msg to get "
-			"used message queues@%s:%d", file, lineno);
+	if (used < 0) {
+		tst_brk(TBROK, "can't read %s to get used sysvipc resource total "
+			"at %s:%d", sysvipc_file, file, lineno);
 	}
 
-	return used_queues;
+	return used;
 }
 
 void *probe_free_addr(const char *file, const int lineno)
-- 
2.23.0

