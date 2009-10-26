Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <adilger@sun.com>) id 1N2XtH-0005Rv-VV
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 22:18:15 +0000
Received: from sca-es-mail-2.sun.com ([192.18.43.133])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.69) id 1N2XtD-00031A-NB
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 22:18:15 +0000
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id
	n9QMFZam011469 for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Oct 2009 15:15:35 -0700 (PDT)
MIME-version: 1.0
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
	(Sun Java(tm) System Messaging Server 7u2-7.04 64bit (built Jul 2
	2009)) id <0KS500B00715ZK00@fe-sfbay-10.sun.com> for
	ltp-list@lists.sourceforge.net; 
	Mon, 26 Oct 2009 15:15:35 -0700 (PDT)
Date: Mon, 26 Oct 2009 16:15:32 -0600
From: Andreas Dilger <adilger@sun.com>
In-reply-to: <1256563577.4929.35.camel@subratamodak.linux.ibm.com>
Message-id: <C3A9583B-F6C5-4BCC-8D7E-876FA4D62D57@sun.com>
References: <4AE54BCA.7060104@cn.fujitsu.com>
	<1256563577.4929.35.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Add new testcases for ext4 new features - V3
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
To: subrata@linux.vnet.ibm.com
Cc: LTP-ML <ltp-list@lists.sourceforge.net>, Bhaskar Rangaswamy <bharanga@in.ibm.com>, "Iranna D. Ankad" <iranna.ankad@in.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Miao Xie <miaox@cn.fujitsu.com>, Pradeep kumar Surisetty <pradeepkumars@in.ibm.com>, linux-ext4 <linux-ext4@vger.kernel.org>, Santwana Samantray <santwana.samantray@in.ibm.com>

On 2009-10-26, at 07:26, Subrata Modak wrote:
> We had recently added EXT4 testcases to LTP. As the author of these
> tests mentioned, we saw 2 such failures in subdirectory limit test:
>
> Ext4 subdir limit test
> ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir  
> name
> len: short name                        Parent dir: mnt_point, Block
> size: 1024
> mke2fs 1.41.9 (22-Aug-2009)
> tune2fs 1.41.9 (22-Aug-2009)
> Setting test filesystem flag
> /dev/VG1_EXT4/LV1_EXT4: The test_fs flag is set (and ext4 is  
> available).
> CLEARED.

You don't need to set the test_fs flag for modern ext4.

> /dev/VG1_EXT4/LV1_EXT4: clean, 10/8847360 files, 2297019/141557760
> blocks
> dumpe2fs 1.41.9 (22-Aug-2009)
> ext4-subdir-limit    1  TPASS  :  ext4 subdir limit test pass
> ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir  
> name
> len: long name                         Parent dir: mnt_point, Block
> size: 1024
> mkdir: No space left on device
> ext4-subdir-limit    2  TFAIL  :  failed to create directories - 19524
> ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir  
> name
> len: short name                        Parent dir: mnt_point/sub,  
> Block
> size: 1024
> mke2fs 1.41.9 (22-Aug-2009)
> tune2fs 1.41.9 (22-Aug-2009)
> Setting test filesystem flag
> /dev/VG1_EXT4/LV1_EXT4: The test_fs flag is set (and ext4 is  
> available).
> CLEARED.
> /dev/VG1_EXT4/LV1_EXT4: clean, 12/8847360 files, 2297037/141557760
> blocks
> dumpe2fs 1.41.9 (22-Aug-2009)
> ext4-subdir-limit    3  TPASS  :  ext4 subdir limit test pass
> ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir  
> name
> len: long name                         Parent dir: mnt_point/sub,  
> Block
> size: 1024
> mkdir: No space left on device
> ext4-subdir-limit    4  TFAIL  :  failed to create directories - 19483
> ext4-subdir-limit    0  TINFO  :  Num of dirs to create: 65537, Dir  
> name
> len: short name                        Parent dir: mnt_point, Block
> size: 2048
>
> Is this a known issue for EXT4 ?

Creating many long filenames (255 bytes) in a 1kB block filesystem is a
known issue that is not expected to be fixed (at least I'm not aware of
any work being done in this area).  A vast majority of filesystems
today are formatted with 4kB blocks (due to disk size) and the  
overhead of
managing 1kB block filesystems makes these only marginally used, and it
is also very rare to have applications with such large filenames.

> We also uncovered that the tests gives a decent 50% lines and over 61%
> function coverage for EXT4 code. Please find the individual coverage
> under EXT4 attached.

Interesting to see this.

> Following the various system information on which we ran the test:
> 1) uname -a
> Linux 2.6.31 #1 SMP Tue Oct 20 22:57:16 IST 2009 i686 i686 i386
> GNU/Linux
>
> 2) grep -i ext4 .config
> CONFIG_EXT4_FS=m
> CONFIG_EXT4DEV_COMPAT=y
> CONFIG_EXT4_FS_XATTR=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
>
> 3) mkfs.ext4 -V
> mke2fs 1.41.9 (22-Aug-2009)
>        Using EXT2FS Library version 1.41.9
> e2fsprogs-1.41.9
> e2fsprogs-libs-1.41.9
>
> 4) LTP used:
> Unreleased CVS repository. See the URL below to download:
> http://ltp.sourceforge.net/documentation/how-to/ltp.php#_3.1,
>
> You can also also directly review the attached patch(which added this
> test cases):
> 26_10_2009-(Miao-Xie<miaox@cn.fujitsu.com>)- 
> Add_new_testcases_for_ext4_new_features_V3.patch.regenerated,
>
> 5) I used a single 680GB LVM partition to test this.
>
> Kindly let us know your thoughts on this failures.

Cheers, Andreas
--
Andreas Dilger
Sr. Staff Engineer, Lustre Group
Sun Microsystems of Canada, Inc.


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
