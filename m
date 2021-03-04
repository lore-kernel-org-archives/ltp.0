From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 4 Mar 2021 10:21:27 +0800
Subject: [LTP] [PATCH] syscalls/getpid01.c: Remove unneeded TTERRNO and
 status
Message-ID: <20210304022127.535431-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/getpid/getpid01.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/getpid/getpid01.c b/testcases/kernel/syscalls/getpid/getpid01.c
index 229172a64..326ee5840 100644
--- a/testcases/kernel/syscalls/getpid/getpid01.c
+++ b/testcases/kernel/syscalls/getpid/getpid01.c
@@ -15,7 +15,7 @@
 static void verify_getpid(void)
 {
 	pid_t pid_max, pid;
-	int status, i;
+	int i;
 
 	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
 
@@ -28,11 +28,11 @@ static void verify_getpid(void)
 			if (1 < pid && pid <= pid_max)
 				tst_res(TPASS, "getpid() returns %d", pid);
 			else
-				tst_res(TFAIL | TTERRNO,
+				tst_res(TFAIL,
 					"getpid() returns out of range: %d", pid);
 			exit(0);
 		} else {
-			SAFE_WAIT(&status);
+			SAFE_WAIT(NULL);
 		}
 	}
 }
-- 
2.25.1



