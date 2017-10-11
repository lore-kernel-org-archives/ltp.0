From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Oct 2017 04:42:47 -0400 (EDT)
Subject: [LTP] [PATCH v2 04/15] lib/tst_test: Add .all_filesystems flag
In-Reply-To: <20171010123205.20147-4-chrubis@suse.cz>
References: <20171010123205.20147-1-chrubis@suse.cz>
 <20171010123205.20147-4-chrubis@suse.cz>
Message-ID: <1573092724.28358902.1507711367946.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This commit adds a support for re-runing a test on all available
> filesystems simply by turning on .all_filesystems flag in the tst_test
> structure.
> 
> The .all_filesystems flag implies .needs_device, the .format_filesystem and
> .mount_filesystem works as usuall but the device is formatted and mounted for
> each filesystem before we run the test function. The .setup and .cleanup
> functions are executed for each filesystem. The currently tested filesystem
> type is stored in the tst_device->fs_type.
> 
> This allows us to easily run a test that tests filesystem specific
> syscall for all supported filesystems without a need to hardcode all fs
> types into a runtest file and with a minimal changes to the test code.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Hi,

Overall series looks good to me. My tests on RHEL 5.6/6.0/7.4 and 4.14-rc
kernels went all without issues. Couple notes below.

1) When this is merged, we should also add some notes to docs.
For example: timeout applies for one filesystem, not all
combined.

2)
<snip>

> +static int run_tcases_per_fs(void)
> +{
> +	int ret = 0;
> +	unsigned int i;
> +	const char *const *filesystems = tst_get_supported_fs_types();
> +
> +	if (!filesystems[0])
> +		tst_brk(TCONF, "There are no supported filesystems");
> +
> +	for (i = 0; filesystems[i]; i++) {
> +		tdev.fs_type = filesystems[i];
> +
> +		prepare_device();
> +
> +		ret = fork_testrun();
> +
> +		if (mntpoint_mounted) {
> +			tst_umount(tst_test->mntpoint);
> +			mntpoint_mounted = 0;
> +		}
> +
> +		if (ret == TCONF) {
> +			update_results(ret);
> +			continue;
> +		}
> +
> +		if (ret == 0)
> +			continue;
> +
> +		do_exit(ret);
> +	}

I'm on the fence here, if we should stop immediately after we get
a TFAIL or TBROK. For example: Is a TFAIL on ext2 reason to stop
testing xfs?

3) fs_fill test is still quite verbose

# ./fs_fill > log2 2>&1
# du -h log2
688K	log2

# grep Got log2
fs_fill.c:96: PASS: Got 5713 ENOSPC
fs_fill.c:96: PASS: Got 9 ENOSPC
fs_fill.c:96: PASS: Got 1709 ENOSPC

I'm running this on single CPU KVM guest, which is (presumably due to caching
and host SSD) able to trigger ENOSPC many times in those 2 seconds.

I expect baremetal systems with many CPUs producing lot of output as well,
because we start tst_fill_fs() in NR_CPU+2 threads.

Regards,
Jan
