From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Jan 2020 15:00:17 +0800
Subject: [LTP] [PATCH] syscalls/capget02: Use pid=0 instead of getpid()
Message-ID: <1578553217-29510-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since pid=0 returns the capabilities for the calling thread,
we can remove getpid and use pid=0 instead of it. Also we
can cover this test point.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/capget/capget02.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/capget/capget02.c b/testcases/kernel/syscalls/capget/capget02.c
index 42c76a011..0a23700b9 100644
--- a/testcases/kernel/syscalls/capget/capget02.c
+++ b/testcases/kernel/syscalls/capget/capget02.c
@@ -69,15 +69,13 @@ static void verify_capget(unsigned int n)
 
 static void setup(void)
 {
-	unsigned int i, pid;
-
-	pid = getpid();
+	unsigned int i;
 
 	header.version = 0x19980330;
-	header.pid = pid;
+	header.pid = 0;
 
 	bad_version_header.version = 0;
-	bad_version_header.pid = pid;
+	bad_version_header.pid = 0;
 
 	bad_pid_header.version = 0x19980330;
 	bad_pid_header.pid = -1;
-- 
2.18.0



