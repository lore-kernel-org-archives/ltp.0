Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RanCT-0000TH-Fz
	for ltp-list@lists.sourceforge.net; Wed, 14 Dec 2011 11:40:41 +0000
Date: Wed, 14 Dec 2011 12:49:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111214114942.GA29250@saboteur.suse.cz>
References: <4EE1DC85.3060301@windriver.com>
	<20111209131504.GB6208@saboteur.suse.cz>
	<CAGH67wT1TwR89P+rQpo4gC7Qx0iRFkJbzxVA=PSu0QiC+uDE4g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGH67wT1TwR89P+rQpo4gC7Qx0iRFkJbzxVA=PSu0QiC+uDE4g@mail.gmail.com>
Subject: Re: [LTP] Question about priority of pthread rwlock on linux
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
Cc: ltp-list@lists.sourceforge.net, Kang Kai <Kai.Kang@windriver.com>

Hi!
> > These doesn't work with glibc either, see:
> >
> > http://old.nabble.com/pthread_rwlock_rdlock%28%29-p32423548.html
> >
> > I haven't got any reply though :(.
> >
> > The newer POSIX explicitly says that reader thread acquires the lock if
> > no writer is holding the lock and no writers are locked on the lock. And
> > it seems that previous standards specified the case of locked writing
> > threads as implementation defined...
> >
> > http://pubs.opengroup.org/onlinepubs/007904975/functions/pthread_rwlock_rdlock.html
> 
>     Once upon a time I intended to upgrade the POSIX compliance of the
> test suite to the 2008 spec -- so I blindly updated the POSIX
> compliance to 2008.1 (before it was set to 2001 compliance, IIRC..
> which wasn't particularly useful). I got busy with other tasks and
> since then my focus has been diverted from this and LTP (for the most
> part).
>     If it turns out that the testcase doesn't make sense given the new
> POSIX spec, or needs to be rewritten, I'll be more than happy to
> review either and provide feedback.

This rather seems to be one of the rare occasions where the testcase is
actually right and the glibc behaves to some very old SUS.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Cloud Computing - Latest Buzzword or a Glimpse of the Future?
This paper surveys cloud computing today: What are the benefits? 
Why are businesses embracing it? What are its payoffs and pitfalls?
http://www.accelacomm.com/jaw/sdnl/114/51425149/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
