Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xjq4y-00019t-BT
	for ltp-list@lists.sourceforge.net; Thu, 30 Oct 2014 13:47:56 +0000
Date: Thu, 30 Oct 2014 14:47:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141030134723.GD14847@rei.suse.de>
References: <1413965532-19371-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1413965532-19371-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] acl_test01: sync after removal of the loop device
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

> If the test is executed on NFS, it may fail with:
> 
> /dev/loop0 on /tmpdir/tacl/mount-ext3 type ext3 (rw,acl,user_xattr)
> loop: can't delete device /dev/loop0: No such device or address
> rm: cannot remove `/tmpdir/tacl': Directory not empty
> loop: can't delete device /dev/loop0: No such device or address
> rm: cannot remove `/tmpdir/tacl/.nfs00000000000262fd00000115': Device or resource busy
> 
> I suppose that this happens because of kernel commit:
> 
> commit a1ecac3b0656a68259927c234e505804d33a7b83
> Author: Dave Chinner <dchinner@redhat.com>
> Date:   Fri Sep 28 10:42:23 2012 +0200
> 
>     loop: Make explicit loop device destruction lazy
> 
> To cope with this test case failure I introduced a 'sync'.
> And 'losetup -d' seems to be unnecessary, because of 'umount -d' before it

Hmm, so we umount and detach a filesystem but fail to delete it on NFS
because somebody else (presumbly udev) keeps the refcount there?

If that was the the problem the detach would have failed with EBUSSY
previously and the test would fail to delete the file anyway.

I do not fully understand why we need to do the sync there. The kernel
has changed not to report error on detach when somebody else keeps
working with the loop device and sets AUTOCLEAR flag that detaches the
loop device on last closed filedescriptor that references it. Does NFS
keep special file descriptor that prevents the loop device from being
detached?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
