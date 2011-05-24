Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QOv4G-0002sm-4q
	for ltp-list@lists.sourceforge.net; Tue, 24 May 2011 17:06:52 +0000
Date: Tue, 24 May 2011 19:03:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110524170305.GA5861@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] The open posix testsuite return codes
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
Some of the tests returns UNRESOLVED (for example
conformance/interfaces/aio_return/2-1.c) for optional behavior and that
is problem since most of the codebase uses UNRESOLVED for testcases that
failed before we were able to test the desired behavior. What about
mapping these rather to UNSUPPORTED or creating return value OPTIONAL?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
vRanger cuts backup time in half-while increasing security.
With the market-leading solution for virtual backup and recovery, 
you get blazing-fast, flexible, and affordable data protection.
Download your free trial now. 
http://p.sf.net/sfu/quest-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
