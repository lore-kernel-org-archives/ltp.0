Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UwuaC-0007yL-Dq
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 13:37:24 +0000
Date: Wed, 10 Jul 2013 15:38:57 +0200
From: chrubis@suse.cz
Message-ID: <20130710133856.GD19178@rei.suse.cz>
References: <1373356491-15338-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373356491-15338-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH V3] lib: add tst_kvercmp2 to compare specific
 vendor extra kernel versions
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> We can now test specific verdor kernel versions in
> test cases like:
> 
> static struct tst_kern_exv exv[] = {
> 	{"RHEL6", "234"},
> 	{"SLES10", "0.91"},
> 	{NULL, NULL}
> };
> 
> ...
> 
> 	if (tst_kvercmp2(2, 6, 25, exv) < 0)
> 		...
> ...

This one looks fine, acked.

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
