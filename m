Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PIeVK-0006E7-LP
	for ltp-list@lists.sourceforge.net; Wed, 17 Nov 2010 09:40:38 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PIeVH-0003pk-Sh
	for ltp-list@lists.sourceforge.net; Wed, 17 Nov 2010 09:40:36 +0000
Received: by wyb34 with SMTP id 34so1678160wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Nov 2010 01:40:30 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 17 Nov 2010 01:40:29 -0800
Message-ID: <AANLkTi=85c03TG7hxPz8xKeVFumdkqwAegRQaM+AGp6R@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] New features in LTP (11/17/2010)
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
To: LTP list <ltp-list@lists.sourceforge.net>

    So, I've added a number of features to the copy of ltp on git
today -- most notably:
1. Some knobs for specifying features that you want to test. This is
currently limited to open_posix_testsuite, the power management
testsuite, and the realtime tests. Please note the knobs help
description via configure --help.
2. Less warnings are now printed out via autoconf (yay!).
3. The default scenario set was moved from execltp / runltp to
scenario_groups/default and scenario_groups/net ; soon 1. will tie
into 3. so the default scenario and net scenarios can be modified on
the fly according to features enabled/disabled via configure.
    Many features are disabled conservatively in light of the fact
that some folks on the list are still running outdated versions of
LTP. Eventually I'd like for some of the complexity in the kernel
version and feature comparison to be to the simplest pieces method
possible, assuming that the tester knows what they should be testing
(if the tester doesn't understand that fundamental point and how they
need to be running the tests, then they shouldn't be running the tests
at least, or maybe even LTP!), because right now it's very
inconsistent and messy in the repository.
    Other cleanup is pending (open_hpi_testsuite is gone today,
mce-test will be updated and shift around to a better location, etc),
and I hope to resolve a bug that's existed with pan for a while now so
that output is consistent and correct with execltp and other external
parsing scripts.
    Happy testing and let me know what you think :).
Cheers,
-Garrett

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
