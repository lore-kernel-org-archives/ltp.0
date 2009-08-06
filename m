Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <galak@kernel.crashing.org>) id 1MZ5g4-0000S2-VB
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 16:18:52 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZ5fv-000640-RJ
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 16:18:52 +0000
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n76GIa3O018283
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Aug 2009 11:18:37 -0500
Message-Id: <1842FA33-8C6C-4BE1-8FB4-B8836F1C8F6E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Thu, 6 Aug 2009 11:18:36 -0500
Subject: [LTP] RANLIB not set?
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
To: LTP <ltp-list@lists.sourceforge.net>

I'm seeing this on fedora 11 on ppc64:

make[3]: Leaving directory `/root/ltp/testcases/network/ipv6'
make[3]: Entering directory `/root/ltp/testcases/network/lib6'
cc -Wall  -I../../../include -g -D_GNU_SOURCE   -c -o runcc.o runcc.c
ar cr runcc.a runcc.o
runcc.a
make[3]: runcc.a: Command not found
make[3]: *** [runcc.a] Error 127
make[3]: Leaving directory `/root/ltp/testcases/network/lib6'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/root/ltp/testcases/network'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/ltp/testcases'
make: *** [all] Error 2

- k

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
