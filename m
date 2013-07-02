Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UtzVp-00041y-CQ
	for ltp-list@lists.sourceforge.net; Tue, 02 Jul 2013 12:16:49 +0000
Date: Tue, 2 Jul 2013 14:18:19 +0200
From: chrubis@suse.cz
Message-ID: <20130702121818.GA4922@rei>
References: <51D29448.4050507@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D29448.4050507@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mount/mount05.c: new case to test MS_BIND of mount
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> Create new test case for MS_BIND of mount.
> 
> Checking if file is visible from target mountpoint after bind mount.
> 
> 
> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
> ---
>  runtest/syscalls                          |   1 +
>  testcases/kernel/syscalls/.gitignore      |   1 +
>  testcases/kernel/syscalls/mount/mount05.c | 212 ++++++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mount/mount05.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3ab19f5..1e36c92 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -578,6 +578,7 @@ mount01 mount01 -D DEVICE -T DEVICE_FS_TYPE
>  mount02 mount02 -D DEVICE -T DEVICE_FS_TYPE
>  mount03 mount03 -D DEVICE -T DEVICE_FS_TYPE
>  mount04 mount04 -D DEVICE -T DEVICE_FS_TYPE
> +mount05 mount05 -D DEVICE -T DEVICE_FS_TYPE
> 
>  move_pages01 move_pages.sh 01
>  move_pages02 move_pages.sh 02
> diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
> index fede145..6147085 100644
> --- a/testcases/kernel/syscalls/.gitignore
> +++ b/testcases/kernel/syscalls/.gitignore
> @@ -521,6 +521,7 @@
>  /mount/mount02
>  /mount/mount03
>  /mount/mount04
> +/mount/mount05
>  /mount/setuid_test
>  /move_pages/move_pages01
>  /move_pages/move_pages02
> diff --git a/testcases/kernel/syscalls/mount/mount05.c b/testcases/kernel/syscalls/mount/mount05.c
> new file mode 100644
> index 0000000..97fbb48
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount/mount05.c
> @@ -0,0 +1,212 @@
> +/*
> + * Copyright (c) 2013 FNST, DAN LI <li.dan@cn.fujitsu.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2 of the GNU General Public License as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +/**************************************************************************
> + *
> + *    EXECUTED BY	: root / superuser
> + *
> + *    DESCRIPTION
> + *	Test for feature MS_BIND of mount.
> + *	"Perform a bind mount, making a file or a directory subtree visible
> + *	 at another point within a file system."
> + *
> + *	Setup:
> + *	  Setup signal handling.
> + *	  Create a mount point.
> + *	  Pause for SIGUSR1 if option specified.
> + *
> + *	Test:
> + *	 Loop if the proper options are given.
> + *	  Execute system call
> + *	  Check return code, if system call failed (return=-1)
> + *		Log the errno and Issue a FAIL message.
> + *	  Otherwise, Issue a PASS message.
> + *
> + *	Cleanup:
> + *	  Delete the mount point.
> + *
> + *    RESTRICTIONS
> + *	test must run with the -D option
> + *	test doesn't support -c option to run it in parallel, as mount
> + *	syscall is not supposed to run in parallel.
> + *****************************************************************************/
> +
> +#include <errno.h>
> +#include <sys/mount.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +
> +#include "test.h"
> +#include "usctest.h"
> +
> +static void help(void);
> +static void setup(void);
> +static void cleanup(void);
> +
> +char *TCID = "mount05";
> +int TST_TOTAL = 1;
> +
> +#define DEFAULT_FSTYPE	"ext2"
> +#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
> +
> +static char *fs_type;
> +
> +static int tflag;
> +static int dflag;
> +static char *fstype;
> +static char *device;
> +static char file_src[PATH_MAX];
> +static char file_des[PATH_MAX];
> +static char mntpoint_src[PATH_MAX];
> +static char mntpoint_des[PATH_MAX];
> +
> +static option_t options[] = {
> +	{"T:", &tflag, &fstype},
> +	{"D:", &dflag, &device},
> +	{NULL, NULL, NULL},
> +};
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, options, &help);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	/* Check for mandatory option of the testcase */
> +	if (!dflag)
> +		tst_brkm(TBROK, NULL,
> +			 "you must specify the device used for mounting with "
> +			 "the -D option");
> +
> +	if (tflag) {
> +		fs_type = malloc(strlen(fstype) + 1);
> +		if (fs_type == NULL)
> +			tst_brkm(TBROK | TERRNO, NULL,
> +				 "malloc - failed to alloc %zd",
> +				 strlen(fstype));
> +
> +		strncpy(fs_type, fstype, strlen(fstype) + 1);
> +
> +	} else {
> +		fs_type = malloc(strlen(DEFAULT_FSTYPE) + 1);
> +		if (fs_type == NULL)
> +			tst_brkm(TBROK, NULL, "malloc - failed to alloc %zu",
> +				 strlen(DEFAULT_FSTYPE));
> +
> +		strncpy(fs_type, DEFAULT_FSTYPE, strlen(DEFAULT_FSTYPE) + 1);
> +	}
> +

Ah why are you copying the string, and if that is needed what about
using strdup()?

If you need to set the fs_type to either default one or passed one, it
could be done in single assigment:

static const char *fs_type = "ext2";

...

	if (tflag)
		fs_type = fstype;

> +	if (STD_COPIES != 1) {
> +		tst_resm(TINFO, "-c option has no effect for this testcase - "
> +			 "%s doesn't allow running more than one instance "
> +			 "at a time", TCID);
> +		STD_COPIES = 1;
> +	}
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +
> +		tst_count = 0;
> +
> +		TEST(mount(mntpoint_src, mntpoint_des, fs_type, MS_BIND, NULL));
> +
> +		if (TEST_RETURN != 0) {
> +			tst_resm(TFAIL | TTERRNO, "mount(2) failed");
> +		} else {
> +
> +			if (open(file_des, O_CREAT | O_EXCL) == -1 &&
> +			    errno == EEXIST)
> +				tst_resm(TPASS, "bind mount is ok");
> +			else
> +				tst_resm(TFAIL, "file %s is not available",
> +					 file_des);
> +
> +			TEST(umount(mntpoint_des));
> +			if (TEST_RETURN != 0)
> +				tst_brkm(TBROK | TTERRNO, cleanup,
> +					 "umount(2) failed");
> +		}
> +	}
> +
> +	cleanup();
> +
> +	tst_exit();
> +}
> +
> +void setup(void)
> +{
> +	int fd;
> +
> +	tst_require_root(NULL);
> +
> +	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +
> +	tst_tmpdir();
> +
> +	snprintf(mntpoint_src, PATH_MAX, "mnt_src_%d", getpid());
> +	snprintf(mntpoint_des, PATH_MAX, "mnt_des_%d", getpid());

I think that all the work with getpid() to create unique dir names is
pointless since the tst_tmpdir() allready created unique directory for
the test. And if you omit that, all the paths will became constant
strings simplifying the test code.

> +	if (mkdir(mntpoint_src, DIR_MODE) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s, %#o) failed",
> +			 mntpoint_src, DIR_MODE);
> +
> +	if (mkdir(mntpoint_des, DIR_MODE) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup, "mkdir(%s, %#o) failed",
> +			 mntpoint_des, DIR_MODE);

Use SAFE_MKDIR()?

> +	if (mount(device, mntpoint_src, fs_type, 0, NULL) == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "mount failed");

I wonder if we really need to mount something at mntpoint_src, the bind
mount should work with any directory or file in fs hierarchy. Or we can
mount it only if -D option is specified and add two entires into the
runtest file, one with the -D option and one without...

> +	snprintf(file_src, PATH_MAX, "%s/tmpfile", mntpoint_src);
> +	snprintf(file_des, PATH_MAX, "%s/tmpfile", mntpoint_des);
> +
> +	fd = open(file_src, O_CREAT | O_TRUNC, S_IRWXU);
> +	if (fd == -1)
> +		tst_brkm(TBROK, cleanup, "open file failed");
> +	close(fd);

SAFE_FILE_PRINTF(cleanup, path, "") ?

> +	TEST_PAUSE;
> +}
> +
> +void cleanup(void)
> +{
> +	if (fs_type) {
> +		free(fs_type);
> +		fs_type = NULL;
> +	}
> +
> +	if (umount(mntpoint_src) != 0)
> +		tst_brkm(TBROK | TTERRNO, NULL, "umount(2) failed");
> +
> +	TEST_CLEANUP;
> +
> +	tst_rmdir();
> +}
> +
> +/*
> + * issue a help message
> + */

I would say that this comment is pretty useless as it's saying something
that is pretty obvious.

> +void help(void)
> +{
> +	printf("-T type	  : specifies the type of filesystem to be mounted. "
> +	       "Default ext2.\n");
> +	printf("-D device : device used for mounting.\n");
> +}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
