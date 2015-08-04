Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMg0f-0006H0-Ri
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2015 17:28:17 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMg0d-0001Os-NQ
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2015 17:28:17 +0000
Date: Tue, 4 Aug 2015 19:27:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150804172754.GB20633@rei.suse.de>
References: <1436949363-8356-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
	<1436949363-8356-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436949363-8356-2-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/3] umount2/umount2_02.c: add new test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static void setup(void);
> +static void umount2_verify(void);
> +static int umount2_verify_1(void);
> +static int umount2_verify_2(void);
> +static int umount2_verify_3(void);
> +static void cleanup(void);
> +
> +char *TCID = "umount2_02";
> +int TST_TOTAL = 1;

This is not right. The testcase does four testcases as far as I can
tell. You should print PASS/FAIL for each of them and set TST_TOTAL = 4

> +#define DIR_MODE	(S_IRWXU | S_IRWXG | S_IROTH | S_IXOTH)
> +#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO | S_ISUID | S_ISGID)
> +#define MNTPOINT	"mntpoint"
> +#define EXP_ERRNO	EAGAIN

The EXP_ERRNO is not used at all, forget to remove it?

> +static int fd;
> +static int mount_flag;
> +
> +static const char *device;
> +static const char *fs_type;
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		tst_count = 0;
> +
> +		umount2_verify();
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +
> +	if ((tst_kvercmp(2, 6, 8)) < 0) {
> +		tst_brkm(TCONF, NULL, "This test can only run on kernels "
> +			"that are 2.6.8 or higher");
> +	}
> +
> +	tst_sig(NOFORK, DEF_HANDLER, NULL);
> +
> +	tst_tmpdir();
> +
> +	fs_type = tst_dev_fs_type();
> +	device = tst_acquire_device(cleanup);
> +
> +	if (!device)
> +		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
> +
> +	tst_mkfs(cleanup, device, fs_type, NULL);
> +
> +	SAFE_MKDIR(cleanup, MNTPOINT, DIR_MODE);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void umount2_verify(void)
> +{
> +	SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
> +	mount_flag = 1;
> +
> +	if (umount2_verify_1())
> +		goto EXIT;
> +
> +	if (umount2_verify_2())
> +		goto EXIT;
> +
> +	/* a new accesse removes the expired mark of the mount point */
> +	fd = SAFE_CREAT(cleanup, MNTPOINT "/file", FILE_MODE);
> +
> +	SAFE_CLOSE(cleanup, fd);
> +	fd = 0;
> +
> +	if (umount2_verify_2())
> +		goto EXIT;
> +
> +	if (umount2_verify_3())
> +		goto EXIT;
> +
> +	mount_flag = 0;
> +
> +	tst_resm(TPASS, "umount2(2) Passed");
> +
> +EXIT:
> +	if (mount_flag) {
> +		SAFE_UMOUNT(cleanup, MNTPOINT);
> +		mount_flag = 0;
> +	}
> +}
> +
> +/* MNT_EXPIRE cannot be specified with either MNT_FORCE or MNT_DETACH */
> +static int umount2_verify_1(void)
> +{
> +	TEST(umount2(MNTPOINT, MNT_EXPIRE | MNT_FORCE));
> +
> +	if (TEST_RETURN == 0 || TEST_ERRNO != EINVAL) {
> +		tst_resm(TFAIL | TTERRNO, "umount2(2) MNT_EXPIRE flag "
> +			"performed abnormally "
> +			"expected error = %d : %s",
> +			EINVAL, strerror(EINVAL));
                            ^
			    As last time, do not use strerror().

			    Given that the expected errno will never
			    change we can just print "expected EINVAL"
> +		return 1;
> +	}
> +
> +	TEST(umount2(MNTPOINT, MNT_EXPIRE | MNT_DETACH));
> +
> +	if (TEST_RETURN == 0 || TEST_ERRNO != EINVAL) {
> +		tst_resm(TFAIL | TTERRNO, "umount2(2) MNT_EXPIRE flag "
> +			"performed abnormally "
> +			"expected error = %d : %s",
> +			EINVAL, strerror(EINVAL));
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +/* the initial call to umount2() with MNT_EXPIRE flag */
> +static int umount2_verify_2(void)
> +{
> +	TEST(umount2(MNTPOINT, MNT_EXPIRE));
> +
> +	if (TEST_RETURN == 0 || TEST_ERRNO != EAGAIN) {
> +		tst_resm(TFAIL | TTERRNO, "umount2(2) MNT_EXPIRE flag "
> +			"performed abnormally "
> +			"expected error = %d : %s",
> +			EAGAIN, strerror(EAGAIN));
> +		return 1;
> +	}
> +
> +	return 0;
> +}

This function is nearly identical to to the half of umout_verify_1().
Can you just write one verify function that takes umount flags in
parameters, expected errno and some string that describes what is
tested and use it instead both halfs of umout2_verify_1() and
umout2_verify_2()?

> +/* the second call to umount2() with MNT_EXPIRE flag */
> +static int umount2_verify_3(void)
> +{
> +	TEST(umount2(MNTPOINT, MNT_EXPIRE));
> +
> +	if (TEST_RETURN != 0) {
> +		tst_resm(TFAIL | TTERRNO, "umount2(2) Failed");
> +		return 1;
> +	}
> +
> +	return 0;
> +}

Also naming this umount2_verify_success() would be a bit more
descriptive than adding _3.

> +static void cleanup(void)
> +{
> +	if (fd > 0 && close(fd))
> +		tst_resm(TWARN | TERRNO, "Failed to close file");
> +
> +	if (mount_flag && tst_umount(MNTPOINT))
> +		tst_resm(TWARN | TERRNO, "Failed to unmount");
> +
> +	if (device)
> +		tst_release_device(NULL, device);
> +
> +	tst_rmdir();
> +}
> -- 
> 1.8.4.2
> 
> 
> ------------------------------------------------------------------------------
> Don't Limit Your Business. Reach for the Cloud.
> GigeNET's Cloud Solutions provide you with the tools and support that
> you need to offload your IT needs and focus on growing your business.
> Configured For All Businesses. Start Your Cloud Today.
> https://www.gigenetcloud.com/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
