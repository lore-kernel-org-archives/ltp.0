Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YG7cl-0001P3-NN
	for ltp-list@lists.sourceforge.net; Tue, 27 Jan 2015 15:00:15 +0000
Date: Tue, 27 Jan 2015 16:00:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150127150006.GE16759@rei.suse.de>
References: <1422323457-184525-1-git-send-email-shengyong1@huawei.com>
	<1422323457-184525-3-git-send-email-shengyong1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422323457-184525-3-git-send-email-shengyong1@huawei.com>
Subject: Re: [LTP] [RESEND PATCH v3 2/4] lib/tst_fs_link_count.c: check fs
 type and do not fill subdir if no limit
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
To: Sheng Yong <shengyong1@huawei.com>
Cc: ltp-list@lists.sourceforge.net

> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  doc/test-writing-guidelines.txt |  5 ++++-
>  lib/tst_fs_link_count.c         | 35 +++++++++++++++++++++++++++++++++--
>  2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index a59fdd9..8f690f7 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -892,7 +892,10 @@ int tst_fs_fill_subdirs(void (*cleanup)(void), const char *dir);
>  
>  Try to get maximum number of subdirectories in directory.
>  
> -NOTE: This number depends on the filesystem 'dir' is on.
> +NOTE: This number depends on the filesystem 'dir' is on. For current kernel,
> +subdir limit is not availiable for all filesystems (availiable for ext2, ext3,
> +minix, sysv and more). If the test runs on some other filesystems, like ramfs,
> +tmpfs, it will always fail.

This sounds a bit confusing. Maybe it will be better to say:

it will not even try to reach the limit and return 0 (or -1 if that ends
up the case).

>  This function uses 'mkdir(2)' to create directories in 'dir' until it gets
>  'EMLINK' or creates 65535 directories. If the limit is hit, the maximum number
> diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
> index 1b45f79..4a691bb 100644
> --- a/lib/tst_fs_link_count.c
> +++ b/lib/tst_fs_link_count.c
> @@ -24,9 +24,24 @@
>  #include "test.h"
>  #include "usctest.h"
>  #include "safe_macros.h"
> +#include "tst_fs_type.h"
>  
>  #define MAX_SANE_HARD_LINKS	65535
>  
> +/*
> + * filesystems whose subdir limit is less than MAX_SANE_HARD_LINKS
> + * XXX: we cannot filter ext4 out, because ext2/ext3/ext4 have the
> + * same magic number
> + */
> +const long subdir_limit_whitelist[] = {
> +	TST_EXT2_OLD_MAGIC, TST_EXT2_MAGIC,    TST_EXT3_MAGIC,
> +	TST_MINIX_MAGIC,    TST_MINIX_MAGIC2, TST_MINIX2_MAGIC,
> +	TST_MINIX2_MAGIC2,  TST_MINIX3_MAGIC,  TST_UDF_MAGIC,
> +	TST_SYSV2_MAGIC,    TST_SYSV4_MAGIC,   TST_UFS_MAGIC,
> +	TST_UFS2_MAGIC,     TST_F2FS_MAGIC,    TST_NILFS_MAGIC,
> +	TST_EXOFS_MAGIC
> +};
> +
>  int tst_fs_fill_hardlinks(void (*cleanup) (void), const char *dir)
>  {
>  	unsigned int i, j;
> @@ -88,9 +103,10 @@ max_hardlinks_cleanup:
>  
>  int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir)
>  {
> -	unsigned int i, j;
> +	unsigned int i, j, whitelist_size;
>  	char dirname[PATH_MAX];
>  	struct stat s;
> +	long fs_type;
>  
>  	if (stat(dir, &s) == -1 && errno == ENOENT)
>  		SAFE_MKDIR(cleanup, dir, 0744);
> @@ -99,6 +115,20 @@ int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir)
>  	if (!S_ISDIR(s.st_mode))
>  		tst_brkm(TBROK, cleanup, "%s is not directory", dir);
>  
> +	/* for current kernel, subdir limit is not availiable for all fs */
> +	fs_type = tst_fs_type(cleanup, dir);
> +
> +	whitelist_size = ARRAY_SIZE(subdir_limit_whitelist);

So you still use whitelist, I would have liked blacklist more because
if, by any change, new filesystem with this limit will be added to
kernel the test will be working as well, but either one needs to be
update under certain conditions, so in the end either one is fine.

> +	for (i = 0; i < whitelist_size; i++) {
> +		if (fs_type == subdir_limit_whitelist[i])
> +			break;
> +	}
> +	if (i == whitelist_size) {
> +		tst_resm(TINFO, "subdir limit is not availiable for "
> +			 "filesystem %s", tst_fs_type_name(fs_type));
                         ^
                         %s filesystem.
> +		return -1;
> +	}
> +
>  	for (i = 0; i < MAX_SANE_HARD_LINKS; i++) {
>  		sprintf(dirname, "%s/testdir%d", dir, i);
>  
> @@ -134,7 +164,8 @@ int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir)
>  
>  	}
>  
> -	tst_resm(TINFO, "Failed reach the subdirs limit");
> +	tst_resm(TINFO, "Failed reach the subdirs limit on filesystem %s",
                                                           ^
							on %s filesystem.
> +		 tst_fs_type_name(fs_type));

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
