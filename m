Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N7YDw-00070x-BX
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:40:16 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7YDq-0005gO-9D
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 17:40:14 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id nA9DaH3L021561
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 08:36:17 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA9He3qj1470504
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 12:40:03 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA97busq019450
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Nov 2009 02:37:56 -0500
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AEF99CF.5080401@cn.fujitsu.com>
References: <4AE54BCA.7060104@cn.fujitsu.com>
	<1256563577.4929.35.camel@subratamodak.linux.ibm.com>
	<C3A9583B-F6C5-4BCC-8D7E-876FA4D62D57@sun.com>
	<1256650551.4957.33.camel@subratamodak.linux.ibm.com>
	<1256841114.5210.25.camel@subratamodak.linux.ibm.com>
	<4AEF99CF.5080401@cn.fujitsu.com>
Date: Mon, 09 Nov 2009 23:09:24 +0530
Message-Id: <1257788364.7677.71.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add new testcases for ext4 new features - V3
Reply-To: subrata@linux.vnet.ibm.com
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
To: Miao Xie <miaox@cn.fujitsu.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

On Tue, 2009-11-03 at 11:47 +0900, Miao Xie wrote: 
> Hi,Subrata
> 
> Sorry for the late reply.
> 
> I have no time to do the following job recently.
> But don't worry. I will do it before the next release.

Thank you very much Miao. I would like to tell you that many people in
my team are using your test cases rigorously. Thanks for the same.

Regards--
Subrata

> 
> >>> On 2009-10-26, at 07:26, Subrata Modak wrote:
> >>>> We had recently added EXT4 testcases to LTP. As the author of these
> >>>> tests mentioned, we saw 2 such failures in subdirectory limit test:
> >>>>
> >>>> Ext4 subdir limit test
> >>>> ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir  
> >>>> name
> >>>> len: short name                        Parent dir: mnt_point, Block
> >>>> size: 1024
> >>>> mke2fs 1.41.9 (22-Aug-2009)
> >>>> tune2fs 1.41.9 (22-Aug-2009)
> >>>> Setting test filesystem flag
> >>>> /dev/VG1_EXT4/LV1_EXT4: The test_fs flag is set (and ext4 is  
> >>>> available).
> >>>> CLEARED.
> >>> You don't need to set the test_fs flag for modern ext4.
> >> Miao,
> >>
> >> Can we change this ?
> 
> Ok, no problem.
> 
> >>>> ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir  
> >>>> name
> >>>> len: long name                         Parent dir: mnt_point, Block
> >>>> size: 1024
> >>>> mkdir: No space left on device
> >>>> ext4-subdir-limit    2  TFAIL  :  failed to create directories - 19524
> ...
> >>>> ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir  
> >>>> name
> >>>> len: long name                         Parent dir: mnt_point/sub,  
> >>>> Block
> >>>> size: 1024
> >>>> mkdir: No space left on device
> >>>> ext4-subdir-limit    4  TFAIL  :  failed to create directories - 19483
> ...
> >>>> Is this a known issue for EXT4 ?
> >>> Creating many long filenames (255 bytes) in a 1kB block filesystem is a
> >>> known issue that is not expected to be fixed (at least I'm not aware of
> >>> any work being done in this area).  A vast majority of filesystems
> >>> today are formatted with 4kB blocks (due to disk size) and the  
> >>> overhead of
> >>> managing 1kB block filesystems makes these only marginally used, and it
> >>> is also very rare to have applications with such large filenames.
> >> Ok.
> 
> I will remove these testcases.
> 
> >> However, it is also accompanied by the following failures in the online-defrag part:
> >> ========================================================================================
> >> ext4-online-defrag    0  TINFO  :  defrag type: 1, defrag obj: 3, block size: 1024
> >> 71301958656 bytes (71 GB) copied, 2694.12 s, 26.5 MB/s
> >> ext4-online-defrag    3  TFAIL  :  e4defrag returned failure
> ...
> >> ext4-online-defrag    0  TINFO  :  defrag type: 2, defrag obj: 3, block size: 1024
> >> 71301958656 bytes (71 GB) copied, 2623.31 s, 27.2 MB/s
> >> ext4-online-defrag    6  TFAIL  :  e4defrag returned failure
> >> ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 1, block size: 1024
> >> ext4-online-defrag    7  TFAIL  :  e4defrag returned failure
> >> ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 2, block size: 1024
> >> 41943040 bytes (42 MB) copied, 0.737014 s, 56.9 MB/s
> >> ext4-online-defrag    8  TFAIL  :  e4defrag returned failure
> >> ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 3, block size: 1024
> >> 71301958656 bytes (71 GB) copied, 2544.39 s, 28.0 MB/s
> >> ext4-online-defrag    9  TFAIL  :  e4defrag returned failure
> >> ...
> >> ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 2, block size: 4096
> >> 41943040 bytes (42 MB) copied, 0.306366 s, 137 MB/s
> >> ext4-online-defrag   17  TFAIL  :  e4defrag returned failure
> >> ext4-online-defrag    0  TINFO  :  defrag type: 3, defrag obj: 3, block size: 4096
> >> 71241666560 bytes (71 GB) copied, 1019.79 s, 69.9 MB/s
> >> ext4-online-defrag   18  TFAIL  :  e4defrag returned failure
> >> incrementing stop
> >> ========================================================================================
> >> Did you see these failure on your machine ?
> 
> I didn't find these failure on my box.
> I need more information to analyse. so I'll make a patch to get
> more information later.
> 
> >> Some more points are:
> >>
> >>      1. Can you please run these tests against the backdrop of the
> >>         Makefile changes in LTP to see all the build/install/run are
> >>         executing fine,
> > 
> > Could you please verify this before this release. Let me know a patch if
> > you find any discrepancy :-)
> 
> Sorry for that I couldn't do it before the release.
> I'll do it before the next release.
> 
> > 
> >> 2. Can you also please put all the utilities version info at the
> >>         beginning of the test rather than printing them again and
> >>         again(like mke2fs 1.41.9 (22-Aug-2009),tune2fs 1.41.9
> >>         (22-Aug-2009),dumpe2fs 1.41.9 (22-Aug-2009),dumpe2fs 1.41.9
> >>         (22-Aug-2009))
> > 
> > This can go in the next month release as well, if you do not have time
> > to fix now. Else, i have a bug mouth to eat this as well ;-)
> 
> I'll do it before the next release.
> 
> Regards.
> Miao
> 
> > 
> > Regards--
> > Subrata
> > 
> >> Regards--
> >> Subrata
> >>
> >>>> Following the various system information on which we ran the test:
> >>>> 1) uname -a
> >>>> Linux 2.6.31 #1 SMP Tue Oct 20 22:57:16 IST 2009 i686 i686 i386
> >>>> GNU/Linux
> >>>>
> >>>> 2) grep -i ext4 .config
> >>>> CONFIG_EXT4_FS=m
> >>>> CONFIG_EXT4DEV_COMPAT=y
> >>>> CONFIG_EXT4_FS_XATTR=y
> >>>> CONFIG_EXT4_FS_POSIX_ACL=y
> >>>> CONFIG_EXT4_FS_SECURITY=y
> >>>>
> >>>> 3) mkfs.ext4 -V
> >>>> mke2fs 1.41.9 (22-Aug-2009)
> >>>>        Using EXT2FS Library version 1.41.9
> >>>> e2fsprogs-1.41.9
> >>>> e2fsprogs-libs-1.41.9
> >>>>
> >>>> 4) LTP used:
> >>>> Unreleased CVS repository. See the URL below to download:
> >>>> http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.1,
> >>>>
> >>>> You can also also directly review the attached patch(which added this
> >>>> test cases):
> >>>> 26_10_2009-(Miao-Xie<miaox@cn.fujitsu.com>)- 
> >>>> Add_new_testcases_for_ext4_new_features_V3.patch.regenerated,
> >>>>
> >>>> 5) I used a single 680GB LVM partition to test this.
> >>>>
> >>>> Kindly let us know your thoughts on this failures.
> >>> Cheers, Andreas
> >>> --
> >>> Andreas Dilger
> >>> Sr. Staff Engineer, Lustre Group
> >>> Sun Microsystems of Canada, Inc.
> >>>
> >> ------------------------------------------------------------------------------
> >> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> >> is the only developer event you need to attend this year. Jumpstart your
> >> developing skills, take BlackBerry mobile applications to market and stay 
> >> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> >> http://p.sf.net/sfu/devconference
> >> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 
> > 
> > 
> > 
> 
> 


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
