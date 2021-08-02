From: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Mon,  2 Aug 2021 17:46:41 -0400
Subject: [LTP] [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in
 FAN_FS_ERROR
In-Reply-To: <20210802214645.2633028-1-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
Message-ID: <20210802214645.2633028-4-krisman@collabora.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Verify the FID provided in the event.  If the testcase has a null inode,
this is assumed to be a superblock error (i.e. null FH).

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../kernel/syscalls/fanotify/fanotify20.c     | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index fd5cfb8744f1..d8d788ae685f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -40,6 +40,14 @@
 
 #define FAN_EVENT_INFO_TYPE_ERROR	4
 
+#ifndef FILEID_INVALID
+#define	FILEID_INVALID		0xff
+#endif
+
+#ifndef FILEID_INO32_GEN
+#define FILEID_INO32_GEN	1
+#endif
+
 struct fanotify_event_info_error {
 	struct fanotify_event_info_header hdr;
 	__s32 error;
@@ -57,6 +65,9 @@ static const struct test_case {
 	char *name;
 	int error;
 	unsigned int error_count;
+
+	/* inode can be null for superblock errors */
+	unsigned int *inode;
 	void (*trigger_error)(void);
 	void (*prepare_fs)(void);
 } testcases[] = {
@@ -83,6 +94,42 @@ struct fanotify_event_info_header *get_event_info(
 	((struct fanotify_event_info_error *)				\
 	 get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))
 
+#define get_event_info_fid(event)					\
+	((struct fanotify_event_info_fid *)				\
+	 get_event_info((event), FAN_EVENT_INFO_TYPE_FID))
+
+int check_error_event_info_fid(struct fanotify_event_info_fid *fid,
+				 const struct test_case *ex)
+{
+	int fail = 0;
+	struct file_handle *fh = (struct file_handle *) &fid->handle;
+
+	if (!ex->inode) {
+		uint32_t *h = (uint32_t *) fh->f_handle;
+
+		if (!(fh->handle_type == FILEID_INVALID && !h[0] && !h[1])) {
+			tst_res(TFAIL, "%s: file handle should have been invalid",
+				ex->name);
+			fail++;
+		}
+		return fail;
+	} else if (fh->handle_type == FILEID_INO32_GEN) {
+		uint32_t *h = (uint32_t *) fh->f_handle;
+
+		if (h[0] != *ex->inode) {
+			tst_res(TFAIL,
+				"%s: Unexpected file handle inode (%u!=%u)",
+				ex->name, *ex->inode, h[0]);
+			fail++;
+		}
+	} else {
+		tst_res(TFAIL, "%s: Test can't handle received FH type (%d)",
+			ex->name, fh->handle_type);
+	}
+
+	return fail;
+}
+
 int check_error_event_info_error(struct fanotify_event_info_error *info_error,
 				 const struct test_case *ex)
 {
@@ -126,6 +173,7 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 	struct fanotify_event_metadata *event =
 		(struct fanotify_event_metadata *) buf;
 	struct fanotify_event_info_error *info_error;
+	struct fanotify_event_info_fid *info_fid;
 	int fail = 0;
 
 	if (len < FAN_EVENT_METADATA_LEN)
@@ -137,6 +185,9 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 	info_error = get_event_info_error(event);
 	fail += info_error ? check_error_event_info_error(info_error, ex) : 1;
 
+	info_fid = get_event_info_fid(event);
+	fail += info_fid ? check_error_event_info_fid(info_fid, ex) : 1;
+
 	if (!fail)
 		tst_res(TPASS, "Successfully received: %s", ex->name);
 }
-- 
2.32.0

