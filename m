Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1EFZ-0002qe-6E
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 11:58:13 +0000
Date: Thu, 9 Jan 2014 12:57:53 +0100
From: chrubis@suse.cz
Message-ID: <20140109115753.GD5125@rei.Home>
References: <1386937862-12687-1-git-send-email-markos.chandras@imgtec.com>
	<201401051730.25397.vapier@gentoo.org> <20140108133024.GA1340@rei>
	<201401081644.28915.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201401081644.28915.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] utils: sctp: Fix build for prefixed
 architectures
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
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

Hi!
> if it's in upstream, then i don't see a problem merging it into ltp.  it isn't 
> 100% correct, but it still seems better than the status quo.

And seems like you were right, I've tried the patch and the build fails
for me on x86_64.

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
