Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z2GV0-0001T6-L0
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 10:11:14 +0000
Date: Tue, 9 Jun 2015 12:10:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150609101009.GE24041@rei.suse.de>
References: <1433843386-31431-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-2-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-3-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-4-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1433843386-31431-5-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433843386-31431-5-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [RFC PATCH 5/5] acl_test01: Wait until the loop device is
 detached
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> If the test is executed on NFS, it may print:
> 
> rm: cannot remove `/mnt/ltp-xeJYpESVKz/acltest01.fCogoo4gn0': Directory not empty
> 
> It seems the following happen:
> 
> 1. After 'unmount -d' 'acltest01.fCogoo4gn0/blkext3' is still in use by udev.
>    See kernel commit a1ecac3b0656a68259927c234e505804d33a7b83
>    ("loop: Make explicit loop device destruction lazy")
> 
> 2. Due to the "NFS silly rename" feature, command 'rm -f acltest01.fCogoo4gn0/blkext3'
>    renames 'blkext3' to '.nfs*'
> 
> 3. The removal of 'acltest01.fCogoo4gn0' directory fails, because it
>    still contains this '.nfs*' file.
> 
> Intorucing a wait cycle should fix this problem.

Hmm, we may want to add this into test.sh because otherwise we will need
to carry this snippet of code in each testcase that works with loop
devices.

Would calling umount without -d and detach_device() (from tst_device.c
via apicmd) help here? (it seems to fix the very same problem, it this
function does not work, it needs to be fixed anyway)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
