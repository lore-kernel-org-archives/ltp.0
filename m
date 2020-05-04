From: Jan Kara <jack@suse.cz>
Date: Mon, 4 May 2020 10:07:15 +0200
Subject: [LTP] [PATCH v2 2/4] syscalls/fanotify15: Add a test case for
 inode marks
In-Reply-To: <20200502162744.9589-3-amir73il@gmail.com>
References: <20200502162744.9589-1-amir73il@gmail.com>
 <20200502162744.9589-3-amir73il@gmail.com>
Message-ID: <20200504080715.GA1741@quack2.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat 02-05-20 19:27:42, Amir Goldstein wrote:
> Test reporting events with fid also with recusrive inode marks:
> - Test events "on self" (FAN_DELETE_SELF) on file and dir
> - Test events "on child" (FAN_MODIFY) on file
> 
> With recursive inode marks, verify that the FAN_MODIFY event reported
> to parent "on child" is merged with the FAN_MODIFY event reported to
> child.
> 
> The new test case is a regression test for commit f367a62a7cad:
> 
>     fanotify: merge duplicate events on parent and child

The test looks OK but do we want a test for this? I mean: A test like this
seems to imply we promise to merge identical events. Although that is a
good general guideline, I consider it rather an optimization that may or
may not happen but userspace should not rely on it. Thoughts?

								Honza


> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> ---
>  .../kernel/syscalls/fanotify/fanotify15.c     | 81 +++++++++++++++++--
>  1 file changed, 73 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
> index 2e860edb2..a9ed2ec81 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify15.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
> @@ -9,6 +9,10 @@
>   *	Test file that has been purposely designed to verify
>   *	FAN_REPORT_FID functionality while using newly defined dirent
>   *	events.
> + *
> + * Test case #1 is a regression test for commit f367a62a7cad:
> + *
> + *      fanotify: merge duplicate events on parent and child
>   */
>  #define _GNU_SOURCE
>  #include "config.h"
> @@ -53,28 +57,49 @@ static int fanotify_fd;
>  static char events_buf[EVENT_BUF_LEN];
>  static struct event_t event_set[EVENT_MAX];
>  
> -static void do_test(void)
> +static struct test_case_t {
> +	const char *tname;
> +	struct fanotify_mark_type mark;
> +	unsigned long mask;
> +} test_cases[] = {
> +	{
> +		"FAN_REPORT_FID on filesystem including FAN_DELETE_SELF",
> +		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
> +		FAN_DELETE_SELF,
> +	},
> +	{
> +		"FAN_REPORT_FID on directory with FAN_EVENT_ON_CHILD",
> +		INIT_FANOTIFY_MARK_TYPE(INODE),
> +		FAN_EVENT_ON_CHILD,
> +	},
> +};
> +
> +static void do_test(unsigned int number)
>  {
>  	int i, fd, len, count = 0;
>  
>  	struct file_handle *event_file_handle;
>  	struct fanotify_event_metadata *metadata;
>  	struct fanotify_event_info_fid *event_fid;
> +	struct test_case_t *tc = &test_cases[number];
> +	struct fanotify_mark_type *mark = &tc->mark;
> +
> +	tst_res(TINFO, "Test #%d: %s", number, tc->tname);
>  
> -	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
> +	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag, tc->mask |
>  				FAN_CREATE | FAN_DELETE | FAN_MOVE |
> -				FAN_MODIFY | FAN_DELETE_SELF | FAN_ONDIR,
> +				FAN_MODIFY | FAN_ONDIR,
>  				AT_FDCWD, TEST_DIR) == -1) {
>  		if (errno == ENODEV)
>  			tst_brk(TCONF,
>  				"FAN_REPORT_FID not supported on %s "
>  				"filesystem", tst_device->fs_type);
>  		tst_brk(TBROK | TERRNO,
> -			"fanotify_mark(%d, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, "
> +			"fanotify_mark(%d, FAN_MARK_ADD | %s, "
>  			"FAN_CREATE | FAN_DELETE | FAN_MOVE | "
> -			"FAN_MODIFY | FAN_DELETE_SELF | FAN_ONDIR, "
> +			"FAN_MODIFY | FAN_ONDIR | 0x%lx, "
>  			"AT_FDCWD, %s) failed",
> -			fanotify_fd, TEST_DIR);
> +			fanotify_fd, mark->name, tc->mask, TEST_DIR);
>  	}
>  
>  	/* All dirent events on testdir are merged */
> @@ -87,8 +112,21 @@ static void do_test(void)
>  	fd = SAFE_CREAT(FILE1, 0644);
>  	SAFE_CLOSE(fd);
>  
> +	/* Recursive watch file for events "on self" */
> +	if (mark->flag == FAN_MARK_INODE &&
> +	    fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag,
> +			  FAN_MODIFY | FAN_DELETE_SELF,
> +			  AT_FDCWD, FILE1) == -1) {
> +		tst_brk(TBROK | TERRNO,
> +			"fanotify_mark(%d, FAN_MARK_ADD | %s, "
> +			"FAN_DELETE_SELF, AT_FDCWD, %s) failed",
> +			fanotify_fd, mark->name, FILE1);
> +	}
> +
>  	/*
>  	 * Event on child file is not merged with dirent events.
> +	 * FAN_MODIFY event reported on file mark should be merged with the
> +	 * FAN_MODIFY event reported on parent directory watch.
>  	 */
>  	event_set[count].mask = FAN_MODIFY;
>  	event_set[count].handle.handle_bytes = MAX_HANDLE_SZ;
> @@ -128,6 +166,17 @@ static void do_test(void)
>  
>  	SAFE_MKDIR(DIR1, 0755);
>  
> +	/* Recursive watch subdir for events "on self" */
> +	if (mark->flag == FAN_MARK_INODE &&
> +	    fanotify_mark(fanotify_fd, FAN_MARK_ADD | mark->flag,
> +			  FAN_DELETE_SELF | FAN_ONDIR,
> +			  AT_FDCWD, DIR1) == -1) {
> +		tst_brk(TBROK | TERRNO,
> +			"fanotify_mark(%d, FAN_MARK_ADD | %s,"
> +			"FAN_DELETE_SELF | FAN_ONDIR, AT_FDCWD, %s) failed",
> +			fanotify_fd, mark->name, DIR1);
> +	}
> +
>  	SAFE_RENAME(DIR1, DIR2);
>  
>  	event_set[count].mask = FAN_ONDIR | FAN_DELETE_SELF;
> @@ -141,6 +190,17 @@ static void do_test(void)
>  	/* Read dir events from the event queue */
>  	len += SAFE_READ(0, fanotify_fd, events_buf + len, EVENT_BUF_LEN - len);
>  
> +	/*
> +	 * Cleanup the mark
> +	 */
> +	if (fanotify_mark(fanotify_fd, FAN_MARK_FLUSH | mark->flag, 0,
> +			  AT_FDCWD, TEST_DIR) < 0) {
> +		tst_brk(TBROK | TERRNO,
> +			"fanotify_mark (%d, FAN_MARK_FLUSH | %s, 0,"
> +			"AT_FDCWD, '"TEST_DIR"') failed",
> +			fanotify_fd, mark->name);
> +	}
> +
>  	/* Process each event in buffer */
>  	for (i = 0, metadata = (struct fanotify_event_metadata *) events_buf;
>  		FAN_EVENT_OK(metadata, len); i++) {
> @@ -259,9 +319,14 @@ static struct tst_test test = {
>  	.mount_device = 1,
>  	.mntpoint = MOUNT_POINT,
>  	.all_filesystems = 1,
> -	.test_all = do_test,
> +	.test = do_test,
> +	.tcnt = ARRAY_SIZE(test_cases),
>  	.setup = do_setup,
> -	.cleanup = do_cleanup
> +	.cleanup = do_cleanup,
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "f367a62a7cad"},
> +		{}
> +	}
>  };
>  
>  #else
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
