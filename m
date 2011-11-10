Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huruomu@gmail.com>) id 1ROXxV-0002eT-Ax
	for ltp-list@lists.sourceforge.net; Thu, 10 Nov 2011 16:58:37 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1ROXxU-0006An-KI
	for ltp-list@lists.sourceforge.net; Thu, 10 Nov 2011 16:58:37 +0000
Received: by qabj40 with SMTP id j40so3039019qab.13
	for <ltp-list@lists.sourceforge.net>;
	Thu, 10 Nov 2011 08:58:31 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 11 Nov 2011 00:58:31 +0800
Message-ID: <CANoG8sW+PEbwqCvQt7i=VENnySb1JXEdBrgMmKEJqyAcROQS_A@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: [LTP] nfsv3 filesystem: tst_rmdir: rmobj failed;
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
To: ltp-list@lists.sourceforge.net

Hi,

Many testcases fail on nfs v3 filesystem, the testcases per se
actually passed, but rmobj failed, and testcases return failure.  e.g.

dup03       1  TPASS  :  dup failed as expected with EMFILE
dup03       0  TWARN  :  tst_rmdir:
rmobj(/mnt/nfsv3/ltp-o9A6KJNkUl/dupI97bw6) failed:
unlink(/mnt/nfsv3/ltp-o9A6KJNkUl/dupI97bw6/.nfs0000000000c4409f0000000c)
failed; errno=16: Device or resource busy

dup205      1  TPASS  :  Test passed.
dup205      0  TWARN  :  tst_rmdir: rmobj failed; errno=16: Device or
resource busy

fcntl16     0  TINFO  :  Entering block 1
fcntl16     0  TINFO  :  Test case 1: without manadatory locking PASSED
fcntl16     0  TINFO  :  Exiting block 1
fcntl16     0  TINFO  :  Entering block 2
fcntl16     1  TFAIL  :  First parent lock failed
fcntl16     2  TFAIL  :  Test case 1, errno = 37
fcntl16     0  TINFO  :  Test case 2: with mandatory record locking FAILED
fcntl16     0  TINFO  :  Exiting block 2
fcntl16     0  TINFO  :  Entering block 3
fcntl16     3  TFAIL  :  First parent lock failed
fcntl16     4  TFAIL  :  Test case 1, errno = 37
fcntl16     0  TINFO  :  Test case 3: mandatory locking with NODELAY FAILED
fcntl16     0  TINFO  :  Exiting block 3
fcntl16     0  TWARN  :  tst_rmdir:
rmobj(/mnt/nfsv3/ltp-owwgcrfI7A/fcnWRtID0) failed:
unlink(/mnt/nfsv3/ltp-owwgcrfI7A/fcnWRtID0/.nfs00000000016ec3ff00000011)
failed; errno=16: Device or resource busy

Can this problem be safely ignored?  How to fix it?

Thanks
Romu

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
