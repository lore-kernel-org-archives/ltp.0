Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uz4gs-0007il-J7
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 12:49:14 +0000
Date: Tue, 16 Jul 2013 14:50:53 +0200
From: chrubis@suse.cz
Message-ID: <20130716125053.GC21078@rei>
References: <005001ce81ef$7ea7dc20$7bf79460$@lge.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <005001ce81ef$7ea7dc20$7bf79460$@lge.com>
Subject: Re: [LTP] [PATCH] Fix the bug of the temp-files removing
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
To: Jungsoo Son <jungsoo.son@lge.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The shell command to remove all the temp-files created had a bug that
> try to remove /dev/null. If the ltp is run with root permission the
> /dev/null will be removed.

Good catch, applied.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
