Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwuyQ-00021u-DX
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 14:02:26 +0000
Date: Wed, 10 Jul 2013 16:04:05 +0200
From: chrubis@suse.cz
Message-ID: <20130710140405.GE19178@rei.suse.cz>
References: <mailman.80890.1372765469.12996.ltp-list@lists.sourceforge.net>
	<51D38924.8090400@oracle.com>
	<CA+icZUW=dX6NLpAWRA8neeJDZ7XP1bNhui-CtLLySP+Mfy6XMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+icZUW=dX6NLpAWRA8neeJDZ7XP1bNhui-CtLLySP+Mfy6XMQ@mail.gmail.com>
Subject: Re: [LTP] [ltp-full-20130503] runltp cleanup() can't remove ${TMP}
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
To: Sedat Dilek <sedat.dilek@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Eko <hong.sun@oracle.com>

Hi!
> Anyway, runltp needs some more love.

I keep saying that runltp needs rewrite because both ltp-pan and runltp
script are beyond the point of repair and I keep them only in
maintenance state.

Now I do plan to start working on replacement and I've posted RFC with
some notes on desing to this list about four months ago [1], I haven't
started to sketch the code yet but I hope to start working on this soon
enough.

[1] http://sourceforge.net/mailarchive/message.php?msg_id=30508383

Meanwhile some other posible functionality emerged. I would like to have
better anotated the runtest files adding not only timeouts but also
groups to ease runnings only tests for some kind of functionality.

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
