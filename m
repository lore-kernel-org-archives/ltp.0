Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MB4zV-0004MJ-Uy
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2009 10:43:41 +0000
Date: Mon, 1 Jun 2009 12:43:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090601104334.GA31444@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [LTP] [Ltp-cvs] Reverting ltp-pan.c to pan.c revision1.32
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi,
> I had to revert this version of ltp-pan.c to an earlier pan.c revision
> 1.32 as the present ltp-pan.c was creating problems in lot of my
> architecture(s). It simply hangs and does not move forward. I had to do
> this immediate revert for the release. Please rebase your fixes (if any)
> against the present checked in code.

That's too bad, all I was changing was conding style but in the pan source who
knows :(. Why not just to rename pan.c to ltp-pan.c as I was trying to do
before the patch checker quarrels about coding style. I fully agree that
cleaning code is must but only option I see here is rewrite pan from scratch
and that is just too much work.

(forgotten to CC ltp, so sending once more)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
