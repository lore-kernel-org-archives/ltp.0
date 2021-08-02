From: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Mon,  2 Aug 2021 17:46:45 -0400
Subject: [LTP] [PATCH 7/7] syscalls/fanotify20: Test capture of multiple
 errors
In-Reply-To: <20210802214645.2633028-1-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
Message-ID: <20210802214645.2633028-8-krisman@collabora.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When multiple FS errors occur, only the first is stored.  This testcase
validates this behavior by issuing two different errors and making sure
only the first is stored, while the second is simply accumulated in
error_count.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../kernel/syscalls/fanotify/fanotify20.c     | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 0c63e90edc3a..07040cb7fa7c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -106,6 +106,18 @@ static void tcase2_trigger_lookup(void)
 			ret, TCASE2_BAD_DIR, errno, EUCLEAN);
 }
 
+static void tcase3_trigger(void)
+{
+	trigger_fs_abort();
+	tcase2_trigger_lookup();
+}
+
+static void tcase4_trigger(void)
+{
+	tcase2_trigger_lookup();
+	trigger_fs_abort();
+}
+
 static const struct test_case {
 	char *name;
 	int error;
@@ -130,6 +142,19 @@ static const struct test_case {
 		.error_count = 1,
 		.error = 0,
 		.inode = &tcase2_bad_ino,
+	},
+	{
+		.name = "Multiple error submission",
+		.trigger_error = &tcase3_trigger,
+		.error_count = 2,
+		.error = EXT4_ERR_ESHUTDOWN,
+	},
+	{
+		.name = "Multiple error submission 2",
+		.trigger_error = &tcase4_trigger,
+		.error_count = 2,
+		.error = 0,
+		.inode = &tcase2_bad_ino,
 	}
 };
 
-- 
2.32.0

