Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WHvKc-0004eW-Nr
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 13:12:26 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C314BACB6
	for <ltp-list@lists.sourceforge.net>;
	Mon, 24 Feb 2014 13:12:19 +0000 (UTC)
Date: Mon, 24 Feb 2014 14:12:13 +0100
From: chrubis@suse.cz
Message-ID: <20140224131213.GA23796@rei>
References: <1393233450-22698-1-git-send-email-jack@suse.cz>
	<20140224121446.GC23596@rei> <20140224123955.GB26687@quack.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140224123955.GB26687@quack.suse.cz>
Subject: Re: [LTP] [PATCH 1/2] syscalls/inotify: Test generation of overflow
	events
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
> > > +	SAFE_READ(cleanup, 0, fd, buf, BUF_SIZE);
> > > +	if (sscanf(buf, "%d", &max_events) != 1) {
> > > +		tst_brkm(TBROK, cleanup,
> > > +			 "cannot parse max_queued_events file");
> > > +	}
> > > +	SAFE_CLOSE(cleanup, fd);
> > > +}
> > > +
> > > +static void cleanup(void)
> > > +{
> > > +	if (myinotify_rm_watch(fd_notify, wd) < 0) {
> > > +		tst_resm(TWARN | TERRNO, "inotify_rm_watch (%d, %d) failed",
> > > +			 fd_notify, wd);
> > > +
> > > +	}
> > > +
> > > +	if (close(fd_notify) == -1) {
> > > +		tst_resm(TWARN, "close(%d) failed", fd_notify);
> > > +	}
> > 
> > 
> > And I guess that we need to change this to:
> > 
> > 	if (fd_notify > 0 && close(fd_notify) == -1)
> > 
> > 
> > because the fd_notify may be set to -1 in case that the syscall above
> > failed with ENOSYS which would generate a bogus warning. And I guess
> > that the same goes for the removing the inotify watch.
>   Well, yes. I can make that less verbose in case of missing inotify
> support. I was just following what is done in other inotify tests...

The problem is that TWARN gets propagated into the overall test result
so the test will not endup with clean TCONF in this case.

And unfortunately quite a lot of test cleanups are coded incorrectly in
LTP. :(


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
