Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZX5ys-0004ur-FT
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2015 11:13:30 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZX5yr-0004BS-91
	for ltp-list@lists.sourceforge.net; Wed, 02 Sep 2015 11:13:30 +0000
Date: Wed, 2 Sep 2015 13:12:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150902111246.GA1232@rei>
References: <20150829232628.GA14374@fifo99.com>
	<20150831102243.GA17387@rei.suse.cz>
	<20150831170112.GA18725@fifo99.com>
	<20150901154229.GB17536@rei.suse.cz>
	<20150901232815.GA21660@fifo99.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150901232815.GA21660@fifo99.com>
Subject: Re: [LTP] Test Anything Protocal output
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
To: dwalker@fifo99.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > Well, if your re-writing it, than TAP could be added after that. Is this re-write
> > > a long term thing, or something your planning to complete in the next couple months?
> > 
> > The tst_res.c is one of the last files under the lib/ that hasn't been
> > cleaned up yet and I certainly want to do that before next release,
> > which would be in aprox. three months.
> 
> Ok, I can wait for that. Are you planning on doing it in steps, or just one big update
> for the file ? I ask only to see if there's something I could look at prior to the final release.

Just now I'm still in the planning and designing phase. I will likely
want to discuss the changes before they get commited to LTP, either as
patches on ML or as separate git repo. We can wire up TAP output at that
point.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
