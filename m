From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Aug 2020 12:29:31 +0800
Subject: [LTP] [COMMITTED] ioctl_sg01: correct code comment
Message-ID: <20200817042931.1163-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reported-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
index 046758e50..daaa96be5 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
@@ -7,7 +7,7 @@
  * CVE-2018-1000204
  *
  * Test ioctl(SG_IO) and check that kernel doesn't leak data. Requires
- * a read-accessible SCSI-compatible device (e.g. SATA disk). Running mem01
+ * a read-accessible SCSI-compatible device (e.g. SATA disk). Running oom*
  * test program before this one may increase the chance of successfully
  * reproducing the bug.
  *
-- 
2.21.1

