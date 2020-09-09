From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:57:02 +0300
Subject: [LTP] [PATCH 05/10] syscalls/fanotify16: Verify child fid info
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200909175707.10670-6-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If event reports both dir and child fid, also verify the expected
child fid in the second info record.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify16.c     | 73 ++++++++++++++++---
 1 file changed, 61 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index c8c7a9ee8..7995a1688 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -44,6 +44,7 @@
 struct event_t {
 	unsigned long long mask;
 	struct fanotify_fid_t *fid;
+	struct fanotify_fid_t *child_fid;
 	char name[BUF_SIZE];
 };
 
@@ -205,6 +206,7 @@ static void do_test(unsigned int number)
 
 	event_set[tst_count].mask = FAN_CREATE | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
+	event_set[tst_count].child_fid = NULL;
 	strcpy(event_set[tst_count].name, DIR_NAME1);
 	tst_count++;
 
@@ -230,6 +232,7 @@ static void do_test(unsigned int number)
 	 */
 	event_set[tst_count].mask = FAN_CREATE | FAN_MOVED_FROM;
 	event_set[tst_count].fid = &dir_fid;
+	event_set[tst_count].child_fid = NULL;
 	strcpy(event_set[tst_count].name, FILE_NAME1);
 	tst_count++;
 	/*
@@ -242,12 +245,14 @@ static void do_test(unsigned int number)
 	if (group->flag & FAN_REPORT_NAME) {
 		event_set[tst_count].mask = FAN_OPEN;
 		event_set[tst_count].fid = &dir_fid;
+		event_set[tst_count].child_fid = &file_fid;
 		strcpy(event_set[tst_count].name, FILE_NAME1);
 		tst_count++;
 	}
 
 	event_set[tst_count].mask = FAN_DELETE | FAN_MOVED_TO;
 	event_set[tst_count].fid = &dir_fid;
+	event_set[tst_count].child_fid = NULL;
 	strcpy(event_set[tst_count].name, FILE_NAME2);
 	tst_count++;
 	/*
@@ -257,6 +262,7 @@ static void do_test(unsigned int number)
 	if (!(group->flag & FAN_REPORT_NAME)) {
 		event_set[tst_count].mask = FAN_OPEN | FAN_CLOSE_WRITE;
 		event_set[tst_count].fid = &dir_fid;
+		event_set[tst_count].child_fid = &file_fid;
 		strcpy(event_set[tst_count].name, "");
 		tst_count++;
 	}
@@ -268,6 +274,7 @@ static void do_test(unsigned int number)
 	if (mark->flag == FAN_MARK_FILESYSTEM && (group->flag & FAN_REPORT_FID)) {
 		event_set[tst_count].mask = FAN_DELETE_SELF | FAN_MOVE_SELF;
 		event_set[tst_count].fid = &file_fid;
+		event_set[tst_count].child_fid = NULL;
 		strcpy(event_set[tst_count].name, "");
 		tst_count++;
 	}
@@ -279,6 +286,7 @@ static void do_test(unsigned int number)
 	if (group->flag & FAN_REPORT_NAME) {
 		event_set[tst_count].mask = FAN_CLOSE_WRITE;
 		event_set[tst_count].fid = &dir_fid;
+		event_set[tst_count].child_fid = &file_fid;
 		strcpy(event_set[tst_count].name, FILE_NAME2);
 		tst_count++;
 	}
@@ -294,6 +302,7 @@ static void do_test(unsigned int number)
 	 */
 	event_set[tst_count].mask = FAN_OPEN | FAN_CLOSE_NOWRITE | FAN_ONDIR;
 	event_set[tst_count].fid = &dir_fid;
+	event_set[tst_count].child_fid = NULL;
 	strcpy(event_set[tst_count].name, ".");
 	tst_count++;
 	/*
@@ -302,6 +311,7 @@ static void do_test(unsigned int number)
 	 */
 	event_set[tst_count].mask = FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR;
 	event_set[tst_count].fid = &dir_fid;
+	event_set[tst_count].child_fid = NULL;
 	strcpy(event_set[tst_count].name, ".");
 	tst_count++;
 
@@ -313,10 +323,12 @@ static void do_test(unsigned int number)
 
 	event_set[tst_count].mask = FAN_MOVED_FROM | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
+	event_set[tst_count].child_fid = NULL;
 	strcpy(event_set[tst_count].name, DIR_NAME1);
 	tst_count++;
 	event_set[tst_count].mask = FAN_DELETE | FAN_MOVED_TO | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
+	event_set[tst_count].child_fid = NULL;
 	strcpy(event_set[tst_count].name, DIR_NAME2);
 	tst_count++;
 	/* Expect no more events */
@@ -332,17 +344,21 @@ static void do_test(unsigned int number)
 		struct event_t *expected = &event_set[test_num];
 		struct fanotify_event_metadata *event;
 		struct fanotify_event_info_fid *event_fid;
+		struct fanotify_event_info_fid *child_fid;
+		struct fanotify_fid_t *expected_fid = expected->fid;
+		struct fanotify_fid_t *expected_child_fid = expected->child_fid;
 		struct file_handle *file_handle;
 		unsigned int fhlen;
 		const char *filename;
-		int namelen, info_type, mask_match;
+		int namelen, info_type, mask_match, info_id = 0;
 
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		event_fid = (struct fanotify_event_info_fid *)(event + 1);
 		file_handle = (struct file_handle *)event_fid->handle;
 		fhlen = file_handle->handle_bytes;
 		filename = (char *)file_handle->f_handle + fhlen;
-		namelen = ((char *)event_fid + event_fid->hdr.len) - filename;
+		child_fid = (void *)((char *)event_fid + event_fid->hdr.len);
+		namelen = (char *)child_fid - (char *)filename;
 		/* End of event_fid could have name, zero padding, both or none */
 		if (namelen > 0) {
 			namelen = strlen(filename);
@@ -350,6 +366,12 @@ static void do_test(unsigned int number)
 			filename = "";
 			namelen = 0;
 		}
+		/* Is there a child fid after first fid record? */
+		if (((char *)child_fid - (char *)event) >= event->event_len)
+			child_fid = NULL;
+
+		if (!(group->flag & FAN_REPORT_FID))
+			expected_child_fid = NULL;
 
 		if (!(group->flag & FAN_REPORT_NAME))
 			expected->name[0] = 0;
@@ -375,6 +397,7 @@ static void do_test(unsigned int number)
 			      !(expected->mask & ~event->mask) &&
 			      !((event->mask ^ expected->mask) & FAN_ONDIR));
 
+check_match:
 		if (test_num >= tst_count) {
 			tst_res(TFAIL,
 				"got unnecessary event: mask=%llx "
@@ -409,7 +432,7 @@ static void do_test(unsigned int number)
 				(unsigned)event->pid, event->fd,
 				event->event_len, event_fid->hdr.info_type,
 				info_type, event_fid->hdr.len, fhlen);
-		} else if (fhlen != expected->fid->handle.handle_bytes) {
+		} else if (fhlen != expected_fid->handle.handle_bytes) {
 			tst_res(TFAIL,
 				"got event: mask=%llx pid=%u fd=%d name='%s' "
 				"len=%d info_type=%d info_len=%d fh_len=%d expected(%d)"
@@ -418,10 +441,10 @@ static void do_test(unsigned int number)
 				(unsigned)event->pid, event->fd, filename,
 				event->event_len, info_type,
 				event_fid->hdr.len, fhlen,
-				expected->fid->handle.handle_bytes,
+				expected_fid->handle.handle_bytes,
 				file_handle->handle_type);
 		} else if (file_handle->handle_type !=
-			   expected->fid->handle.handle_type) {
+			   expected_fid->handle.handle_type) {
 			tst_res(TFAIL,
 				"got event: mask=%llx pid=%u fd=%d name='%s' "
 				"len=%d info_type=%d info_len=%d fh_len=%d "
@@ -431,9 +454,9 @@ static void do_test(unsigned int number)
 				event->event_len, info_type,
 				event_fid->hdr.len, fhlen,
 				file_handle->handle_type,
-				expected->fid->handle.handle_type);
+				expected_fid->handle.handle_type);
 		} else if (memcmp(file_handle->f_handle,
-				  expected->fid->handle.f_handle, fhlen)) {
+				  expected_fid->handle.f_handle, fhlen)) {
 			tst_res(TFAIL,
 				"got event: mask=%llx pid=%u fd=%d name='%s' "
 				"len=%d info_type=%d info_len=%d fh_len=%d "
@@ -444,7 +467,7 @@ static void do_test(unsigned int number)
 				event_fid->hdr.len, fhlen,
 				file_handle->handle_type,
 				*(int *)(file_handle->f_handle));
-		} else if (memcmp(&event_fid->fsid, &expected->fid->fsid,
+		} else if (memcmp(&event_fid->fsid, &expected_fid->fsid,
 				  sizeof(event_fid->fsid)) != 0) {
 			tst_res(TFAIL,
 				"got event: mask=%llx pid=%u fd=%d name='%s' "
@@ -456,8 +479,8 @@ static void do_test(unsigned int number)
 				event_fid->hdr.len, fhlen,
 				FSID_VAL_MEMBER(event_fid->fsid, 0),
 				FSID_VAL_MEMBER(event_fid->fsid, 1),
-				expected->fid->fsid.val[0],
-				expected->fid->fsid.val[1]);
+				expected_fid->fsid.val[0],
+				expected_fid->fsid.val[1]);
 		} else if (strcmp(expected->name, filename)) {
 			tst_res(TFAIL,
 				"got event: mask=%llx "
@@ -479,13 +502,39 @@ static void do_test(unsigned int number)
 				event->fd, filename,
 				event->event_len, event_fid->hdr.info_type,
 				event_fid->hdr.len, fhlen);
+		} else if (!!child_fid != !!expected_child_fid) {
+			tst_res(TFAIL,
+				"got event: mask=%llx "
+				"pid=%u fd=%d name='%s' num_info=%d (expected %d) "
+				"len=%d info_type=%d info_len=%d fh_len=%d",
+				(unsigned long long)event->mask,
+				(unsigned)event->pid, event->fd,
+				filename, 1 + !!child_fid, 1 + !!expected_child_fid,
+				event->event_len, event_fid->hdr.info_type,
+				event_fid->hdr.len, fhlen);
+		} else if (child_fid) {
+			tst_res(TINFO,
+				"got event #%d: info #%d: info_type=%d info_len=%d fh_len=%d",
+				test_num, info_id, event_fid->hdr.info_type,
+				event_fid->hdr.len, fhlen);
+
+			/* Recheck event_fid match with child_fid */
+			event_fid = child_fid;
+			expected_fid = expected->child_fid;
+			info_id = 1;
+			info_type = FAN_EVENT_INFO_TYPE_FID;
+			file_handle = (struct file_handle *)event_fid->handle;
+			fhlen = file_handle->handle_bytes;
+			child_fid = NULL;
+			expected_child_fid = NULL;
+			goto check_match;
 		} else {
 			tst_res(TPASS,
 				"got event #%d: mask=%llx pid=%u fd=%d name='%s' "
-				"len=%d info_type=%d info_len=%d fh_len=%d",
+				"len=%d; info #%d: info_type=%d info_len=%d fh_len=%d",
 				test_num, (unsigned long long)event->mask,
 				(unsigned)event->pid, event->fd, filename,
-				event->event_len, event_fid->hdr.info_type,
+				event->event_len, info_id, event_fid->hdr.info_type,
 				event_fid->hdr.len, fhlen);
 		}
 
-- 
2.17.1

