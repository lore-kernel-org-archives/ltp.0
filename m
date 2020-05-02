From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Sat, 2 May 2020 19:39:33 +1000
Subject: [LTP] [PATCH 4/4] syscalls/fanotify: New test for FAN_MODIFY_DIR
In-Reply-To: <20200421065002.12417-5-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
 <20200421065002.12417-5-amir73il@gmail.com>
Message-ID: <20200502093931.GB1649@morpheus.bobrowski.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Apr 21, 2020 at 09:50:02AM +0300, Amir Goldstein wrote:
> +void save_fid(const char *path, struct fid_t *fid)
> +{
> +	int *fh = (int *)(fid->handle.f_handle);
> +	int *fsid = fid->fsid.val;
> +
> +	fh[0] = fh[1] = fh[2] = 0;
> +	fid->handle.handle_bytes = MAX_HANDLE_SZ;
> +	fanotify_get_fid(path, &fid->fsid, &fid->handle);
> +
> +	tst_res(TINFO,
> +		"fid(%s) = %x.%x.%x.%x.%x...",
> +		path, fsid[0], fsid[1], fh[0], fh[1], fh[2]);
> +}

What do you think about pulling this out and shoving it in fanotify.h
as another helper? Perhaps future tests would/could also make use of
this routine.

> +static void do_test(unsigned int number)
> +{
> +	int len = 0, i = 0, test_num = 0;
> +	int tst_count = 0;
> +	int fd;

Just shove all these on one line?

> +	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
> +			  AT_FDCWD, MOUNT_PATH) < 0) {
> +		if (errno == EINVAL) {
> +			tst_brk(TCONF,
> +				"FAN_DIR_MODIFY not supported by kernel");
> +			return;
> +		}
> +		tst_brk(TBROK | TERRNO,
> +		    "fanotify_mark (%d, FAN_MARK_ADD | %s, "
> +		    "FAN_DIR_MODIFY, AT_FDCWD, '"MOUNT_PATH"') "
> +		    "failed", fd_notify, mark->name);

Should we be adding tc->mask here to the format string output?

> +	/*
> +	 * Create subdir and watch open events "on children" with name.
> +	 */
> +	if (mkdir(dname1, 0755) < 0) {
> +		tst_brk(TBROK | TERRNO,
> +				"mkdir('"DIR_NAME1"', 0755) failed");
> +	}

Perhaps we should be making use of the SAFE_MACROS() so that we're
adhering to the test writing guidelines?

> +	if (tc->sub_mask &&
> +	    fanotify_mark(fd_notify, FAN_MARK_ADD | sub_mark->flag, tc->sub_mask,
> +			  AT_FDCWD, dname1) < 0) {
> +		tst_brk(TBROK | TERRNO,
> +		    "fanotify_mark (%d, FAN_MARK_ADD | %s, "
> +		    "FAN_DIR_MODIFY | FAN_DELETE_SELF | FAN_ONDIR, "
> +		    "AT_FDCWD, '%s') "
> +		    "failed", fd_notify, sub_mark->name, dname1);
> +	}

Maybe just replace the statically typed mask here with tc->sub_mask?
That way, if test cases are added or modified in the future, you don't
have to update it?

> +	if ((fd = creat(fname1, 0755)) == -1) {
> +		tst_brk(TBROK | TERRNO,
> +			"creat(\"%s\", 755) failed", FILE_NAME1);
> +	}
> +
> +	if (rename(fname1, fname2) == -1) {
> +		tst_brk(TBROK | TERRNO,
> +				"rename(%s, %s) failed",
> +				FILE_NAME1, FILE_NAME2);
> +	}
> +
> +	if (close(fd) == -1) {
> +		tst_brk(TBROK | TERRNO,
> +				"close(%s) failed", FILE_NAME2);
> +	}
> +
> +	/* Generate delete events with fname2 */
> +	if (unlink(fname2) == -1) {
> +		tst_brk(TBROK | TERRNO,
> +				"unlink(%s) failed", FILE_NAME2);
> +	}

The same applies with the above set of system calls? 

...

> +	if (rename(dname1, dname2) == -1) {
> +		tst_brk(TBROK | TERRNO,
> +				"rename(%s, %s) failed",
> +				DIR_NAME1, DIR_NAME2);
> +	}
> +
> +	if (rmdir(dname2) == -1) {
> +		tst_brk(TBROK | TERRNO,
> +				"rmdir(%s) failed", DIR_NAME2);
> +	}


And here...

> +	while (i < len) {
> +		struct event_t *expected = &event_set[test_num];
> +		struct fanotify_event_metadata *event;
> +		struct fanotify_event_info_fid *event_fid;
> +		struct file_handle *file_handle;
> +		unsigned int fhlen;
> +		const char *filename;
> +		int namelen, info_type;
> +
> +		event = (struct fanotify_event_metadata *)&event_buf[i];
> +		event_fid = (struct fanotify_event_info_fid *)(event + 1);
> +		file_handle = (struct file_handle *)event_fid->handle;
> +		fhlen = file_handle->handle_bytes;
> +		filename = (char *)file_handle->f_handle + fhlen;
> +		namelen = ((char *)event + event->event_len) - filename;
> +		/* End of event could have name, zero padding, both or none */
> +		if (namelen > 0) {
> +			namelen = strlen(filename);
> +		} else {
> +			filename = "";
> +			namelen = 0;
> +		}
> +		if (expected->name[0]) {
> +			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
> +		} else {
> +			info_type = FAN_EVENT_INFO_TYPE_FID;
> +		}

Can we line break these conditional statements?

...

> +static void setup(void)
> +{

	int fd;

	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, 0_RDONLY);
	SAFE_CLOSE(fd);

Above snippet missing from test bootstrap? I remember we had to add
this in the past, but I can't remember the _why_?

Anyway, the functionality testing looks fine to me.

Reviewed-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

/M
