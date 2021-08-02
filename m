From: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Mon,  2 Aug 2021 17:46:42 -0400
Subject: [LTP] [PATCH 4/7] syscalls/fanotify20: Watch event after filesystem
 abort
In-Reply-To: <20210802214645.2633028-1-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
Message-ID: <20210802214645.2633028-5-krisman@collabora.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test monitors the EXT4 specific error triggered after a file system
abort.  It works by forcing a remount with the option "abort".  This is
an error not related to a file so it is reported against the superblock
with a NULL FH.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 testcases/kernel/syscalls/fanotify/fanotify20.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index d8d788ae685f..7a9601072139 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -61,6 +61,14 @@ int fd_notify;
 
 #define MOUNT_PATH "test_mnt"
 
+#define EXT4_ERR_ESHUTDOWN 16
+
+static void trigger_fs_abort(void)
+{
+	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
+		   MS_REMOUNT|MS_RDONLY, "abort");
+}
+
 static const struct test_case {
 	char *name;
 	int error;
@@ -71,6 +79,13 @@ static const struct test_case {
 	void (*trigger_error)(void);
 	void (*prepare_fs)(void);
 } testcases[] = {
+	{
+		.name = "Trigger abort",
+		.trigger_error = &trigger_fs_abort,
+		.error_count = 1,
+		.error = EXT4_ERR_ESHUTDOWN,
+		.inode = NULL
+	}
 };
 
 struct fanotify_event_info_header *get_event_info(
-- 
2.32.0

