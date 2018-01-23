From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jan 2018 16:23:14 +0800
Subject: [LTP] [PATCH] fanotify: the mount fs_type should be given
Message-ID: <20180123082314.15902-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commmit 28507e514c(safe_mount: Do not try mount() syscall for FUSE fs)
involves FUSE fs check in safe_mount(), so we should give the "fs_type" when
calling that in case the system kill our program.

  cmdline="fanotify06"
  contacts=""
  analysis=exit
  <<<test_output>>>
  tst_test.c:980: INFO: Timeout per run is 0h 10m 00s
  tst_test.c:1025: BROK: Test killed by SIGSEGV!

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/fanotify/fanotify06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify06.c b/testcases/kernel/syscalls/fanotify/fanotify06.c
index e63e457..8cbe1ad 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify06.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify06.c
@@ -221,7 +221,7 @@ void test01(void)
 static void setup(void)
 {
 	SAFE_MKDIR(MOUNT_NAME, 0755);
-	SAFE_MOUNT(MOUNT_NAME, MOUNT_NAME, NULL, MS_BIND, NULL);
+	SAFE_MOUNT(MOUNT_NAME, MOUNT_NAME, "none", MS_BIND, NULL);
 	mount_created = 1;
 	SAFE_CHDIR(MOUNT_NAME);
 
-- 
2.9.3

