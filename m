Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VJ1b7-00030R-AK
	for ltp-list@lists.sourceforge.net; Mon, 09 Sep 2013 13:33:45 +0000
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 174F0A51B7
	for <ltp-list@lists.sourceforge.net>;
	Mon,  9 Sep 2013 15:33:36 +0200 (CEST)
Date: Mon, 9 Sep 2013 15:33:56 +0200
From: chrubis@suse.cz
Message-ID: <20130909133355.GG18849@rei>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] LTP sf.net git repo
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
FYI I've fixed the sync script that pushes patches from github to sf.net
(it broke once the git repos on sf.net were changed to use different
 servers and the original repo was switched to read only).

The sf.net repo was out of sync for a few weeks. Now that brings the
question, should we close the sf.net repo pernamently? Currently the web
GUI as well as git access are way to slow and buggy to be usable. I
wonder if redirecting users directly to github would be better.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58041391&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
