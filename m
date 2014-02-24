Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WHvXp-0006VX-Lw
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 13:26:05 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id B62CCACA0
	for <ltp-list@lists.sourceforge.net>;
	Mon, 24 Feb 2014 13:25:57 +0000 (UTC)
Date: Mon, 24 Feb 2014 14:25:51 +0100
From: chrubis@suse.cz
Message-ID: <20140224132551.GB23796@rei>
References: <1393233450-22698-1-git-send-email-jack@suse.cz>
	<1393233450-22698-2-git-send-email-jack@suse.cz>
	<20140224121004.GB23596@rei> <20140224123723.GA26687@quack.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140224123723.GA26687@quack.suse.cz>
Subject: Re: [LTP] [PATCH 2/2] syscalls/fanotify: Test generation of
	overflow events
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
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > Test whether overflow event is properly generated when we don't read
> > > fanotify descriptor and generate enough events.
> > 
> > Missing runtest and .gitignore changes as well.
>   Fixed in v2.
> 
> > > +		for (i = 0; i < MAX_EVENTS + 1; i++) {
> > > +			sprintf(fname, "fname_%d", i);
> > > +			fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0644);
> > > +			SAFE_CLOSE(cleanup, fd);
> > 
> > SAFE_FILE_TOUCH(cleanup, fname, 0, NULL)
>   I was considering this but since I really want syscall to be open() I
> thought using SAFE_OPEN directly is more future-proof in case someone would
> like to do some tricks with SAFE_FILE_TOUCH(). And we won't really save
> much with using SAFE_FILE_TOUCH()...

Ah, this loop generates the events, so it's better to have it exactly
under control. Ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
