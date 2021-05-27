From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Thu, 27 May 2021 13:22:57 +0800
Subject: [LTP] [PATCH] read02: Fix the failure of mips architecture test
Message-ID: <20210527052257.366-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

under mips architecture, writing to the buf of mmap PROT_NONE will
report an error EPERM.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/testcases/kernel/syscalls/read/read02.c b/testcases/kernel/syscalls/read/read02.c
index 9199a95f6..ab1c15970 100644
--- a/testcases/kernel/syscalls/read/read02.c
+++ b/testcases/kernel/syscalls/read/read02.c
@@ -52,7 +52,9 @@ static struct tcase {
 } tcases[] = {
 	{&badfd, &bufaddr, 1, EBADF},
 	{&fd2, &bufaddr, 1, EISDIR},
-#ifndef UCLINUX
+#if defined( __mips)
+	{&fd3, &outside_buf, 1, EPERM},
+#elif !defined(UCLINUX)
 	{&fd3, &outside_buf, 1, EFAULT},
 #endif
 	{&fd4, &addr4, 1, EINVAL},
--
2.20.1



