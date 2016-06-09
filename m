From: Jiri Jaburek <jjaburek@redhat.com>
Date: Thu,  9 Jun 2016 15:58:25 +0200
Subject: [LTP] [PATCH] syscalls/ftruncate04: TCONF on kernels without
	MANDLOCK
Message-ID: <1465480705-23649-2-git-send-email-jjaburek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Upstream kernel commit

  9e8925b67a809bb27ce4b7d352d67f25cf1d7fc5
  locks: Allow disabling mandatory locking at compile time

added a config option to remove support for mandatory locking
(mount -o mand, MS_MANDLOCK), which went into v4.5.

Some distributions (like Fedora) already disable it, causing
ftruncate04 to fail:

ftruncate04    1  TBROK  :  safe_macros.c:728: ftruncate04.c:247:
mount(/dev/loop0, dir/, ext2, 64, (nil)) failed: errno=EPERM(1):
Operation not permitted

As the kernel returns EPERM in this case, there's no easy reliable
way of checking whether MANDLOCK is supported - instead, we perform
"regular" mount, to catch EPERM due to other causes early, and then
remount with MS_MANDLOCK.
If the remount triggers EPERM, the kernel was likely compiled
without CONFIG_MANDATORY_FILE_LOCKING.

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/kernel/syscalls/ftruncate/ftruncate04.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate04.c b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
index e75178b..f234f75 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate04.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate04.c
@@ -240,10 +240,24 @@ static void setup(void)
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
 
-	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
+	/* the kernel returns EPERM when CONFIG_MANDATORY_FILE_LOCKING is not
+	 * supported - to avoid false negatives, mount the fs first without
+	 * flags and then remount it as MS_MANDLOCK */
 
-	SAFE_MOUNT(NULL, device, MOUNT_DIR, fs_type, MS_MANDLOCK, NULL);
+	tst_mkfs(cleanup, device, fs_type, NULL, NULL);
+	SAFE_MOUNT(cleanup, device, MOUNT_DIR, fs_type, 0, NULL);
 	mount_flag = 1;
+
+	if (mount(NULL, MOUNT_DIR, NULL, MS_REMOUNT|MS_MANDLOCK, NULL) == -1) {
+		if (errno == EPERM) {
+			tst_brkm(TCONF, cleanup, "Mandatory locking (likely) "
+				 "not supported by this system");
+		} else {
+			tst_brkm(TBROK, cleanup,
+				 "Remount with MS_MANDLOCK failed: %s",
+				 strerror(errno));
+		}
+	}
 }
 
 static void cleanup(void)
-- 
2.4.3

