Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YBlcQ-0007DE-8X
	for ltp-list@lists.sourceforge.net; Thu, 15 Jan 2015 14:41:54 +0000
Date: Thu, 15 Jan 2015 15:41:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150115144100.GA9499@rei>
References: <1421331671-231350-1-git-send-email-shengyong1@huawei.com>
	<1421331671-231350-2-git-send-email-shengyong1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1421331671-231350-2-git-send-email-shengyong1@huawei.com>
Subject: Re: [LTP] [PATCH V2 1/3] lib/tst_fs_link_count.c: check fs type and
 do not fill subdir if no limit
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
Cc: yanegomi@gmail.com, ltp-list@lists.sourceforge.net

Hi!
> +/* filesystems whose subdir limit is less than MAX_SANE_HARD_LINKS */
> +const long fs_type_filter[] = {
> +	0xEF51,		/* EXT2_OLD_SUPER_MAGIC */
> +	0xEF53,		/* EXT2/3/4_SUPER_MAGIC, cannot filter ext4 out */
> +	0x137F,	0x138F,	/* MINIX_SUPER_MAGIC, MINIX_SUPER_MAGIC2 */
> +	0x2468,	0x2478,	/* MINIX2_SUPER_MAGIC, MINIX2_SUPER_MAGIC2 */
> +	0x4d5a,		/* MINIX3_SUPER_MAGIC */
> +	0x15013346,	/* UDF_SUPER_MAGIC */
> +	0x012FF7B6, 0x012FF7B5,	/* SYSV2_SUPER_MAGIC, SYSV4_SUPER_MAGIC */
> +	0x00011954, 0x19540119,	/* UFS_MAGIC, UFS2_MAGIC */
> +	0xF2F52010,	/* F2FS_SUPER_MAGIC */
> +	0x3434,		/* NILFS_SUPER_MAGIC */
> +	0x5DF5		/* EXOFS_SUPER_MAGIC */
> +};

We have most of these defined in include/tst_fs_type.h, make use of
them. And if there are any missing, add them (in a separate patch).

Also it may be better to add a blacklist rather than whitelist. I.e.
skip tmpfs, ramfs, etc.

>  int tst_fs_fill_hardlinks(void (*cleanup) (void), const char *dir)
>  {
>  	unsigned int i, j;
> @@ -88,9 +104,10 @@ max_hardlinks_cleanup:
>  
>  int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir)
>  {
> -	unsigned int i, j;
> +	unsigned int i, j, filter_size;
>  	char dirname[PATH_MAX];
>  	struct stat s;
> +	struct statfs fs;
>  
>  	if (stat(dir, &s) == -1 && errno == ENOENT)
>  		SAFE_MKDIR(cleanup, dir, 0744);
> @@ -99,6 +116,27 @@ int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir)
>  	if (!S_ISDIR(s.st_mode))
>  		tst_brkm(TBROK, cleanup, "%s is not directory", dir);
>  
> +	/*
> +	 * for current kernel, hardlink limit is not availiable for all
> +	 * filesystem. Only test if on ext2 and ext3.
> +	 */
> +	if (statfs(dir, &fs) < 0) {
> +		tst_resm(TINFO | TERRNO, "cannot detect filesystem type "
> +			 "for %s", dir);
> +		return 0;
> +	}
> +
> +	filter_size = (int) (sizeof(fs_type_filter) / sizeof(long));

Use ARRAY_SIZE();

> +	for (i = 0; i < filter_size; i++) {
> +		if (fs.f_type == fs_type_filter[i])
> +			break;
> +	}
> +	if (i == filter_size) {
> +		tst_resm(TINFO, "subdir limit is not availiable for "
> +			 "filesystem 0x%lx", (unsigned long) fs.f_type);
> +		return -1;
> +	}

Why overcomplicate the code, just return -1 from the if () inside the
loop. Also we have tst_fs_type_name().

>  	for (i = 0; i < MAX_SANE_HARD_LINKS; i++) {
>  		sprintf(dirname, "%s/testdir%d", dir, i);
>  
> @@ -134,7 +172,8 @@ int tst_fs_fill_subdirs(void (*cleanup) (void), const char *dir)
>  
>  	}
>  
> -	tst_resm(TINFO, "Failed reach the subdirs limit");
> +	tst_resm(TINFO, "Failed reach the subdirs limit on filesystem 0x%lx",
> +		 fs.f_type);

Again tst_fs_type_name();

>  max_subdirs_cleanup:
>  	for (j = 0; j < i; j++) {
> -- 
> 1.8.3.4
> 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
