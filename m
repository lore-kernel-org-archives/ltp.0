From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Mar 2017 17:07:54 +0800
Subject: [LTP] [PATCH] ioctl06: test id usually same as test filename
Message-ID: <20170313090754.13414-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl06.c b/testcases/kernel/syscalls/ioctl/ioctl06.c
index 9046a3f..d05aa45 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl06.c
@@ -63,7 +63,7 @@ static void cleanup(void)
 }
 
 static struct tst_test test = {
-	.tid = "ioctl07",
+	.tid = "ioctl06",
 	.needs_device = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-- 
2.9.3

