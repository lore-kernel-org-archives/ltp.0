Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEbfH-00050v-7t
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 11:12:51 +0000
Date: Mon, 13 Jul 2015 13:11:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150713111120.GC2900@rei.suse.de>
References: <1436230882-3282-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436230882-3282-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/3] umount2/umount2_01.c: add new test
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
> +#ifndef MNT_DETACH
> +#define MNT_DETACH 2
> +#endif
> +
> +#ifndef MNT_EXPIRE
> +#define MNT_EXPIRE 4
> +#endif
> +
> +#ifndef UMOUNT_NOFOLLOW
> +#define UMOUNT_NOFOLLOW 8
> +#endif

We may add these to allready exsting lapi/mount.h.

> +static int fd;
> +static int fd_new;
> +static int mount_flag;
> +
> +static char buf[256];
> +
> +static const char *device;
> +static const char *fs_type;
> +static const char *str = "abcdefghijklmnopqrstuvwxyz";

The buf and str are used only in the verify function, why don't decleare
them as local variables there?

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
> +	fd = SAFE_CREAT(cleanup, MNTPOINT "/file", FILE_MODE);
> +
> +	do {
> +		TEST(umount2(MNTPOINT, MNT_DETACH));
> +
> +		if (TEST_RETURN != 0) {
> +			tst_resm(TFAIL, "umount2(2) Failed while "
> +				"unmounting %s errno = %d : %s",
> +				MNTPOINT, TEST_ERRNO,
> +				strerror(TEST_ERRNO));

                                Use TFAIL | TTERRNO instead of printing
				the TEST_ERRNO yourself.

> +			break;
> +		}
> +
> +		mount_flag = 0;
> +
> +		/* check the unavailability for new access */
> +		fd_new = open(MNTPOINT "/file", O_RDONLY);

                What about access() with F_OK instead?

> +		if (fd_new != -1) {
> +			tst_resm(TFAIL, "umount2(2) MNT_DETACH flag "
> +				"performed abnormally "
> +				"expected error = %d : %s",
> +				ENOENT, strerror(ENOENT));

                                Eh, this is misleading, the errno may
				NOT be ENOENT here.

> +			break;
> +		}
> +
> +		/*
> +		 * check the old fd still points to the file
> +		 * in previous mount point and is available
> +		 */
> +		SAFE_WRITE(cleanup, 0, fd, str, strlen(str));

The second parameter should be set to 1 here as we want to assert that
the whole buffer was written. And the same for the SAFE_READ() below.

> +		SAFE_CLOSE(cleanup, fd);
> +
> +		SAFE_MOUNT(cleanup, device, MNTPOINT, fs_type, 0, NULL);
> +		mount_flag = 1;
> +
> +		fd = SAFE_OPEN(cleanup, MNTPOINT "/file", O_RDONLY);
> +
> +		SAFE_READ(cleanup, 0, fd, buf, 255);
> +
> +		if (strcmp(str, buf)) {
> +			tst_resm(TFAIL, "umount2(2) MNT_DETACH flag "
> +				"performed abnormally");
> +			break;
> +		}
> +
> +		tst_resm(TPASS, "umount2(2) Passed");
> +	} while (0);

The do { } while (0); here is ugly as it adds unceccessary level of
indentation. Either use tst_brkm() instead of tst_resm() or use the
kernel style goto (have a look at Linux kernel CodingStyle if you are
not familiar with that).

> +	if (fd_new > 0) {
> +		SAFE_CLOSE(cleanup, fd_new);
> +		fd_new = 0;
> +	}
> +
> +	SAFE_CLOSE(cleanup, fd);
> +	fd = 0;
> +
> +	if (mount_flag) {
> +		SAFE_UMOUNT(cleanup, MNTPOINT);
> +		mount_flag = 0;
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd_new > 0 && close(fd_new))
> +		tst_resm(TWARN | TERRNO, "Failed to close file");
> +
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
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
