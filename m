Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NBSzw-0005PJ-HA
	for ltp-list@lists.sourceforge.net; Fri, 20 Nov 2009 12:54:00 +0000
Received: from relay1.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 9BB8A90975
	for <ltp-list@lists.sourceforge.net>;
	Fri, 20 Nov 2009 13:53:47 +0100 (CET)
Date: Fri, 20 Nov 2009 13:53:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091120125347.GA4858@schrodinger.suse.cz>
References: <20091116151656.GB16811@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091116151656.GB16811@schrodinger.suse.cz>
Subject: Re: [LTP] [RFC] utstest.h
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
To: ltp-list@lists.sourceforge.net

Hi!
> I've been looking at sources for usctest.h again today (lib/parse_opts.c) and I
> still have the feeling that this is badly written/broken code and should be
> fixed but as there are thousands of tests that uses usctest interface we should
> be careful when touching these sources. So IMHO the best approach is to change
> one thing at the time and see if this was a good move.
> 
> So let's start with TEST_PAUSE macro. Accordingly to comment in the header,
> this expands to the code that waits for SIGUSR1 signal (and this is not
> generaly true).  This macro is expanded to the int usc_global_setup_hook()
> function. The function forks the program accordingly to STD_COPIES and
> accordingly STD_PAUSE it sleeps for a SIGUSR1 or not (all forked instances); it
> also changes program segment size with sbrk().
> 
> Looking into the test sources, this is called when the test starts in order to
> implement test parameters "-c n" (run n copies concurently) and "-p" (pause
> test) and system variable USC_TP_SBRK. Do we need these parameters or any of
> them? If you convice me that these parameters are usefull I would gladly clean
> up and document code that implements TEST_PAUSE, otherwise I would vote for
> removing them (or at least the useless ones).
> 

Okay, let me put it like this. Are parameters introduced by TEST_PAUSE really
used for anything? Would anybody cry if there where removed? Would be patch
removing them accepted and merged into CVS?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
