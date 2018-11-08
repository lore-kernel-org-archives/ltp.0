From: Jan Stancek <jstancek@redhat.com>
Date: Thu,  8 Nov 2018 21:59:01 +0100
Subject: [LTP] [PATCH 1/2] syscalls/mq: don't use TWARN with tst_brk()
Message-ID: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/utils/mq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/utils/mq.h b/testcases/kernel/syscalls/utils/mq.h
index 0bdac97229cd..b55228c885dc 100644
--- a/testcases/kernel/syscalls/utils/mq.h
+++ b/testcases/kernel/syscalls/utils/mq.h
@@ -74,7 +74,7 @@ static void cleanup_queue(mqd_t fd)
 
 	memset(&mqstat, 0, sizeof(mqstat));
 	if (mq_getattr(fd, &mqstat) == -1) {
-		tst_brk(TWARN, "mq_getattr() failed");
+		tst_brk(TBROK|TERRNO, "mq_getattr() failed");
 		return;
 	}
 
-- 
1.8.3.1

