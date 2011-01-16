Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PePPz-0000qY-FW
	for ltp-list@lists.sourceforge.net; Sun, 16 Jan 2011 10:01:03 +0000
Date: Sun, 16 Jan 2011 11:17:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110116101753.GA7172@saboteur.suse.cz>
References: <4D310A5D.6000006@cn.fujitsu.com>
	<AANLkTin8PLaWHyqu1jQETZXNWWVFizf=SqUj23=mBC5u@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTin8PLaWHyqu1jQETZXNWWVFizf=SqUj23=mBC5u@mail.gmail.com>
Subject: Re: [LTP] [POSIX][PATCH] Fix bug of the test timer_create.
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> > CLOCK_THREAD_CPUTIME_ID and CLOCK_PROCESS_CPUTIME_ID are CPU-time clock,
> > so when the thread/process invokes nanosleep, these clocks will go sleeping
> > too.

I've send a sligtly better version of this patch a couple of weeks ago
and that was one of the patches I've been constantly reminding you
about.

I'm a little worried here that mixing time() that returns time since the
epoch and per process cpu timers wouldn't work on machine under load.

My patch uses only per cpu process timers so should be fine.

Could you please have a look at my version?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
