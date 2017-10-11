From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 11:54:45 +0200
Subject: [LTP] [PATCH v2 04/15] lib/tst_test: Add .all_filesystems flag
In-Reply-To: <1573092724.28358902.1507711367946.JavaMail.zimbra@redhat.com>
References: <20171010123205.20147-1-chrubis@suse.cz>
 <20171010123205.20147-4-chrubis@suse.cz>
 <1573092724.28358902.1507711367946.JavaMail.zimbra@redhat.com>
Message-ID: <20171011095445.GA3527@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Overall series looks good to me. My tests on RHEL 5.6/6.0/7.4 and 4.14-rc
> kernels went all without issues. Couple notes below.
> 
> 1) When this is merged, we should also add some notes to docs.
> For example: timeout applies for one filesystem, not all
> combined.

Sure, there is no documentation for the .all_filesystems flag yet, I
will add it for the next iteration.

> 2)
> <snip>
>
> > +static int run_tcases_per_fs(void)
> > +{
> > +	int ret = 0;
> > +	unsigned int i;
> > +	const char *const *filesystems = tst_get_supported_fs_types();
> > +
> > +	if (!filesystems[0])
> > +		tst_brk(TCONF, "There are no supported filesystems");
> > +
> > +	for (i = 0; filesystems[i]; i++) {
> > +		tdev.fs_type = filesystems[i];
> > +
> > +		prepare_device();
> > +
> > +		ret = fork_testrun();
> > +
> > +		if (mntpoint_mounted) {
> > +			tst_umount(tst_test->mntpoint);
> > +			mntpoint_mounted = 0;
> > +		}
> > +
> > +		if (ret == TCONF) {
> > +			update_results(ret);
> > +			continue;
> > +		}
> > +
> > +		if (ret == 0)
> > +			continue;
> > +
> > +		do_exit(ret);
> > +	}
> 
> I'm on the fence here, if we should stop immediately after we get
> a TFAIL or TBROK. For example: Is a TFAIL on ext2 reason to stop
> testing xfs?

I would go for stopping the whole test on TBROK, since we use TBROK for
things that failed but shouldn't and it always had 'stop the test now,
something is horribly broken' semantic.

We probably can handle TFAIL here and continue gracefully. But notice
that the only way to get TFAIL in here is when the test calls
tst_brk(TFAIL, ...), which is very uncommon but indeed possible. That is
since the test process exit value is 0 unless we called tst_brk(). On
the other hand the tst_brk() means stop the test _now_ (unless in
cleanup) in the newlib so it's cleaner desing if we leave this as it is.

> 3) fs_fill test is still quite verbose
> 
> # ./fs_fill > log2 2>&1
> # du -h log2
> 688K	log2
> 
> # grep Got log2
> fs_fill.c:96: PASS: Got 5713 ENOSPC
> fs_fill.c:96: PASS: Got 9 ENOSPC
> fs_fill.c:96: PASS: Got 1709 ENOSPC
> 
> I'm running this on single CPU KVM guest, which is (presumably due to caching
> and host SSD) able to trigger ENOSPC many times in those 2 seconds.
> 
> I expect baremetal systems with many CPUs producing lot of output as well,
> because we start tst_fill_fs() in NR_CPU+2 threads.

Okay. What about rewriting the main loop to sleep in short intervals and
check the ENOSCP counter and exit if reasonably large number was found.

Something as:

	while (enospc_cnt < 100)
		usleep(1000);

That would also make the coverage more stable as well.

-- 
Cyril Hrubis
chrubis@suse.cz
