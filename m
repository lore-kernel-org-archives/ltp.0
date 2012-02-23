Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S0b1d-0004Fu-UZ
	for ltp-list@lists.sourceforge.net; Thu, 23 Feb 2012 15:56:09 +0000
Date: Thu, 23 Feb 2012 16:56:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120223155639.GB5960@saboteur.suse.cz>
References: <1329991018-26230-1-git-send-email-markos.chandras@imgtec.com>
	<20120223153803.GC20855@saboteur.suse.cz>
	<4F465F43.8010503@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F465F43.8010503@imgtec.com>
Subject: Re: [LTP] [PATCH] creat07: Drop basename() function call from
 read-only variable
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Well in glibc you get version that is not reentrant but doesn't modify
> > the source string when _GNU_SOURCE is defined (which is defined in
> > creat07.c), so this may be bug in uClibc compatibility.
> > 
> > And I think that there is no reason to segfault when the argument
> > doesn't need to be modified, which should be the case here. Or did the
> > segfault occured in your enviroment?
> 
> 
> It segfaults if it modifies the argument because the argument is
> read-only. I don't remember when this function modifies the argument but
> it certainly is a bit dangerous to use a read-only variable when this
> function has known "weird" behaviour

Okay, commited.

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
