Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YGp8w-0003en-5u
	for ltp-list@lists.sourceforge.net; Thu, 29 Jan 2015 13:28:22 +0000
Date: Thu, 29 Jan 2015 14:28:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150129132812.GA15143@rei.suse.de>
References: <1422519368-202938-1-git-send-email-shengyong1@huawei.com>
	<1422519368-202938-2-git-send-email-shengyong1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422519368-202938-2-git-send-email-shengyong1@huawei.com>
Subject: Re: [LTP] [PATCH v4 1/2] lib: tst_fs_type: add new filesystem types
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

Hi!
> diff --git a/include/tst_fs_type.h b/include/tst_fs_type.h
> index fef0818..ec230c7 100644
> --- a/include/tst_fs_type.h
> +++ b/include/tst_fs_type.h
> @@ -33,6 +33,22 @@
>  #define TST_TMPFS_MAGIC    0x01021994
>  #define TST_V9FS_MAGIC     0x01021997
>  #define TST_XFS_MAGIC      0x58465342
> +#define TST_EXT2_OLD_MAGIC 0xEF51
> +/* ext2, ext3, ext4 have the same magic number */
> +#define TST_EXT234_MAGIC   0xEF53
> +#define TST_MINIX_MAGIC    0x137F
> +#define TST_MINIX_MAGIC2   0x138F
> +#define TST_MINIX2_MAGIC   0x2468
> +#define TST_MINIX2_MAGIC2  0x2478
> +#define TST_MINIX3_MAGIC   0x4D5A
> +#define TST_UDF_MAGIC      0x15013346
> +#define TST_SYSV2_MAGIC    0x012FF7B6
> +#define TST_SYSV4_MAGIC    0x012FF7B5
> +#define TST_UFS_MAGIC      0x00011954
> +#define TST_UFS2_MAGIC     0x19540119
> +#define TST_F2FS_MAGIC     0xF2F52010
> +#define TST_NILFS_MAGIC    0x3434
> +#define TST_EXOFS_MAGIC    0x5DF5

This hunk fails to apply to latest LTP git.

Looking at the differencies the TST_TMPFS_MAGIC,
TST_V9FS_MAGIC, TST_XFS_MAGIC have more spaces
before the hex number.

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
