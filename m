Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <caiqian@cclom.cn>) id 1MfHdH-0004qh-UW
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 18:17:35 +0000
Received: from smtp105.biz.mail.mud.yahoo.com ([68.142.200.253])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MfHdG-0004cW-QO
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 18:17:35 +0000
Date: Mon, 24 Aug 2009 01:27:23 +0800 (CST)
Message-Id: <20090824.012723.112609532.caiqian@cclom.cn>
From: CAI Qian <caiqian@cclom.cn>
Mime-Version: 1.0
Subject: [LTP] What is the Story of "make autotools"
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
To: ltp-list@lists.sf.net

Hi,

Looks like it stops working recently with,

  autoconf-2.63-2.fc11.noarch
  automake-1.11-2.fc11.noarch

$ make autotools
make: *** No rule to make target `m4/Makefile.am', needed by
      `m4/Makefile.in'.  Stop.

CAI Qian

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
