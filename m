Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S5btQ-0006Ua-UL
	for ltp-list@lists.sourceforge.net; Thu, 08 Mar 2012 11:52:24 +0000
Date: Thu, 8 Mar 2012 12:54:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120308115410.GC31640@saboteur.suse.cz>
References: <4F584AF1.3010909@windriver.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F584AF1.3010909@windriver.com>
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
> aio_read/8-1.c "fills in an aiocb with a NULL aio_buf" and then expect 
> that the operation is not succesfully queued.
> It fails that aio_read() always return 0. And I checked the posix spec 
> and didn't find that an aiocb with NULL aio_buf will cause enqueue fails.
> So is this case valid?

The testcase passes here. However looking at the sources it tries to
read zero bytes to NULL buffer, which is wrong as the behavior in such
case is undefied by POSIX. I guess this is just another case where the
testcase was coded with "It works so it must be right" attitude.

And out of curiosity, which libc library makes the testcase fail?

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
