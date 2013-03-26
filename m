Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rameshyr@linux.vnet.ibm.com>) id 1UKYZf-0007ia-PI
	for ltp-list@lists.sourceforge.net; Tue, 26 Mar 2013 18:26:19 +0000
Received: from e23smtp02.au.ibm.com ([202.81.31.144])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UKYZd-0000nq-NG
	for ltp-list@lists.sourceforge.net; Tue, 26 Mar 2013 18:26:19 +0000
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <rameshyr@linux.vnet.ibm.com>;
	Wed, 27 Mar 2013 03:48:49 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id E55362BB0023
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Mar 2013 04:55:49 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	r2QHgm3O15466552
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Mar 2013 04:42:49 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	r2QHtnNw022667
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Mar 2013 04:55:49 +1100
Received: from oc8714216728.ibm.com ([9.77.195.205])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	r2QHtl7v022656
	for <ltp-list@lists.sourceforge.net>; Wed, 27 Mar 2013 04:55:48 +1100
Message-ID: <5151E122.3090203@linux.vnet.ibm.com>
Date: Tue, 26 Mar 2013 23:25:46 +0530
From: Ramesh <rameshyr@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] syscalls/mount0* and inotify03 tests are getting skipped from
	runltp
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

I tried to run syscalls test with ./runltp -f syscalls, it's found that 
the below tests
are getting skipped from the run,
-----------
inotify03 inotify03 -D DEVICE -T DEVICE_FS_TYPE
mount01 mount01 -D DEVICE -T DEVICE_FS_TYPE
mount02 mount02 -D DEVICE -T DEVICE_FS_TYPE
mount03 mount03 -D DEVICE -T DEVICE_FS_TYPE
mount04 mount04 -D DEVICE -T DEVICE_FS_TYPE
umount01 umount01 -D DEVICE -T DEVICE_FS_TYPE
umount02 umount02 -D DEVICE -T DEVICE_FS_TYPE
umount03 umount03 -D DEVICE -T DEVICE_FS_TYPE
-----------

I didn't get the value of DEVICE & DEVICE_FS_TYPE in any of conf files 
and also, as
the tests expect a block device, I executed the tests by specifying a 
block device
(-D /dev/sda1 -T ext4), tests passed.

Also,as the DEVICE & DEVICE_FS_TYPE need to be explicitly specifed to 
all the tests,
these tests should be commented out in ltp/runtest/syscalls which is 
used by runltp.

Any comments on this issue are appreciated.

Also, let me know is there a way by which we can make these tests to run 
from runltp
in an automated environment.


Regards,
Ramesh YR






------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
