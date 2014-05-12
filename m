Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WjsFw-0003jX-1h
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 15:35:08 +0000
Date: Mon, 12 May 2014 17:34:05 +0200
From: chrubis@suse.cz
Message-ID: <20140512153405.GA6837@rei>
References: <1399906092-28901-1-git-send-email-mats.liljegren@enea.com>
	<1399906092-28901-2-git-send-email-mats.liljegren@enea.com>
	<20140512150329.GG4741@rei> <20140512171433.0ce9f681@mats-desktop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140512171433.0ce9f681@mats-desktop>
Subject: Re: [LTP] [PATCH 1/2] SAFE_POPEN: Added function to safe_stdio.h
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > I've added missing return stream; here and pushed both patches,
> > thanks.
> 
> Whoa, did I really miss that? Wondering how my test could have
> run... Must have used the wrong version of the code when testing or
> something.

I've seen cases where such code was running fine because the register
used to return function value was the same that was allocated for the
temporary variable...

> But thanks for the merge!
> 
> Now you know why I really liked forcing people into using
> -Werror ;-) Could it be a good idea to actually use -Werror by default,
> and having a "production" flag for those who don't want it? Just to
> ensure that lazy people are those being best looked after...

I would be for reversing the logic, i.e. adding developer flag that
enables -Werror. Unfortunatelly LTP has tons of legacy code that
produces megatons of warnings and fixing all of these would be a big
effort.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
