From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 26 Mar 2020 11:17:27 +0800
Subject: [LTP] [PATCH] runtest/syscalls: add sendmsg03
Message-ID: <1585192647-16105-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Also, fix a possible warning in cleanup when SAFE_UNSHARE(CLONE_NEWUSER)
failed on 3.10.0-1049.el7.x86_64. as below:

sendmsg03.c:43: CONF: unshare(268435456) unsupported: EINVAL (22)
safe_macros.c:67: WARN: sendmsg03.c:65: close(-1) failed: EBADF (9)

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 runtest/syscalls                              | 1 +
 testcases/kernel/syscalls/sendmsg/sendmsg03.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index b797fb828..0ad66ca5e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1176,6 +1176,7 @@ sendfile09_64 sendfile09_64
 
 sendmsg01 sendmsg01
 sendmsg02 sendmsg02
+sendmsg03 sendmsg03
 
 sendmmsg01 sendmmsg01
 
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg03.c b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
index dcabfbb00..7dc491f75 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg03.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
@@ -62,7 +62,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	SAFE_CLOSE(sockfd);
+	if (sockfd > 0)
+		SAFE_CLOSE(sockfd);
 	tst_fzsync_pair_cleanup(&fzsync_pair);
 }
 
-- 
2.23.0



