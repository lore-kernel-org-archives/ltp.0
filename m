Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WYIDX-0005AE-LE
	for ltp-list@lists.sourceforge.net; Thu, 10 Apr 2014 16:52:47 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 7618AACDB
	for <ltp-list@lists.sourceforge.net>;
	Thu, 10 Apr 2014 16:52:40 +0000 (UTC)
Date: Thu, 10 Apr 2014 18:52:03 +0200
From: chrubis@suse.cz
Message-ID: <20140410165203.GA28293@rei>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] LTP Release
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
If nothing unexpected happens I would like to do a release at the end of
the next week.

What that means for you?

You should grab the latest git and make sure that it compiles and runs
fine. I've allready started with building latest git and found that we
need a autoconf check for -Wold-style-definition that is not supported
by old gcc.

Also consider the git repository frozen (minus the things I've promised
to merge before the release) for anything but fixes for serious bugs
regressions, compilation failures, etc.


That said, let's aim for a good quality release :)

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
