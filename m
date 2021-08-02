From: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Mon,  2 Aug 2021 17:46:40 -0400
Subject: [LTP] [PATCH 2/7] syscalls/fanotify20: Validate the generic error
 info
In-Reply-To: <20210802214645.2633028-1-krisman@collabora.com>
References: <20210802214645.2633028-1-krisman@collabora.com>
Message-ID: <20210802214645.2633028-3-krisman@collabora.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Implement some validation for the generic error info record emitted by
the kernel.  The error number is fs-specific but, well, we only support
ext4 for now anyway.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../kernel/syscalls/fanotify/fanotify20.c     | 59 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index 50531bd99cc9..fd5cfb8744f1 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -37,6 +37,14 @@
 
 #ifndef FAN_FS_ERROR
 #define FAN_FS_ERROR		0x00008000
+
+#define FAN_EVENT_INFO_TYPE_ERROR	4
+
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+};
 #endif
 
 #define BUF_SIZE 256
@@ -47,11 +55,54 @@ int fd_notify;
 
 static const struct test_case {
 	char *name;
+	int error;
+	unsigned int error_count;
 	void (*trigger_error)(void);
 	void (*prepare_fs)(void);
 } testcases[] = {
 };
 
+struct fanotify_event_info_header *get_event_info(
+					struct fanotify_event_metadata *event,
+					int info_type)
+{
+	struct fanotify_event_info_header *hdr = NULL;
+	char *start = (char *) event;
+	int off;
+
+	for (off = event->metadata_len; (off+sizeof(*hdr)) < event->event_len;
+	     off += hdr->len) {
+		hdr = (struct fanotify_event_info_header *) &(start[off]);
+		if (hdr->info_type == info_type)
+			return hdr;
+	}
+	return NULL;
+}
+
+#define get_event_info_error(event)					\
+	((struct fanotify_event_info_error *)				\
+	 get_event_info((event), FAN_EVENT_INFO_TYPE_ERROR))
+
+int check_error_event_info_error(struct fanotify_event_info_error *info_error,
+				 const struct test_case *ex)
+{
+	int fail = 0;
+
+	if (info_error->error_count != ex->error_count) {
+		tst_res(TFAIL, "%s: Unexpected error_count (%d!=%d)",
+			ex->name, info_error->error_count, ex->error_count);
+		fail++;
+	}
+
+	if (info_error->error != ex->error) {
+		tst_res(TFAIL, "%s: Unexpected error code value (%d!=%d)",
+			ex->name, info_error->error, ex->error);
+		fail++;
+	}
+
+	return fail;
+}
+
 int check_error_event_metadata(struct fanotify_event_metadata *event)
 {
 	int fail = 0;
@@ -74,6 +125,8 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 {
 	struct fanotify_event_metadata *event =
 		(struct fanotify_event_metadata *) buf;
+	struct fanotify_event_info_error *info_error;
+	int fail = 0;
 
 	if (len < FAN_EVENT_METADATA_LEN)
 		tst_res(TFAIL, "No event metadata found");
@@ -81,7 +134,11 @@ void check_event(char *buf, size_t len, const struct test_case *ex)
 	if (check_error_event_metadata(event))
 		return;
 
-	tst_res(TPASS, "Successfully received: %s", ex->name);
+	info_error = get_event_info_error(event);
+	fail += info_error ? check_error_event_info_error(info_error, ex) : 1;
+
+	if (!fail)
+		tst_res(TPASS, "Successfully received: %s", ex->name);
 }
 
 static void do_test(unsigned int i)
-- 
2.32.0

