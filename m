From: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Mon,  2 Aug 2021 17:46:43 -0400
Subject: [LTP] [PATCH 5/7] syscalls/fanotify20: Support submission of
 debugfs commands
In-Reply-To: <20210802214645.2633028-1-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
Message-ID: <20210802214645.2633028-6-krisman@collabora.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In order to test FAN_FS_ERROR, we want to corrupt the filesystem.  The
easiest way to do it is by using debugfs.  Add a small helper to issue
debugfs requests.  Since most likely this will be the only testcase to
need this, don't bother making it a proper helper for now.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify20.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 7a9601072139..e7ced28eb61d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -63,6 +63,13 @@ int fd_notify;
 
 #define EXT4_ERR_ESHUTDOWN 16
 
+static void do_debugfs_request(const char *dev, char *request)
+{
+	char *cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
+
+	SAFE_CMD(cmd, NULL, NULL);
+}
+
 static void trigger_fs_abort(void)
 {
 	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
-- 
2.32.0

