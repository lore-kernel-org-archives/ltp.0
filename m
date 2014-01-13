Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W2med-0000W1-Fb
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 18:54:31 +0000
Date: Mon, 13 Jan 2014 19:54:06 +0100
From: chrubis@suse.cz
Message-ID: <20140113185405.GA2315@rei>
References: <1386937862-12687-1-git-send-email-markos.chandras@imgtec.com>
	<20140109115303.GC5125@rei.Home> <52CE9B15.4070307@imgtec.com>
	<52CFC57F.9000004@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52CFC57F.9000004@imgtec.com>
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I am also able to build the upstream code directly from their repository.
> 
> Could you please double check the patch you applied? :)

And indeed it was misapplied, for same strange reason the 'git am' dropped
last two lines of the patch. Which keeps me wonder how many patches has
been corrupted silently :(

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
