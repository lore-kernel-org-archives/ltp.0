Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PcZ6j-0006CS-AH
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 07:57:33 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PcZ6i-0007ed-6s
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 07:57:33 +0000
Date: Tue, 11 Jan 2011 02:57:25 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <397246889.42502.1294732645124.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <AANLkTinzRFkEX7Hf-seH+P_WbTudvG=-c02YWBBYybxY@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] hugemmap05 issues
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>


> It's a little better now that it's using a temporary directory, but it
> still fails when I call it like:
> 
> ./hugemmap05
> 
> on Fedora 13/i386 (first the mmap fails, then the test tries to do a
> bunch of stuff in cleanup, including unmount the hugemmap filesystem
> -- which fails with EBUSY -- and remove the temporary directory --
> which fails because the mountpoint isn't unmounted -- and fails).
OK, the most important thing is to figure out why mmap() failed in the
first place. What did it return via strace?

It is hard to ensure the cleanup properly in those situation since it is
un-predictable what went wrong. The cleanup routine just do its best to
cleaning up the system. There was no grantee it would be succeed.

Thanks.

CAI Qian 

------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
