From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue,  5 Nov 2019 01:53:41 +0100
Subject: [LTP] [PATCH 2/2] fanotify: Rename fanotify_event_info_fid struct
In-Reply-To: <20191105005341.19033-1-petr.vorel@gmail.com>
References: <20191105005341.19033-1-petr.vorel@gmail.com>
Message-ID: <20191105005341.19033-3-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To fix build on musl, which also defines fanotify_event_info_fid,
but uses fsid_t type for fsid instead of __kernel_fsid_t.

This fixes errors:

fanotify13.c: In function ?do_test?:
fanotify13.c:278:20: error: ?fsid_t? {aka ?struct __fsid_t?} has no member named ?val?; did you mean ?__val??
    event_fid->fsid.val[0],
                    ^~~
../../../../include/tst_test.h:49:53: note: in definition of macro ?tst_res?
  tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
                                                     ^~~~~~~~~~~
fanotify13.c:279:20: error: ?fsid_t? {aka ?struct __fsid_t?} has no member named ?val?; did you mean ?__val??
    event_fid->fsid.val[1],

musl (unlike glibc and uclibc-ng) defines fanotify_event_info_fid in
fanotify.h and uses fsid_t as type for fanotify_event_info_fid.fsid
member, which defines __val[2] (unlike val[2] in __kernel_fsid_t).

/* musl (include/sys/fanotify.h) */
struct fanotify_event_info_fid {
	struct fanotify_event_info_header hdr;
	fsid_t fsid;
	unsigned char handle[];
};
/* musl (include/sys/statfs.h) */
typedef struct __fsid_t {
	int __val[2];
} fsid_t;

/* kernel (include/uapi/linux/fanotify.h) */
struct fanotify_event_info_fid {
	struct fanotify_event_info_header hdr;
	__kernel_fsid_t fsid;
	/*
	 * Following is an opaque struct file_handle that can be passed as
	 * an argument to open_by_handle_at(2).
	 */
	unsigned char handle[0];
};
/* kernel include/uapi/asm-generic/posix_types.h */
typedef struct {
	int	val[2];
} __kernel_fsid_t;

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 6 ++----
 testcases/kernel/syscalls/fanotify/fanotify13.c | 4 ++--
 testcases/kernel/syscalls/fanotify/fanotify15.c | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 563a4eb5b..faac178cf 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -133,17 +133,15 @@ struct fanotify_event_info_header {
 	uint8_t pad;
 	uint16_t len;
 };
+#endif /* ! FAN_REPORT_FID */
 
 #ifdef HAVE_NAME_TO_HANDLE_AT
-struct fanotify_event_info_fid {
+struct lapi_fanotify_event_info_fid {
 	struct fanotify_event_info_header hdr;
 	__kernel_fsid_t fsid;
 	unsigned char handle[0];
 };
-#endif /* HAVE_NAME_TO_HANDLE_AT */
-#endif /* ! FAN_REPORT_FID */
 
-#ifdef HAVE_NAME_TO_HANDLE_AT
 /*
  * Helper function used to obtain fsid and file_handle for a given path.
  * Used by test files correlated to FAN_REPORT_FID functionality.
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 030734285..e0ce887e7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -159,7 +159,7 @@ static void do_test(unsigned int number)
 
 	struct file_handle *event_file_handle;
 	struct fanotify_event_metadata *metadata;
-	struct fanotify_event_info_fid *event_fid;
+	struct lapi_fanotify_event_info_fid *event_fid;
 	struct test_case_t *tc = &test_cases[number];
 	struct fanotify_mark_type *mark = &tc->mark;
 
@@ -207,7 +207,7 @@ static void do_test(unsigned int number)
 	for (i = 0, metadata = (struct fanotify_event_metadata *) events_buf;
 		FAN_EVENT_OK(metadata, len);
 		metadata = FAN_EVENT_NEXT(metadata, len), i++) {
-		event_fid = (struct fanotify_event_info_fid *) (metadata + 1);
+		event_fid = (struct lapi_fanotify_event_info_fid *) (metadata + 1);
 		event_file_handle = (struct file_handle *) event_fid->handle;
 
 		/* File descriptor is redundant with FAN_REPORT_FID */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index e9e926078..e9f1ff70d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -53,7 +53,7 @@ static void do_test(void)
 
 	struct file_handle *event_file_handle;
 	struct fanotify_event_metadata *metadata;
-	struct fanotify_event_info_fid *event_fid;
+	struct lapi_fanotify_event_info_fid *event_fid;
 
 	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
 				FAN_CREATE | FAN_DELETE | FAN_ATTRIB |
@@ -125,7 +125,7 @@ static void do_test(void)
 	for (i = 0, metadata = (struct fanotify_event_metadata *) events_buf;
 		FAN_EVENT_OK(metadata, len);
 		metadata = FAN_EVENT_NEXT(metadata,len), i++) {
-		event_fid = (struct fanotify_event_info_fid *) (metadata + 1);
+		event_fid = (struct lapi_fanotify_event_info_fid *) (metadata + 1);
 		event_file_handle = (struct file_handle *) event_fid->handle;
 
 		if (i >= count) {
-- 
2.24.0.rc2

