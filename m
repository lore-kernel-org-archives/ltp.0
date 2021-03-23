From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 23 Mar 2021 21:57:30 +0800
Subject: [LTP] [PATCH] syscalls/setns: Replace libc function with safe_macros
Message-ID: <20210323135730.24806-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For those:
	testcases/kernel/syscalls/setns/setns.h
	testcases/kernel/syscalls/setns/setns02.c

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/setns/setns.h   | 6 ++----
 testcases/kernel/syscalls/setns/setns02.c | 6 +++---
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/setns/setns.h b/testcases/kernel/syscalls/setns/setns.h
index c2097f2e5..f46a55a7b 100644
--- a/testcases/kernel/syscalls/setns/setns.h
+++ b/testcases/kernel/syscalls/setns/setns.h
@@ -19,9 +19,7 @@ static int get_ns_fd(int pid, const char *ns)

 	sprintf(tmp, "/proc/%d/ns/%s", pid, ns);
 	if (stat(tmp, &st) == 0) {
-		fd = open(tmp, O_RDONLY);
-		if (fd == -1)
-			tst_brk(TBROK|TERRNO, "failed to open %s", tmp);
+		SAFE_OPEN(tmp, O_RDONLY);
 	} else {
 		if (errno != ENOENT)
 			tst_brk(TBROK|TERRNO, "failed to stat %s", tmp);
@@ -58,5 +56,5 @@ static void close_ns_fds(void)

 	for (i = 0; i < ns_total; i++)
 		if (ns_fds[i] != -1)
-			close(ns_fds[i]);
+			SAFE_CLOSE(ns_fds[i]);
 }
diff --git a/testcases/kernel/syscalls/setns/setns02.c b/testcases/kernel/syscalls/setns/setns02.c
index 0e20c52e4..db442541b 100644
--- a/testcases/kernel/syscalls/setns/setns02.c
+++ b/testcases/kernel/syscalls/setns/setns02.c
@@ -168,11 +168,11 @@ static void setup(void)
 static void cleanup(void)
 {
 	if (ns_ipc_fd != -1)
-		close(ns_ipc_fd);
+		SAFE_CLOSE(ns_ipc_fd);
 	if (ns_uts_fd != -1)
-		close(ns_uts_fd);
+		SAFE_CLOSE(ns_uts_fd);

-	shmctl(shmid, IPC_RMID, NULL);
+	SAFE_SHMCTL(shmid, IPC_RMID, NULL);
 }

 static struct tst_test test = {
--
2.17.1

