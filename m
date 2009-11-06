Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi@firstfloor.org>) id 1N6VEu-0006dG-4M
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 20:16:56 +0000
Received: from one.firstfloor.org ([213.235.205.2])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6VEh-0006jO-FM
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 20:16:50 +0000
From: Andi Kleen <andi@firstfloor.org>
References: <1257167821.4977.41.camel@subratamodak.linux.ibm.com>
Date: Fri, 06 Nov 2009 21:16:35 +0100
In-Reply-To: <1257167821.4977.41.camel@subratamodak.linux.ibm.com> (Subrata
	Modak's message of "Mon, 02 Nov 2009 18:47:01 +0530")
Message-ID: <87iqdn76jg.fsf@basil.nowhere.org>
MIME-Version: 1.0
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been Released for
	OCTOBER 2009
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>

Subrata Modak <subrata@linux.vnet.ibm.com> writes:
>
> ========================
> OCTOBER 2009 Highlights:

s/High/Low/

> ======================== 
>      1. LTP Makefiles rewrite:(Project started 1.2 years back) 
>              I. To accommodate correct build/installation practices, 
>             II. better integrate Autoconf/Automake with tests for safer
>                 builds, 
>            III. better cross-compilation of LTP sources. 

Just as a warning for everyone: that change broke building on most old
distributions and there seems to be no interest in fixing that.

Unless you're running the latest and greatest better stay with older LTP
versions.

-Andi


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
