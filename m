Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NA3KM-0000Sx-7B
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 15:17:14 +0000
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	by mx2.suse.de (Postfix) with ESMTP id D3F8F8655F
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Nov 2009 16:16:56 +0100 (CET)
Date: Mon, 16 Nov 2009 16:16:56 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091116151656.GB16811@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [RFC] utstest.h
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
I've been looking at sources for usctest.h again today (lib/parse_opts.c) and I
still have the feeling that this is badly written/broken code and should be
fixed but as there are thousands of tests that uses usctest interface we should
be careful when touching these sources. So IMHO the best approach is to change
one thing at the time and see if this was a good move.

So let's start with TEST_PAUSE macro. Accordingly to comment in the header,
this expands to the code that waits for SIGUSR1 signal (and this is not
generaly true).  This macro is expanded to the int usc_global_setup_hook()
function. The function forks the program accordingly to STD_COPIES and
accordingly STD_PAUSE it sleeps for a SIGUSR1 or not (all forked instances); it
also changes program segment size with sbrk().

Looking into the test sources, this is called when the test starts in order to
implement test parameters "-c n" (run n copies concurently) and "-p" (pause
test) and system variable USC_TP_SBRK. Do we need these parameters or any of
them? If you convice me that these parameters are usefull I would gladly clean
up and document code that implements TEST_PAUSE, otherwise I would vote for
removing them (or at least the useless ones).

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
