Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WUeY3-0000wR-7u
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 15:54:55 +0000
Date: Mon, 31 Mar 2014 17:54:18 +0200
From: chrubis@suse.cz
Message-ID: <20140331155418.GA9911@rei.suse.cz>
References: <1395386992-6472-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395386992-6472-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] openat/openat02.c: add a new case to test flags
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +
> +	SAFE_CLOSE(cleanup, TEST_RETURN);
> +
> +	if (wait(&status) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "wait() failed");
> +
> +	if (WIFEXITED(status)) {
> +		switch ((char)WEXITSTATUS(status)) {

This cast to (char) is wrong. The char may or may not be signed variable
and -1 may end up as 255 in case char is unsigned.

Did you get warnings without it?

> +		case -1:
> +			tst_resm(TPASS, "test O_CLOEXEC for openat success");
> +			break;
> +		case 2:
> +			tst_brkm(TBROK, cleanup, "execlp() failed");
> +		default:
> +			tst_resm(TFAIL, "test O_CLOEXEC for openat failed");
> +		}
> +	} else {
> +		tst_brkm(TBROK, cleanup,
> +				 "openat2_exec exits with unexpected error");
> +	}
> +}
> +
> +void testfunc_largefile(void)
> +{
> +	char *device;
> +	int fd;
> +	off64_t offset;
> +
> +	device = getenv("LTP_BIG_DEV");
> +	if (device == NULL) {
> +		tst_resm(TCONF, "you must specify a big blockdevice(>4G)");
> +		return;
> +	} else {
> +		tst_mkfs(NULL, device, "ext3", NULL);
> +	}
> +
> +	SAFE_MKDIR(cleanup, MNT_POINT, 755);
> +
> +	if (mount(device, MNT_POINT, "ext3", 0, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +				 "mount device:%s failed", device);
> +	}
> +
> +	fd = SAFE_OPEN(cleanup, LARGE_FILE,
> +				O_LARGEFILE | O_RDWR | O_CREAT, 0777);
> +
> +	offset = lseek64(fd, 4.1*1024*1024*1024, SEEK_SET);
> +	if (offset == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "lseek64 failed");
> +
> +	SAFE_WRITE(cleanup, 1, fd, STR, sizeof(STR) - 1);
> +
> +	SAFE_CLOSE(cleanup, fd);
> +
> +	TEST(openat(AT_FDCWD, LARGE_FILE, O_LARGEFILE | O_RDONLY, 0777));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL, "test O_LARGEFILE for openat failed");
> +	} else {
> +		tst_resm(TPASS, "test O_LARGEFILE for openat success");
> +		SAFE_CLOSE(cleanup, TEST_RETURN);
> +	}
> +
> +	if (umount(MNT_POINT) == -1)
> +		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);

Hmm, did you do this because your distro has /tmp on tmpfs?

I would rather default to /tmp and use the BIG_DEV only if /tmp is not
suitable for the test.

> +}
> +
> +void testfunc_noatime(void)
> +{
> +	struct stat file_stat, file_newstat;
> +	struct stat tmp_stat;
> +	FILE *fp = NULL;
> +	struct mntent *mnt = NULL;
> +	char buf;
> +
> +	if ((tst_kvercmp(2, 6, 8)) < 0) {
> +		tst_resm(TCONF, "test O_NOATIME flags for openat "
> +						"needs kernel 2.6.8 or higher");
> +		return;
> +	}
> +
> +	SAFE_STAT(cleanup, TEST_FILE, &file_stat);
> +
> +	fp = setmntent("/etc/mtab", "r");
> +	if (fp == NULL)
> +		tst_brkm(TBROK | TERRNO, cleanup, "setmntent() failed");
> +
> +	while ((mnt = getmntent(fp))) {
> +		SAFE_STAT(cleanup, mnt->mnt_dir, &tmp_stat);
> +
> +		if (tmp_stat.st_dev == file_stat.st_dev)
> +			break;
> +	}
> +	if (mnt == NULL)
> +		tst_brkm(TBROK, cleanup,
> +				 "getmntent() failed or no matching device");
> +
> +	endmntent(fp);
> +
> +	if (hasmntopt(mnt, "noatime") != NULL
> +		|| hasmntopt(mnt, "reltime") != NULL) {
> +		tst_resm(TCONF, "test O_NOATIME flag for openat needs "
> +						"filesystems which are mounted without "
> +						"noatime and relatime");
> +		return;
> +	}

The noatime detection should go to the test library. What about
tst_path_has_mnt_flags(const char *path, const char *flags[]) function?
(flags is NULL terminated array of strings).

Have a look at a simlar function I've wrote for open posix testsuite in
open_posix_testsuite/include/noatime.h. All that should be needed is to
drop the __linux__ ifdefs and use the flags argument instead of of the
hardcoded string.

> +	sleep(2);
> +
> +	TEST(openat(AT_FDCWD, TEST_FILE, O_NOATIME | O_RDONLY, 0777));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TTERRNO, "openat failed");
> +		return;
> +	}
> +
> +	SAFE_READ(cleanup, 1, TEST_RETURN, &buf, 1);
> +
> +	SAFE_CLOSE(cleanup, TEST_RETURN);
> +
> +	SAFE_STAT(cleanup, TEST_FILE, &file_newstat);
> +
> +	if (file_stat.st_atime == file_newstat.st_atime)
> +		tst_resm(TPASS, "test O_NOATIME for openat success");
> +	else
> +		tst_resm(TFAIL, "test O_NOATIME for openat failed");
> +}
> +
> +void testfunc_nofollow(void)
> +{
> +	TEST(openat(AT_FDCWD, SFILE, O_NOFOLLOW | O_RDONLY, 0777));
> +
> +	if (TEST_RETURN == -1) {

You should check that errno is ELOOP too.

> +		tst_resm(TPASS, "test O_NOFOLLOW for openat success");
> +	} else {
> +		tst_resm(TFAIL, "test O_NOFOLLOW for openat failed");
> +		SAFE_CLOSE(cleanup, TEST_RETURN);
> +	}
> +}
> +
> +void testfunc_trunc(void)
> +{
> +	struct stat file_stat;
> +
> +	TEST(openat(AT_FDCWD, TEST_FILE, O_TRUNC | O_RDWR, 0777));
> +
> +	if (TEST_RETURN == -1) {
> +		tst_resm(TFAIL | TTERRNO, "openat failed");
> +		return;
> +	}
> +
> +	SAFE_FSTAT(cleanup, TEST_RETURN, &file_stat);
> +
> +	if (file_stat.st_size == 0)
> +		tst_resm(TPASS, "test O_TRUNC for openat success");
> +	else
> +		tst_resm(TFAIL, "test O_TRUNC for openat failed");
> +
> +	SAFE_CLOSE(cleanup, TEST_RETURN);

Hmm this will truncate the test file. Does the testcase work with -i 2,
because the testfunc_append() expect that the file is not empty, right?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
