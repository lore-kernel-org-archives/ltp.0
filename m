From: Zou Wei <zou_wei@huawei.com>
Date: Sat, 28 Mar 2020 14:39:44 +0800
Subject: [LTP] [PATCH] syscalls/statx: Add judgment to the MODE value
Message-ID: <1585377584-9931-1-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. The default value of umask in most linux systems is 0022, but in some other systems is 0077,
   which results in different MODE values when opening files.

2. Adding judgment to the MODE value can improve the versatility of this case.

3. 63 translates to 77 in octal, meaning the running process has a umask of 0022.
   That means the process will open files with 0600 as permissions on the filesystem.

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 testcases/kernel/syscalls/statx/statx01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 4f9d582..adca1d3 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -47,7 +47,7 @@
 #define TESTFILE "test_file"
 #define MNTPOINT "mntpoint/"
 #define DEVICEFILE MNTPOINT"blk_dev"
-#define MODE 0644
+#define MODE ((umask(0)==63)?0600:0644)

 #define SIZE 256
 #define MAJOR 8
--
2.6.2

