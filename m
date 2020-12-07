From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 Dec 2020 12:44:41 +0100
Subject: [LTP] [PATCH 3/5] syscalls/fanotify09: Read variable length
 events
In-Reply-To: <20201204095930.866421-4-amir73il@gmail.com>
References: <20201204095930.866421-1-amir73il@gmail.com>
 <20201204095930.866421-4-amir73il@gmail.com>
Message-ID: <X84VqaD4+FqAix5h@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> In preparation of testing events with filename info, teach the
> how to read variable length events and parse the name info.

This commit broke umount() on old kernels. (LTP lib doing multiple attempts is
useless here). Not sure what exactly is being used, it's not by staing in
mounted directory. Any idea how to fix it?

Testing on SLES 4.4.21 (with many patches) on btrfs, I could also reproduce it
on tmpfs.

Kind regards,
Petr

# ./fanotify09
tst_test.c:1250: TINFO: Timeout per run is 0h 05m 00s
fanotify09.c:210: TINFO: Test #0: Events on non-dir child with both parent and mount marks
fanotify09.c:155: TPASS: group 0 got event: mask 2 pid=10770 fd=6 filename=/tmp/RLmVI1/mntpoint/tfile_10770
fanotify09.c:155: TFAIL: group 1 got event: mask 0 pid=0 fd=0 filename=/dev/pts/0
fanotify09.c:155: TFAIL: group 2 got event: mask 0 pid=0 fd=-1 filename=
fanotify09.c:210: TINFO: Test #1: Events on non-dir child and subdir with both parent and mount marks
fanotify09.c:155: TPASS: group 0 got event: mask 2 pid=10770 fd=7 filename=/tmp/RLmVI1/mntpoint/tfile_10770
fanotify09.c:155: TPASS: group 0 got event: mask 10 pid=10770 fd=8 filename=/tmp/RLmVI1/mntpoint/testdir
fanotify09.c:253: TFAIL: first group got more than 2 events (24 bytes)
fanotify09.c:155: TFAIL: group 1 got event: mask 10 pid=10770 fd=-1 filename=
fanotify09.c:155: TFAIL: group 2 got event: mask 10 pid=10770 fd=-1 filename=
fanotify09.c:210: TINFO: Test #2: Events on non-dir child and parent with both parent and mount marks
fanotify09.c:155: TPASS: group 0 got event: mask 2 pid=10770 fd=9 filename=/tmp/RLmVI1/mntpoint/tfile_10770
fanotify09.c:155: TPASS: group 0 got event: mask 10 pid=10770 fd=10 filename=/tmp/RLmVI1/mntpoint
fanotify09.c:155: TFAIL: group 1 got event: mask 10 pid=10770 fd=-1 filename=
fanotify09.c:155: TFAIL: group 2 got event: mask 10 pid=10770 fd=-1 filename=
fanotify09.c:210: TINFO: Test #3: Events on non-dir child and subdir with both parent and subdir marks
fanotify09.c:155: TPASS: group 0 got event: mask 2 pid=10770 fd=11 filename=/tmp/RLmVI1/mntpoint/tfile_10770
fanotify09.c:155: TPASS: group 0 got event: mask 10 pid=10770 fd=12 filename=/tmp/RLmVI1/mntpoint/testdir
fanotify09.c:283: TPASS: group 1 got no event
fanotify09.c:283: TPASS: group 2 got no event

pvorel: cwd before calling cleanup_fanotify_groups() is /tmp/mKrYUr/mntpoint
then in cleanup we cd .. (/tmp/mKrYUr)

tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try  1...
tst_device.c:394: TINFO: Likely gvfsd-trash is probing newly mounted fs, kill it to speed up tests.
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try  2...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try  3...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try  4...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try  5...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try  6...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try  7...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try  8...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try  9...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 10...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 11...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 12...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 13...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 14...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 15...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 16...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 17...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 18...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 19...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 20...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 21...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 22...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 23...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 24...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 25...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 26...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 27...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 28...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 29...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 30...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 31...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 32...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 33...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 34...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 35...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 36...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 37...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 38...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 39...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 40...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 41...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 42...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 43...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 44...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 45...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 46...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 47...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 48...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 49...
tst_device.c:390: TINFO: umount('mntpoint') failed with EBUSY, try 50...
tst_device.c:400: TWARN: Failed to umount('mntpoint') after 50 retries
fanotify09.c:307: TWARN: umount failed: EBUSY (16)

HINT: You _MAY_ be missing kernel fixes, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54a307ba8d3c
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b469e7e47c8a
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=55bf882c7f13

Summary:
passed   9
failed   7
skipped  0
warnings 2
tst_tmpdir.c:337: TWARN: tst_rmdir: rmobj(/tmp/RLmVI1) failed: remove(/tmp/RLmVI1/mntpoint) failed; errno=16: EBUSY


> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify09.c     | 88 +++++++++++++------
>  1 file changed, 60 insertions(+), 28 deletions(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> index daeb712d2..7bb901cf3 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> @@ -138,42 +138,73 @@ static void cleanup_fanotify_groups(void)
>  }

>  static void event_res(int ttype, int group,
> -		      struct fanotify_event_metadata *event)
> +		      struct fanotify_event_metadata *event,
> +		      const char *filename)
>  {
> -	int len;
> -	sprintf(symlnk, "/proc/self/fd/%d", event->fd);
> -	len = readlink(symlnk, fdpath, sizeof(fdpath));
> -	if (len < 0)
> -		len = 0;
> -	fdpath[len] = 0;
> -	tst_res(ttype, "group %d got event: mask %llx pid=%u fd=%d path=%s",
> +	if (event->fd != FAN_NOFD) {
> +		int len = 0;
> +		sprintf(symlnk, "/proc/self/fd/%d", event->fd);
> +		len = readlink(symlnk, fdpath, sizeof(fdpath));
> +		if (len < 0)
> +			len = 0;
> +		fdpath[len] = 0;
> +		filename = fdpath;
> +	}
> +	tst_res(ttype, "group %d got event: mask %llx pid=%u fd=%d filename=%s",
>  		group, (unsigned long long)event->mask,
> -		(unsigned)event->pid, event->fd, fdpath);
> +		(unsigned)event->pid, event->fd, filename);
> +}
> +
> +static const char *event_filename(struct fanotify_event_metadata *event)
> +{
> +	struct fanotify_event_info_fid *event_fid;
> +	struct file_handle *file_handle;
> +	const char *filename, *end;
> +
> +	if (event->event_len <= FAN_EVENT_METADATA_LEN)
> +		return "";
> +
> +	event_fid = (struct fanotify_event_info_fid *)(event + 1);
> +	file_handle = (struct file_handle *)event_fid->handle;
> +	filename = (char *)file_handle->f_handle + file_handle->handle_bytes;
> +	end = (char *)event_fid + event_fid->hdr.len;
> +
> +	/* End of event_fid could have name, zero padding, both or none */
> +	return (filename == end) ? "" : filename;
>  }

>  static void verify_event(int group, struct fanotify_event_metadata *event,
> -			 uint32_t expect)
> +			 uint32_t expect, const char *expect_filename)
>  {
> +	const char *filename = event_filename(event);
> +
>  	if (event->mask != expect) {
>  		tst_res(TFAIL, "group %d got event: mask %llx (expected %llx) "
> -			"pid=%u fd=%d", group, (unsigned long long)event->mask,
> +			"pid=%u fd=%d filename=%s", group, (unsigned long long)event->mask,
>  			(unsigned long long)expect,
> -			(unsigned)event->pid, event->fd);
> +			(unsigned)event->pid, event->fd, filename);
>  	} else if (event->pid != getpid()) {
>  		tst_res(TFAIL, "group %d got event: mask %llx pid=%u "
> -			"(expected %u) fd=%d", group,
> +			"(expected %u) fd=%d filename=%s", group,
>  			(unsigned long long)event->mask, (unsigned)event->pid,
> -			(unsigned)getpid(), event->fd);
> +			(unsigned)getpid(), event->fd, filename);
> +	} else if (strcmp(filename, expect_filename)) {
> +		tst_res(TFAIL, "group %d got event: mask %llx pid=%u "
> +			"fd=%d filename='%s' (expected '%s')", group,
> +			(unsigned long long)event->mask, (unsigned)event->pid,
> +			event->fd, filename, expect_filename);
>  	} else {
> -		event_res(TPASS, group, event);
> +		event_res(TPASS, group, event, filename);
>  	}
> +	if (event->fd != FAN_NOFD)
> +		SAFE_CLOSE(event->fd);
>  }

>  static void test_fanotify(unsigned int n)
>  {
>  	int ret, dirfd;
>  	unsigned int i;
> -	struct fanotify_event_metadata *event, *ev;
> +	struct fanotify_event_metadata *event;
>  	struct tcase *tc = &tcases[n];

>  	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> @@ -210,20 +241,21 @@ static void test_fanotify(unsigned int n)
>  			ret, tc->nevents * (int)FAN_EVENT_METADATA_LEN);
>  	}
>  	event = (struct fanotify_event_metadata *)event_buf;
> -	verify_event(0, event, FAN_MODIFY);
> -	if (tc->ondir)
> -		verify_event(0, event + 1, FAN_CLOSE_NOWRITE);
> -	if (ret > tc->nevents * (int)FAN_EVENT_METADATA_LEN) {
> +	verify_event(0, event, FAN_MODIFY, "");
> +	event = FAN_EVENT_NEXT(event, ret);
> +	if (tc->ondir) {
> +		verify_event(0, event, FAN_CLOSE_NOWRITE, "");
> +		event = FAN_EVENT_NEXT(event, ret);
> +	}
> +	if (ret > 0) {
>  		tst_res(TFAIL,
> -			"first group got more than %d events (%d > %d)",
> -			tc->nevents, ret,
> -			tc->nevents * (int)FAN_EVENT_METADATA_LEN);
> +			"first group got more than %d events (%d bytes)",
> +			tc->nevents, ret);
>  	}
>  	/* Close all file descriptors of read events */
> -	for (ev = event; ret >= (int)FAN_EVENT_METADATA_LEN; ev++) {
> -		if (ev->fd != FAN_NOFD)
> -			SAFE_CLOSE(ev->fd);
> -		ret -= (int)FAN_EVENT_METADATA_LEN;
> +	for (; FAN_EVENT_OK(event, ret); FAN_EVENT_NEXT(event, ret)) {
> +		if (event->fd != FAN_NOFD)
> +			SAFE_CLOSE(event->fd);
>  	}

>  	/*
> @@ -233,7 +265,7 @@ static void test_fanotify(unsigned int n)
>  	for (i = 1; i < NUM_GROUPS; i++) {
>  		ret = read(fd_notify[i], event_buf, FAN_EVENT_METADATA_LEN);
>  		if (ret > 0) {
> -			event_res(TFAIL, i, event);
> +			event_res(TFAIL, i, event, "");
>  			if (event->fd != FAN_NOFD)
>  				SAFE_CLOSE(event->fd);
>  			continue;
