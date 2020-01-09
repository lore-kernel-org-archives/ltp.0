From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Jan 2020 15:26:05 +0800
Subject: [LTP] [PATCH v2] syscalls/capget02: remove useless getpid()
Message-ID: <1578554765-30025-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since pid=0 returns the capabilities for the calling thread,
we can remove getpid. Also we can cover this test point.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
-----------------
v1-v2:
remove pid = 0 assignment, because it has been initialized as 0.
add comment
-----------------
---
 testcases/kernel/syscalls/capget/capget02.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/capget/capget02.c b/testcases/kernel/syscalls/capget/capget02.c
index 42c76a011..931632e47 100644
--- a/testcases/kernel/syscalls/capget/capget02.c
+++ b/testcases/kernel/syscalls/capget/capget02.c
@@ -69,15 +69,15 @@ static void verify_capget(unsigned int n)
 
 static void setup(void)
 {
-	unsigned int i, pid;
-
-	pid = getpid();
+	unsigned int i;
 
+	/*
+	 * Don't need to assign value to header.pid and bad_version_header.pid.
+	 * Because they have been initialized as 0 that it returns the capabilities
+	 * for the calling thread, equivalently to getpid().
+	 */
 	header.version = 0x19980330;
-	header.pid = pid;
-
 	bad_version_header.version = 0;
-	bad_version_header.pid = pid;
 
 	bad_pid_header.version = 0x19980330;
 	bad_pid_header.pid = -1;
-- 
2.18.0



