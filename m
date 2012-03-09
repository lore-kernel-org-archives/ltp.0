Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S600E-0001NS-2v
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 13:37:02 +0000
Date: Fri, 9 Mar 2012 14:38:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120309133848.GA3751@saboteur.suse.cz>
References: <4F584AF1.3010909@windriver.com>
	<20120308115410.GC31640@saboteur.suse.cz>
	<4F5969C9.2020508@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F5969C9.2020508@windriver.com>
Subject: Re: [LTP] aio_read/8-1.c fails
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >The testcase passes here. However looking at the sources it tries to
> >read zero bytes to NULL buffer, which is wrong as the behavior in such
> >case is undefied by POSIX. I guess this is just another case where the
> >testcase was coded with "It works so it must be right" attitude.
> >
> >And out of curiosity, which libc library makes the testcase fail?
> Yes, aio_read() return 0, and the case fails.
> 
> In posix spec Line 19887:
> RETURN VALUE
> The aio_read( ) function shall return the value zero if the I/O
> operation is successfully queued;
> otherwise, the function shall return the value ???1 and set errno to
> indicate the error.
> 
> So when the I/O operation enqueued, aio_read() return 0, then that
> the I/O operation will be processing.
> I still doubt the case is invalid.

Well, the POSIX explicitly says that if the pointer to the buffer
becames illegal prior the I/O completion the behavior is undefined. So
strictly speaking when you pass NULL buffer to aio_read() the behavior
is undefined to begin with. At least that is how I understand the
standard.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
