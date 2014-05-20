Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wmj6F-0002TS-3q
	for ltp-list@lists.sourceforge.net; Tue, 20 May 2014 12:24:55 +0000
Date: Tue, 20 May 2014 14:24:42 +0200
From: chrubis@suse.cz
Message-ID: <20140520122442.GB28216@rei.suse.cz>
References: <1397561602-18935-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1397561602-18935-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140519162944.GB29937@rei> <537B4259.2010200@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <537B4259.2010200@cn.fujitsu.com>
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
> Yeah, it's expected behavior for ext4.
> Please this this url: https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Storage_Administration_Guide/installconfig-fs.html
> 
> Note: here the discussion is for directory.
> 
> I checked the ext4 kernel source code in RHEL7.0RC:
> 
> static void ext4_inc_count(handle_t *handle, struct inode *inode)
> {
>          inc_nlink(inode);
>          if (is_dx(inode) && inode->i_nlink > 1) {
>                  if (inode->i_nlink >= EXT4_LINK_MAX || inode->i_nlink == 2) {
>                          set_nlink(inode, 1);
>                          EXT4_SET_RO_COMPAT_FEATURE(inode->i_sb,
>                                                EXT4_FEATURE_RO_COMPAT_DIR_NLINK);
>                  }
>          }
> }
> 
> Here EXT4_LINK_MAX is 65000. From the above code, we can
> see that if "is_dx(inode)" returns true and i_nlink count is greater than 65000.
> i_nlink will be reset to 1. Then if you stat parent directory, you will see its link_count is 1.
> 
> When we try to rmdir a directory, I also checked the ext4 kernel source code.
> If a directory had nlink == 1, then the ext4 will still let it be 1.
> 
> You can observe this by following steps:
> [root@localhost ~]# mkdir ext4_test/
> [root@localhost ~]# cd ext4_test/; for((i=0; i <=65000;i++)) do mkdir $i; done;
> [root@localhost ext4_test]# stat .
>   File: '.'
>   Size: 1392640         Blocks: 2728       IO Block: 4096   directory
> Device: 801h/2049d      Inode: 3678747     Links: 1
> Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Access: 2014-05-20 19:36:24.541944536 +0800
> Modify: 2014-05-20 19:35:59.724942953 +0800
> Change: 2014-05-20 19:35:59.724942953 +0800
>  Birth: -
> 
> Now the links is 1.
> If you delete some directory, the links will still be 1.
> 
> So if we want to have a 65000 limit, we should  "mkfs.ext4 -O ^dir_index device", thanks.

Ok, thanks for the detailed explanation.

> >> But EMLINK error value test need the directory have a valid LINK_MAX,
> >> so for ext4, we use mkfs to clear "dir_index" filesystem feature, then
> >> ext4 has a LINK_MAX:65000: mkfs.ext4 -O ^dir_index device
> > So this is the same problem as with XFS.
> >
> > I still think that correct solution to this problem is to write a
> > function that detects if there is a limit on number of links given a
> > filesystem path. Then we can simply skip the EMLINK test if the number
> > of links is unlimited.
> 
> Agree, thanks.
> For xfs, the number of links is unlimited.
> For ext2/3, the number of links is 32000.
> For ext4, it depends some options.
> 
> So for xfs, I will skip EMLINK test for it.
> For other files ystems, I will try to create as many as files, until the EMLINK Is hit.
> if EMLINK is not hit, there must be some other errors, such as ENOSPC, for this
> case,  the EMLINK test should also be skipped.

What about we create tst_get_max_links(const char *path) library
function that would either return the actual limit or -1 if unlimited?

Because this would be needed in more than one testcase, at least in the
link() and linkat() ones.

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
