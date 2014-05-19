Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WmQRn-0005oM-TU
	for ltp-list@lists.sourceforge.net; Mon, 19 May 2014 16:29:55 +0000
Date: Mon, 19 May 2014 18:29:44 +0200
From: chrubis@suse.cz
Message-ID: <20140519162944.GB29937@rei>
References: <1397561602-18935-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1397561602-18935-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397561602-18935-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] syscalls/rename/rename11.c: add ELOOP,
 EMLINK and EROFS error value tests
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Note: int rename(const char *old, const char *new);
> For EMLINK error value test: the file named by old is a directory and the
> link count of the parent directory of new would exceed {LINK_MAX}.
> 
> This test will work on ext2 and ext3 filesystem. But there is some difference in some
> linux distributions.
> 
> For example, in fedora19 and RHEL7.0Beta, the kernel configs for ext2/ext3/ext4 filesystems
> list below:
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=m
> CONFIG_EXT4_USE_FOR_EXT23=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> 
> If kernel has the above config, ext2 or ext3 is disabled. Then when we mount ext2 or
> ext3 filesystem, the ext4 filesystem driver code will be used for ext2 or ext3 file
> system mounts. This allows users to reduce their compiled kernel size by using one
> file system driver for ext2, ext3, and ext4 file systems. That means though we mount
> a block device with ext2 filesystem in it, the kernel will possibely use ext4 driver
> code instead.
> 
> So for this EMLINK error value test, we have test in ext4 directly. But the max
> subdirectories(per directory) in ext4 is unlimited default(When the link count exceeds
> 65,000, it is reset to 1 and no longer increases.).

Is this expected behavior? Because if the ref counting resets to 1 the
fs will break when somebody tries to delete the file. Or is just the
number reported to userspace wrong?

> But EMLINK error value test need the directory have a valid LINK_MAX,
> so for ext4, we use mkfs to clear "dir_index" filesystem feature, then
> ext4 has a LINK_MAX:65000: mkfs.ext4 -O ^dir_index device

So this is the same problem as with XFS.

I still think that correct solution to this problem is to write a
function that detects if there is a limit on number of links given a
filesystem path. Then we can simply skip the EMLINK test if the number
of links is unlimited.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
