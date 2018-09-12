From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 12 Sep 2018 04:33:42 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] syscalls/statx05: Fix test on ppc64le
In-Reply-To: <20180911153013.2609-2-chrubis@suse.cz>
References: <20180911153013.2609-1-chrubis@suse.cz>
 <20180911153013.2609-2-chrubis@suse.cz>
Message-ID: <831588265.47297951.1536741222106.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Apparently the block size for ext4 filesystem has to match $PAGE_SIZE in
> order to be mounted with the crypt option.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/statx/statx05.c | 33
>  +++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx05.c
> b/testcases/kernel/syscalls/statx/statx05.c
> index 11f1fb7bc..0a7a42f13 100644
> --- a/testcases/kernel/syscalls/statx/statx05.c
> +++ b/testcases/kernel/syscalls/statx/statx05.c
> @@ -19,14 +19,17 @@
>   * Minimum kernel version required is 4.11.
>   */
>  
> +#include <stdlib.h>
> +#include <stdio.h>
>  #include "tst_test.h"
>  #include "lapi/fs.h"
> -#include <stdlib.h>
>  #include "lapi/stat.h"
>  
> -#define MOUNT_POINT "mnt_point"
> -#define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
> -#define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
> +#define MNTPOINT "mnt_point"
> +#define TESTDIR_FLAGGED MNTPOINT"/test_dir1"
> +#define TESTDIR_UNFLAGGED MNTPOINT"/test_dir2"
> +
> +static int mount_flag;
>  
>  static void test_flagged(void)
>  {
> @@ -80,6 +83,15 @@ static void run(unsigned int i)
>  
>  static void setup(void)
>  {
> +	char opt_bsize[32];
> +	const char *const extra_opts[] = {"-O encrypt", opt_bsize, NULL};
> +
> +	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", getpagesize());
> +
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, NULL, extra_opts);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);
> +	mount_flag = 1;
> +
>  	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
>  	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
>  
> @@ -92,15 +104,20 @@ static void setup(void)
>  		tst_brk(TCONF, "e4crypt failed (CONFIG_EXT4_ENCRYPTION not set?)");
>  }
>  
> +static void cleanup(void)
> +{
> +	if (mount_flag)
> +		tst_umount(MNTPOINT);
> +}
> +
>  static struct tst_test test = {
>  	.test = run,
>  	.tcnt = ARRAY_SIZE(tcases),
>  	.setup = setup,
> +	.cleanup = cleanup,
>  	.min_kver = "4.11",
>  	.needs_root = 1,
> -	.mount_device = 1,
> -	.mntpoint = MOUNT_POINT,
> +	.needs_device = 1,
> +	.mntpoint = MNTPOINT,
>  	.dev_fs_type = "ext4",

It's not easy to guess what role library plays, when only needs_device is
used, but you set also dev_fs_type and mntpoint. If you dropped both,
then all needed would be to MKDIR/RMDIR(mntpoint), correct?

Anyway, ACK to both patches.

Regards,
Jan

> -	.dev_extra_opts = (const char *const[]){"-O encrypt", NULL},
> -	.dev_min_size = 512,
>  };
> --
> 2.16.4
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
