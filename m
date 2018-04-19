From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Apr 2018 21:55:00 +0200
Subject: [LTP] [RFC PATCH v3 07/10] ima/ima_mmap: Reduce sleep + log it
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Message-ID: <20180419195503.7194-8-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Sleep reduced to 3s (30s is way too much).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/src/ima_mmap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/src/ima_mmap.c b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
index 335f8525c..9045e79a0 100644
--- a/testcases/kernel/security/integrity/ima/src/ima_mmap.c
+++ b/testcases/kernel/security/integrity/ima/src/ima_mmap.c
@@ -25,6 +25,8 @@
 char *TCID = "ima_mmap";
 int TST_TOTAL = 1;
 
+#define SLEEP_AFTER_CLOSE 3
+
 int main(int argc, char *argv[])
 {
 	int fd;
@@ -47,7 +49,10 @@ int main(int argc, char *argv[])
 		return (-1);
 	}
 	close(fd);
-	sleep(30);
+
+	tst_resm(TINFO, "sleep %ds", SLEEP_AFTER_CLOSE);
+	sleep(SLEEP_AFTER_CLOSE);
+
 	if (munmap(file, 1024) < 0) {
 		perror("unmap");
 		return (-1);
-- 
2.16.3

