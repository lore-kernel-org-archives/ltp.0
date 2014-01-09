Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1EGD-0001S8-UZ
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 11:58:53 +0000
Date: Thu, 9 Jan 2014 12:58:34 +0100
From: chrubis@suse.cz
Message-ID: <20140109115834.GE5125@rei.Home>
References: <1385374379-25949-1-git-send-email-markos.chandras@imgtec.com>
	<201401051727.10564.vapier@gentoo.org> <20140108152259.GB1556@rei>
	<201401081442.11349.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201401081442.11349.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] ptrace: Fix build problems with glibc-2.18
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > Let's keep it for the next release (which will happen anytime soon). The
> > ptrace tests are messy and the ptrace.h needs to be fixed anyway.
> > 
> > Or do you insist on removing it before the release? I don't like that
> > idea much but I can change my opinion if you provide reasonable
> > arguments.
> 
> we can leave it for a while, but i'll delete it once glibc-2.19 is out for 
> some time

OK with me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
