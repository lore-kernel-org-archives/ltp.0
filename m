Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rq7Lc-0001N6-4Y
	for ltp-list@lists.sourceforge.net; Wed, 25 Jan 2012 18:13:28 +0000
Date: Wed, 25 Jan 2012 19:26:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120125182606.GA11236@saboteur.suse.cz>
References: <4F02E1B9.2090603@imgtec.com>
	<CAGH67wRnBFxdBgQos0Px8GscXQ+Sn30JNmM-z2KU7-v6Vc7d3A@mail.gmail.com>
	<4F043605.9050703@imgtec.com>
	<CAGH67wR_qD3pc_k7qdeyRWq60V6qr6A7yeT9Q4zcYTLrJ-WBkA@mail.gmail.com>
	<20120104144305.GE15845@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120104144305.GE15845@saboteur.suse.cz>
Subject: Re: [LTP] [PATCH 09/21] realtime/lib/Makefile: Fix path for
 config.mk
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
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

Hi!
> > >>> Hi, please review the attached patch
> > >>
> > >>
> > >> No -- this breaks out-of-tree compiles.
> > >> -Garrett
> > >
> > > But without this patch, the in-tree 'distclean' target is broken
> > 
> >     Hmmm... it worked once upon a time. I'll look at this when I have a chance.
> 
> It's broken since 21e14b79ce269f27be8ce49475dc49c5bc5838bd, reverting it
> fixed the build.

Ping. Any chance you will look at this, the out of tree build is broken
without that patch and the in tree with.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
