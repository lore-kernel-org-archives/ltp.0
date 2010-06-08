Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rpaulsen@us.ibm.com>) id 1OM3xB-0001Vh-Jk
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 18:55:13 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OM3xA-00057j-Lt
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 18:55:13 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o58Ifxvj021046
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jun 2010 14:41:59 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o58It6BK090276
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jun 2010 14:55:06 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o58Isur0006495
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jun 2010 15:54:57 -0300
Received: from d01ml072.pok.ibm.com (d01ml072.pok.ibm.com [9.63.10.37])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o58Isuu1006479
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Jun 2010 15:54:56 -0300
Message-ID: <OF936AB387.E41CF8FF-ON8525773C.0066D2F2-8625773C.0067E206@us.ibm.com>
From: Robert Paulsen <rpaulsen@us.ibm.com>
Date: Tue, 8 Jun 2010 13:54:54 -0500
MIME-Version: 1.0
Subject: [LTP] quotactl01 testcase failure (Apr 2010 LTP)
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
To: ltp-list@lists.sourceforge.net


Is the quotactl01 testcase supposed to be working?

I get the following failure (I reformatte the output slightly for clarity):

  # ./quotactl01
  quotactl01    1  TBROK  :  failed to enable quotas on block device: (null);
  1. Ensure that the device is mounted with the quota option.
  2. Check the filesystem status with `quotacheck (null)':
  errno=EFAULT(14): Bad address

Looking at the code and interpreting the error messages it seems that there is
a bunch of setup required to get this test to run. I tried the following. It
gets me a bit further into the code before failing but still does fail:

  # /etc/init.d/quotad start  # makes no difference if I do this or not
  # dd if=/dev/zero of=image bs=4096 count=128000
  # mkdir filesys
  # mke2fs -F image
  # mount -o loop,usrquota image filesys
  # quotacheck -cu filesys # creates filesys/aquota.user
  # ./quotactl01 -b /dev/loop0 -m $PWD/filesys -q aquota.user
  quotactl01    1  TBROK  :  failed to enable quotas on block device: /dev/loop0;
  1. Ensure that the device is mounted with the quota option.
  2. Check the filesystem status with `quotacheck /dev/loop0'
  errno=ESRCH(3): No such process

Checking status as suggested by above error output:

  # mount
  /dev/loop0 on /opt/fiv/ltp/testcases/kernel/syscalls/quotactl/filesys type ext2 (rw,usrquota)
  # quotacheck -v /dev/loop0
  quotacheck: Scanning /dev/loop0
  [/opt/fiv/ltp/testcases/kernel/syscalls/quotactl/filesys] done
  quotacheck: Checked 2 directories and 1 files
  # echo $?
  0

So it is mounted with usrquota and "quotacheck /dev/loop0" gives zero rc but the test still fails.

Is there more I should be doing?

Robert Paulsen
IBM Linux Technology Center, Austin
rpaulsen@us.ibm.com
512-468-0565


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
