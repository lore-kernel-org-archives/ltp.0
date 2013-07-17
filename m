Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UzSCt-0002ZM-Kw
	for ltp-list@lists.sourceforge.net; Wed, 17 Jul 2013 13:55:51 +0000
Date: Wed, 17 Jul 2013 15:57:35 +0200
From: chrubis@suse.cz
Message-ID: <20130717135735.GA27308@rei>
References: <CADyrn+t16kR9FAfQSYUB2aYJej1BEFFZcLwUzDi0nKAjHyZ6Rw@mail.gmail.com>
	<20130716122924.GA21078@rei>
	<CADyrn+vPD7d4o4F4r7HayBJ-Q9iKL4HefbUxkcJVik8yb80o7w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADyrn+vPD7d4o4F4r7HayBJ-Q9iKL4HefbUxkcJVik8yb80o7w@mail.gmail.com>
Subject: Re: [LTP] [mtest01w] mtest01w test hangs
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
To: SHASHANK BILGI <shashank192@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I have one more query, when i run mtest01w on my target, it gives a message
> "stopped at 731906048 bytes: errno=ENOMEM(12): Cannot allocate memory".
> 
> Should this be considered as a test case failure, If not, why?

That is hard to say without further analysis.

Generally malloc() is allowed to return ENOMEM when machine memory was
used up.

But conditions under this happens depends on ulimits, memory overcommit
settings, size and availability of swap etc.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
