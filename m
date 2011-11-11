Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1ROsCW-0002tj-P3
	for ltp-list@lists.sourceforge.net; Fri, 11 Nov 2011 14:35:28 +0000
Date: Fri, 11 Nov 2011 15:41:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111111144139.GC13045@saboteur.suse.cz>
References: <CANoG8sW+PEbwqCvQt7i=VENnySb1JXEdBrgMmKEJqyAcROQS_A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANoG8sW+PEbwqCvQt7i=VENnySb1JXEdBrgMmKEJqyAcROQS_A@mail.gmail.com>
Subject: Re: [LTP] nfsv3 filesystem: tst_rmdir: rmobj failed;
 errno=16: Device or resource busy
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
To: Romu <huruomu@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Many testcases fail on nfs v3 filesystem, the testcases per se
> actually passed, but rmobj failed, and testcases return failure.  e.g.
> 
> dup03       1  TPASS  :  dup failed as expected with EMFILE
> dup03       0  TWARN  :  tst_rmdir:
> rmobj(/mnt/nfsv3/ltp-o9A6KJNkUl/dupI97bw6) failed:
> unlink(/mnt/nfsv3/ltp-o9A6KJNkUl/dupI97bw6/.nfs0000000000c4409f0000000c)
> failed; errno=16: Device or resource busy
> 
> dup205      1  TPASS  :  Test passed.
> dup205      0  TWARN  :  tst_rmdir: rmobj failed; errno=16: Device or
> resource busy
> 
> fcntl16     0  TINFO  :  Entering block 1
> fcntl16     0  TINFO  :  Test case 1: without manadatory locking PASSED
> fcntl16     0  TINFO  :  Exiting block 1
> fcntl16     0  TINFO  :  Entering block 2
> fcntl16     1  TFAIL  :  First parent lock failed
> fcntl16     2  TFAIL  :  Test case 1, errno = 37
> fcntl16     0  TINFO  :  Test case 2: with mandatory record locking FAILED
> fcntl16     0  TINFO  :  Exiting block 2
> fcntl16     0  TINFO  :  Entering block 3
> fcntl16     3  TFAIL  :  First parent lock failed
> fcntl16     4  TFAIL  :  Test case 1, errno = 37
> fcntl16     0  TINFO  :  Test case 3: mandatory locking with NODELAY FAILED
> fcntl16     0  TINFO  :  Exiting block 3
> fcntl16     0  TWARN  :  tst_rmdir:
> rmobj(/mnt/nfsv3/ltp-owwgcrfI7A/fcnWRtID0) failed:
> unlink(/mnt/nfsv3/ltp-owwgcrfI7A/fcnWRtID0/.nfs00000000016ec3ff00000011)
> failed; errno=16: Device or resource busy
> 
> Can this problem be safely ignored?  How to fix it?

The tst_rmdir failures are caused by how nfs handles unlinked but not
closed files, these are not serious bugs and could be fixed just by
closing the file descriptors before calling tst_rmdir() see patch for
dup3 that arrived today.

The fcntl test tests some file locks, I'm not sure if that is supported
by nfs. Maybe you need some special daemon for file locking (I vaguely
remember such problem) in any case google is your friend here.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
