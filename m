Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSmZ9-000519-Li
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 12:04:19 +0000
Date: Wed, 26 Mar 2014 13:03:50 +0100
From: chrubis@suse.cz
Message-ID: <20140326120350.GA9168@rei.suse.cz>
References: <1395818998-836-1-git-send-email-xu.simon@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395818998-836-1-git-send-email-xu.simon@oracle.com>
Subject: Re: [LTP] [PATCH] xinetd_tests.sh: support systemd restart
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
To: Simon Xu <xu.simon@oracle.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Support xinetd service restart by systemd, which is used in recent
> Linux releases, e.g. RHEL7.

We allready have solution to this problem in testcases/lib/cmdlib.sh see
restart_daemon().

I guess that the code to control daemons should be isolated from the
rest of the cmdlib.sh (that is obsoleted by the test.sh). I will move
the code to separate library, source it from the cmdlib.sh to retain
compatibility and add docs to test-writing-guidelines. Once that is
done, can you fix the test using the library code?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
