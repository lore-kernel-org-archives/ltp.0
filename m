From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Apr 2020 11:22:56 +0200
Subject: [LTP] [PATCH 4/4] syscalls/fanotify: New test for FAN_MODIFY_DIR
In-Reply-To: <20200421065002.12417-5-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-5-amir73il@gmail.com>
Message-ID: <20200428092256.GC18634@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

...
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
...
> +	fd_notify = fanotify_init(FAN_REPORT_FID, 0);
> +	if (fd_notify == -1) {
> +		if (errno == EINVAL) {
> +			tst_brk(TCONF,
> +				"FAN_REPORT_FID not supported by kernel");
> +			return;
tst_brk() exits the test, so return is not needed.
> +		}
> +		tst_brk(TBROK | TERRNO,
> +			"fanotify_init(FAN_REPORT_FID, 0) failed");
> +	}
> +
> +	/*
> +	 * Watch dir modify events with name in filesystem/dir
> +	 */
> +	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
> +			  AT_FDCWD, MOUNT_PATH) < 0) {
> +		if (errno == EINVAL) {
> +			tst_brk(TCONF,
> +				"FAN_DIR_MODIFY not supported by kernel");
> +			return;
Also here.
> +		}
> +		tst_brk(TBROK | TERRNO,
> +		    "fanotify_mark (%d, FAN_MARK_ADD | %s, "
> +		    "FAN_DIR_MODIFY, AT_FDCWD, '"MOUNT_PATH"') "
> +		    "failed", fd_notify, mark->name);
> +	}

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Suggesting these changes:

Kind regards,
Petr

diff --git testcases/kernel/syscalls/fanotify/fanotify16.c testcases/kernel/syscalls/fanotify/fanotify16.c
index 0ec151841..7c29d256a 100644
--- testcases/kernel/syscalls/fanotify/fanotify16.c
+++ testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -116,11 +116,10 @@ static void do_test(unsigned int number)
 
 	fd_notify = fanotify_init(FAN_REPORT_FID, 0);
 	if (fd_notify == -1) {
-		if (errno == EINVAL) {
+		if (errno == EINVAL)
 			tst_brk(TCONF,
 				"FAN_REPORT_FID not supported by kernel");
-			return;
-		}
+
 		tst_brk(TBROK | TERRNO,
 			"fanotify_init(FAN_REPORT_FID, 0) failed");
 	}
@@ -130,11 +129,10 @@ static void do_test(unsigned int number)
 	 */
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
 			  AT_FDCWD, MOUNT_PATH) < 0) {
-		if (errno == EINVAL) {
+		if (errno == EINVAL)
 			tst_brk(TCONF,
 				"FAN_DIR_MODIFY not supported by kernel");
-			return;
-		}
+
 		tst_brk(TBROK | TERRNO,
 		    "fanotify_mark (%d, FAN_MARK_ADD | %s, "
 		    "FAN_DIR_MODIFY, AT_FDCWD, '"MOUNT_PATH"') "
@@ -365,7 +363,8 @@ static void do_test(unsigned int number)
 				(unsigned)event->pid, event->fd, filename,
 				event->event_len, info_type,
 				event_fid->hdr.len, fhlen,
-				event_fid->fsid.val[0], event_fid->fsid.val[1],
+				FSID_VAL_MEMBER(event_fid->fsid, 0),
+				FSID_VAL_MEMBER(event_fid->fsid, 1),
 				expected->fid->fsid.val[0],
 				expected->fid->fsid.val[1]);
 		} else if (strcmp(expected->name, filename)) {
@@ -427,6 +426,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
+	.dev_fs_flags = TST_FS_SKIP_FUSE,
 	.setup = setup,
 	.cleanup = cleanup,
 	.mount_device = 1,
