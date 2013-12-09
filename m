Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vq3dz-00088H-9C
	for ltp-list@lists.sourceforge.net; Mon, 09 Dec 2013 16:25:15 +0000
Date: Mon, 9 Dec 2013 17:24:39 +0100
From: chrubis@suse.cz
Message-ID: <20131209162439.GA20068@rei.suse.cz>
References: <1386331038.2041.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386331038.2041.1.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2 2/2] fchmod/fchmod06.c: add EROFS test for
	fchmod(2)
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
To: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> add EROFS test in fchmod06.c
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  runtest/ltplite                             |  2 +-
>  runtest/stress.part3                        |  2 +-
>  runtest/syscalls                            |  2 +-
>  testcases/kernel/syscalls/fchmod/fchmod06.c | 64 ++++++++++++++++++++++++++++-
>  4 files changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/runtest/ltplite b/runtest/ltplite
> index 2382dec..253d91e 100644
> --- a/runtest/ltplite
> +++ b/runtest/ltplite
> @@ -183,7 +183,7 @@ fchmod02 fchmod02
>  fchmod03 fchmod03
>  fchmod04 fchmod04
>  fchmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchmod05
> -fchmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchmod06
> +fchmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchmod06 -D DEVICE -T DEVICE_FS_TYPE
>  fchmod07 fchmod07
>  
>  fchown01 fchown01
> diff --git a/runtest/stress.part3 b/runtest/stress.part3
> index 16247e9..5eca4f0 100644
> --- a/runtest/stress.part3
> +++ b/runtest/stress.part3
> @@ -124,7 +124,7 @@ fchmod02 fchmod02
>  fchmod03 fchmod03
>  fchmod04 fchmod04
>  fchmod05 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchmod05
> -fchmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchmod06
> +fchmod06 cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR;fchmod06 -D DEVICE -T DEVICE_FS_TYPE
>  fchmod07 fchmod07
>  
>  fchown01 fchown01
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 12bae10..adc5b6f 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -172,7 +172,7 @@ fchmod02 fchmod02
>  fchmod03 fchmod03
>  fchmod04 fchmod04
>  fchmod05 fchmod05
> -fchmod06 fchmod06
> +fchmod06 fchmod06 -D DEVICE -T DEVICE_FS_TYPE
>  fchmod07 fchmod07

It looks like the 'cp -p $LTPROOT/testcases/bin/change_owner $TMPDIR' is
a mistake. It's not used by the testcase at all.

Moreover 'git grep change_owner' does not seem to suggest any usage.

Looking into the git log the usage of change_owner was removed but the
runtest files were not updated and the file wasn't deleted from the
tree.

Can you please test that chmod and fchmod testcases runs fine without
the change_owner binary in the runtest files and with the change owner
srouce source removed from their directories and send a patch to remove
them?

>  #fchmodat test cases diff --git
>  a/testcases/kernel/syscalls/fchmod/fchmod06.c
>  b/testcases/kernel/syscalls/fchmod/fchmod06.c index 93895a0..9608673
>  100644 --- a/testcases/kernel/syscalls/fchmod/fchmod06.c +++
>  b/testcases/kernel/syscalls/fchmod/fchmod06.c @@ -38,6 +38,7 @@
>  #include <unistd.h> #include <grp.h> #include <pwd.h> +#include
>  <sys/mount.h>
>  
>  #include "test.h" #include "usctest.h" @@ -45,6 +46,17 @@
>  
>  static int fd1; static int fd2; +static int fd3; +static char *fstype
>  = "ext2"; +static char *device; +static int dflag; +static int
>  mount_flag; + +static option_t options[] = { +	{"T:", NULL,
>  &fstype}, +	{"D:", &dflag, &device}, +	{NULL, NULL, NULL} +};
>  
>  static struct test_case_t { char *name; @@ -54,14 +66,16 @@ static
>  struct test_case_t { } test_cases[] = { {"EPERM", &fd1, 0644, EPERM},
>  {"EBADF", &fd2, 0644, EBADF}, +	{"EROFS", &fd3, 0644, EROFS}, };
>  
>  char *TCID = "fchmod06"; int TST_TOTAL = ARRAY_SIZE(test_cases);
>  -static int exp_enos[] = { EPERM, EBADF, 0 }; +static int exp_enos[]
>  = { EPERM, EBADF, EROFS, 0 };
>  
>  static void setup(void); static void cleanup(void); +static void
>  help(void);
>  
>  int main(int ac, char **av) { @@ -69,9 +83,17 @@ int main(int ac,
>  char **av) char *msg; int i;
>  
> -	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) +	msg =
> parse_opts(ac, av, options, help); +	if (msg != NULL) tst_brkm(TBROK,
> NULL, "OPTION PARSING ERROR - %s", msg);
>  
> +	/* Check for mandatory option of the testcase */ +	if
> (!dflag) { +		tst_brkm(TBROK, NULL, +			 "you
> must specify the device used for mounting with " +
> "-D option"); +	} + setup();
>  
>  	TEST_EXP_ENOS(exp_enos); @@ -122,6 +144,30 @@ static void
>  	setup(void)
>  
>  	tst_tmpdir();
>  
> +	tst_mkfs(NULL, device, fstype, NULL); + +
> SAFE_MKDIR(cleanup, "mntpoint", 0755); + +	if (mount(device,
> "mntpoint", fstype, 0, NULL) < 0) { +		tst_brkm(TBROK | TERRNO,
> cleanup, +			 "mount device:%s failed", device); +
> } +	mount_flag = 1; + +	/* Create a file in the file system,
> then remount it as read-only */ +	fd3 = SAFE_CREAT(cleanup,
> "mntpoint/tfile_3", 0644); + +	SAFE_CLOSE(cleanup, fd3);

I've changed this two for SAFE_TOUCH() as:

-       fd3 = SAFE_CREAT(cleanup, "mntpoint/tfile_3", 0644);
-
-       SAFE_CLOSE(cleanup, fd3);
+       SAFE_TOUCH(cleanup, "mntpoint/tfile_3", 0644, NULL);


The rest was fine, pushed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
