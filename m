Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4rGS-0005Ac-W5
	for ltp-list@lists.sourceforge.net; Thu, 01 Aug 2013 11:41:53 +0000
Date: Thu, 1 Aug 2013 13:41:44 +0200
From: chrubis@suse.cz
Message-ID: <20130801114144.GA1192@rei.scz.novell.com>
References: <51E6272B.3020509@cn.fujitsu.com> <20130717120522.GB25145@rei>
	<51FA290E.1040804@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51FA290E.1040804@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] Add support for xfs quota tests
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> > Now this is getting a bit out of hand.
> > 
> > What about we change the tests (we have) to take only device to work
> > with and let each test prepare the filesystem it needs? This will
> > simplify the runltp script to only prepare loop device.
> > 
> > If we agree on that I can write the tst_mkfs() function and convert
> > current usages.
> 
> What about the progress of this work? :)

I've been on vacation. I will get to this next week.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
