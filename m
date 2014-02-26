Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1WIdq2-00066N-Mw
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 12:43:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WIdq0-0003yZ-Tg
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 12:43:50 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1QChZWK009155
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 20:43:35 +0800
Message-ID: <530DE066.2000105@cn.fujitsu.com>
Date: Wed, 26 Feb 2014 20:39:02 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1393417946-8817-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1393417946-8817-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1393417946-8817-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 2/2] mknod/mknod07.c: add EROFS and ELOOP error
 value tests
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
To: LTP <ltp-list@lists.sourceforge.net>

Hi,

Please review this patch, fix some issues Cyril pointed out in fchownat()'s patch.

Thanks,
Xiaoguang Wang


On 02/26/2014 08:32 PM, Xiaoguang Wang wrote:
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  runtest/ltplite                           |  2 +-
>  runtest/stress.part3                      |  2 +-
>  runtest/syscalls                          |  2 +-
>  testcases/kernel/syscalls/mknod/mknod07.c | 64 ++++++++++++++++++++++++++++++-
>  4 files changed, 65 insertions(+), 5 deletions(-)
>
> diff --git a/runtest/ltplite b/runtest/ltplite
> index 4bd1c53..f7127fe 100644
> --- a/runtest/ltplite
> +++ b/runtest/ltplite
> @@ -431,7 +431,7 @@ mknod03 mknod03
>  mknod04 mknod04
>  mknod05 mknod05
>  mknod06 mknod06
> -mknod07 mknod07
> +mknod07 mknod07 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
>  mknod08 mknod08
>  mknod09 mknod09
>  
> diff --git a/runtest/stress.part3 b/runtest/stress.part3
> index d631c19..2f31e93 100644
> --- a/runtest/stress.part3
> +++ b/runtest/stress.part3
> @@ -364,7 +364,7 @@ mknod03 mknod03
>  mknod04 mknod04
>  mknod05 mknod05
>  mknod06 mknod06
> -mknod07 mknod07
> +mknod07 mknod07 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
>  mknod08 mknod08
>  mknod09 mknod09
>  
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 49e3e79..f6b00d9 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -553,7 +553,7 @@ mknod03 mknod03
>  mknod04 mknod04
>  mknod05 mknod05
>  mknod06 mknod06
> -mknod07 mknod07
> +mknod07 mknod07 -D $LTP_DEV -T $LTP_DEV_FS_TYPE
>  mknod08 mknod08
>  mknod09 mknod09
>  
> diff --git a/testcases/kernel/syscalls/mknod/mknod07.c b/testcases/kernel/syscalls/mknod/mknod07.c
> index ea17eef..8b4d494 100644
> --- a/testcases/kernel/syscalls/mknod/mknod07.c
> +++ b/testcases/kernel/syscalls/mknod/mknod07.c
> @@ -26,6 +26,10 @@
>   *	the caller is not super-user.
>   *   2) mknod(2) returns -1 and sets errno to EACCES if parent directory
>   *	does not allow  write  permission  to  the process.
> + *   3) mknod(2) returns -1 and sets errno to EROFS if pathname refers to
> + *	a file on a read-only file system.
> + *   4) mknod(2) returns -1 and sets errno to ELOOP if too many symbolic
> + *	links were encountered in resolving pathname.
>   *
>   */
>  
> @@ -38,6 +42,7 @@
>  #include <pwd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/mount.h>
>  
>  #include "test.h"
>  #include "usctest.h"
> @@ -45,12 +50,29 @@
>  
>  #define DIR_TEMP		"testdir_1"
>  #define DIR_TEMP_MODE		(S_IRUSR | S_IXUSR)
> +#define DIR_MODE		(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
> +				 S_IXGRP|S_IROTH|S_IXOTH)
> +#define MNT_POINT		"mntpoint"
>  
>  #define FIFO_MODE	(S_IFIFO | S_IRUSR | S_IRGRP | S_IROTH)
>  #define SOCKET_MODE	(S_IFSOCK | S_IRWXU | S_IRWXG | S_IRWXO)
>  #define CHR_MODE	(S_IFCHR | S_IRUSR | S_IWUSR)
>  #define BLK_MODE	(S_IFBLK | S_IRUSR | S_IWUSR)
>  
> +#define ELOPFILE	"/test_eloop"
> +
> +static char elooppathname[sizeof(ELOPFILE) * 43] = ".";
> +
> +static char *fstype = "ext2";
> +static char *device;
> +static int mount_flag;
> +
> +static option_t options[] = {
> +	{"T:", NULL, &fstype},
> +	{"D:", NULL, &device},
> +	{NULL, NULL, NULL},
> +};
> +
>  static struct test_case_t {
>  	char *pathname;
>  	int mode;
> @@ -60,15 +82,18 @@ static struct test_case_t {
>  	{ "testdir_1/tnode_2", FIFO_MODE, EACCES },
>  	{ "tnode_3", CHR_MODE, EPERM },
>  	{ "tnode_4", BLK_MODE, EPERM },
> +	{ "mntpoint/tnode_5", SOCKET_MODE, EROFS },
> +	{ elooppathname, FIFO_MODE, ELOOP },
>  };
>  
>  char *TCID = "mknod07";
>  int TST_TOTAL = ARRAY_SIZE(test_cases);
> -static int exp_enos[] = { EPERM, EACCES, 0 };
> +static int exp_enos[] = { EPERM, EACCES, EROFS, ELOOP, 0 };
>  
>  static void setup(void);
>  static void mknod_verify(const struct test_case_t *test_case);
>  static void cleanup(void);
> +static void help(void);
>  
>  int main(int ac, char **av)
>  {
> @@ -76,10 +101,15 @@ int main(int ac, char **av)
>  	char *msg;
>  	int i;
>  
> -	msg = parse_opts(ac, av, NULL, NULL);
> +	msg = parse_opts(ac, av, options, help);
>  	if (msg != NULL)
>  		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
>  
> +	if (!device) {
> +		tst_brkm(TBROK, NULL, "you must specify the device "
> +			 "used for mounting with -D option");
> +	}
> +
>  	setup();
>  
>  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> @@ -95,10 +125,13 @@ int main(int ac, char **av)
>  
>  static void setup(void)
>  {
> +	int i;
>  	struct passwd *ltpuser;
>  
>  	tst_require_root(NULL);
>  
> +	tst_mkfs(NULL, device, fstype, NULL);
> +
>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>  
>  	TEST_EXP_ENOS(exp_enos);
> @@ -107,10 +140,27 @@ static void setup(void)
>  
>  	TEST_PAUSE;
>  
> +	/* mount a read-only file system for EROFS test */
> +	SAFE_MKDIR(cleanup, MNT_POINT, DIR_MODE);
> +	if (mount(device, MNT_POINT, fstype, MS_RDONLY, NULL) < 0) {
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			 "mount device:%s failed", device);
> +	}
> +	mount_flag = 1;
> +
>  	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
>  	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
>  
>  	SAFE_MKDIR(cleanup, DIR_TEMP, DIR_TEMP_MODE);
> +
> +	/*
> +	 * NOTE: the ELOOP test is written based on that the consecutive
> +	 * symlinks limits in kernel is hardwired to 40.
> +	 */
> +	SAFE_MKDIR(cleanup, "test_eloop", DIR_MODE);
> +	SAFE_SYMLINK(cleanup, "../test_eloop", "test_eloop/test_eloop");
> +	for (i = 0; i < 43; i++)
> +		strcat(elooppathname, ELOPFILE);
>  }
>  
>  static void mknod_verify(const struct test_case_t *test_case)
> @@ -139,5 +189,15 @@ static void cleanup(void)
>  	if (seteuid(0) == -1)
>  		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
>  
> +	if (mount_flag && umount(MNT_POINT) < 0)
> +		tst_resm(TWARN | TERRNO, "umount device:%s failed", device);
> +
>  	tst_rmdir();
>  }
> +
> +static void help(void)
> +{
> +	printf("-T type   : specifies the type of filesystem to be mounted. "
> +	       "Default ext2.\n");
> +	printf("-D device : device used for mounting.\n");
> +}


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
