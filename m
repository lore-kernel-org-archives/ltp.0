Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDykV-0005Wf-BL
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 16:02:51 +0000
Date: Thu, 13 Feb 2014 17:02:42 +0100
From: chrubis@suse.cz
Message-ID: <20140213160241.GB17666@rei.suse.cz>
References: <1385101595.1552.11.camel@G08JYZSD130126>
	<20131209165309.GA20943@rei.suse.cz>
	<1390209846.6682.8.camel@G08JYZSD130126>
	<1390210118.6682.10.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390210118.6682.10.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/2] fchown/fchown04.c: add EROFS error number
	test
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> Add EROFS error number test for fchown(2)
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  runtest/ltplite                             |  2 +-
>  runtest/stress.part3                        |  2 +-
>  runtest/syscalls                            |  4 +-
>  testcases/kernel/syscalls/fchown/fchown04.c | 57 ++++++++++++++++++++++++++++-
>  4 files changed, 59 insertions(+), 6 deletions(-)
> 
> diff --git a/runtest/ltplite b/runtest/ltplite
> index c90bc48..c553746 100644
> --- a/runtest/ltplite
> +++ b/runtest/ltplite
> @@ -189,7 +189,7 @@ fchmod07 fchmod07
>  fchown01 fchown01
>  fchown02 fchown02
>  fchown03 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchown03
> -fchown04 export change_owner=$LTPROOT/testcases/bin/change_owner;fchown04
> +fchown04 fchown04 -D DEVICE -T DEVICE_FS_TYPE
>  fchown05 fchown05

I've looked around the sources (git grep change_owner) and it looks like
none of the tests uses the change_owner anymore. Can you please send a
separate patch that removes the change_owner source code and cleans up
the referencies from runtest files and .gitignore?

Also please change the DEVICE and DEVICE_FS_TYPE to the new $LTP_DEV and
$LTP_DEV_FS_TYPE format.

> --- a/testcases/kernel/syscalls/fchown/fchown04.c
> +++ b/testcases/kernel/syscalls/fchown/fchown04.c
> @@ -25,6 +25,8 @@
>   *	not super user.
>   *   2) fchown(2) returns -1 and sets errno to EBADF if the file descriptor
>   *	of the specified file is not valid.
> + *   3) fchown(2) returns -1 and sets errno to EROFS if the named file resides
> + *	on a read-only file system.
>   */
>  
>  #include <stdio.h>
> @@ -38,14 +40,28 @@
>  #include <pwd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/mount.h>
>  
>  #include "test.h"
>  #include "usctest.h"
>  #include "safe_macros.h"
>  
> +#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
> +			 S_IXGRP|S_IROTH|S_IXOTH)
>  
>  static int fd1;
>  static int fd2;
> +static int fd3;
> +static char *fstype = "ext2";
> +static char *device;
> +static int dflag;
> +static int mount_flag;
> +
> +static option_t options[] = {
> +	{"T:", NULL, &fstype},
> +	{"D:", &dflag, &device},
> +	{NULL, NULL, NULL}
> +};
>  
>  static struct test_case_t {
>  	int *fd;
> @@ -53,15 +69,17 @@ static struct test_case_t {
>  } test_cases[] = {
>  	{&fd1, EPERM},
>  	{&fd2, EBADF},
> +	{&fd3, EROFS},
>  };
>  
>  char *TCID = "fchown04";
>  int TST_TOTAL = ARRAY_SIZE(test_cases);
> -static int exp_enos[] = { EPERM, EBADF, 0 };
> +static int exp_enos[] = { EPERM, EBADF, EROFS, 0 };
>  
>  static void setup(void);
>  static void fchown_verify(int);
>  static void cleanup(void);
> +static void help(void);
>  
>  int main(int ac, char **av)
>  {
> @@ -69,10 +87,16 @@ int main(int ac, char **av)
>  	char *msg;
>  	int i;
>  
> -	msg = parse_opts(ac, av, NULL, NULL);
> +	msg = parse_opts(ac, av, options, help);
>  	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
> +	if (!dflag) {
> +		tst_brkm(TBROK, NULL,
> +			 "you must specify the device used for mounting with "
> +			 "-D option");
> +	}

There is no need for the dflag. The device is static and initialized to
NULL so you can do if (!device) instead.

>  	setup();
>  
>  	TEST_EXP_ENOS(exp_enos);
> @@ -107,6 +131,21 @@ static void setup(void)
>  
>  	fd2 = -1;
>  
> +	tst_mkfs(NULL, device, fstype, NULL);
> +	SAFE_MKDIR(cleanup, "mntpoint", DIR_MODE);
> +	if (mount(device, "mntpoint", fstype, 0, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "mount device:%s failed", device);
> +	}
> +	mount_flag = 1;
> +	SAFE_TOUCH(cleanup, "mntpoint/tfile_3", 0644, NULL);
> +	if (mount(device, "mntpoint", fstype,
> +		  MS_REMOUNT | MS_RDONLY, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "mount device:%s failed", device);
> +	}
> +	fd3 = SAFE_OPEN(cleanup, "mntpoint/tfile_3", O_RDONLY);
> +
>  	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
>  	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
>  }
> @@ -137,5 +176,19 @@ static void cleanup(void)
>  
>  	SAFE_CLOSE(NULL, fd1);
>  
> +	SAFE_CLOSE(NULL, fd3);
> +
> +	if (mount_flag && umount("mntpoint") < 0) {
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			 "umount device:%s failed", device);

I wonder if it's right to call tst_brkm() here. Do we really want to
exit the cleanup() if we fail to umount the the device?

Also the problem with tst_brkm() is that it sometimes exits the
cleanup() which itself is a reason for avoiding tst_brkm() in cleanup().
(Currently it depends on whether callback() was called from tst_brkm()
or whether we called callback() directly which is another reason why the
hack from tst_brk() should go away...)

> +	}
> +
>  	tst_rmdir();
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
