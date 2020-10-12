From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Mon, 12 Oct 2020 17:12:04 +0800
Subject: [LTP] [PATCH] ioctl_sg01: correct the fix SHA1
Message-ID: <20201012091204.875-1-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Correct the fix SHA1 to match with the one in the comment.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
index 8ad2ffed5..94b30dc6b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
@@ -127,7 +127,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.tags = (const struct tst_tag[]) {
-		{"linux-git", "e093c4be760e"},
+		{"linux-git", "a45b599ad808"},
 		{"CVE", "2018-1000204"},
 		{}
 	}
-- 
2.17.1

