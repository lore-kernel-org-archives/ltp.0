Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WpeoT-0007qN-1E
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 14:26:41 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 209EFAC3A
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 May 2014 14:26:33 +0000 (UTC)
Date: Wed, 28 May 2014 16:26:24 +0200
From: chrubis@suse.cz
Message-ID: <20140528142624.GB15351@rei>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [RFC] usctest.h and parse_opts.c spring cleanup
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
As you may have seen I've started to cleanup the usctest.h and
parse_opts.c code. So far the cleanup only shuffled things around
and there were no functionality changes.

The next step I'm pondering is to remove two interfaces.

The first one is the '-c' (Run n copies concurrenly) parameter. The
reason is that it's know to be broken for quite some time, see:

http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg13418.html

And even if we teach pan to wait, there are testcases that will fail
because they aren't coded (anything that works with devices or other
resources available in single instance) or supposed to run concurently
(realtime threads etc).

The second one is STD_FUNCTIONAL_TEST, which can be, in theory, used to
disable functional test for cca 350 testcase that actually use it. I do
not think that this is actually useful for anything.

Does anybody have additional thoughts agree/disagree with this plan?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
