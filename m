Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDEFx-0003S8-0Z
	for ltp-list@lists.sourceforge.net; Tue, 11 Feb 2014 14:24:13 +0000
Date: Tue, 11 Feb 2014 15:23:36 +0100
From: chrubis@suse.cz
Message-ID: <20140211142336.GA14876@rei.Home>
References: <1387201147-3808-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140206132905.GA4105@rei.suse.cz> <52F9EE70.9040700@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52F9EE70.9040700@oracle.com>
Subject: Re: [LTP] [PATCH] msgctl11: process message queues by portions
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
> > Technically the idx should be named offset or off.
> >
> >> +	key_t key;
> >> +	int i, count, status;
> >> +	pid_t pid;
> >> +
> >> +	nprocs = no_of_processes;
> >
> > This is hacky, you should either pass the number as a function parameter
> > or in global variable but doing both is messy.
> >
> 
> Yes, it's.... But I need to keep nprocs global, because it's used in the 
> signal handler.

I know, there is a cleanup that depends on it.

> So I either can update nprocs before calling dotest_iteration() (right 
> in main()) or do this inside dotest_iteration().
> 
> I think that doing so inside dotest_iteration() is not an excellent 
> solution but it's compact and this choice should be pretty clear for 
> further maintenance.
> 
> What do you think?

I would prefer setting nprocs right before you call dotest_iteration(),
IMHO that way the code follows the rule of least surprise.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
