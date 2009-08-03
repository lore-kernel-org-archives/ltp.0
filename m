Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@monstr.eu>) id 1MXxnJ-0005lg-E6
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:41:41 +0000
Received: from [89.31.47.178] (helo=monstr.eu)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXxnC-00040P-RJ
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 13:41:41 +0000
From: michal.simek@petalogix.com
Date: Mon,  3 Aug 2009 15:24:15 +0200
Message-Id: <1249305859-23722-1-git-send-email-michal.simek@petalogix.com>
Subject: [LTP] Regresion testing for Microblaze
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, monstr@monstr.eu

Hi Subrata,

here 4 tests are from my regresion testing for Microblaze kernel debug.
There is one extension for testing aligned/unaligned get/put_user macros.
The rest of changes are easy.

Thanks,
Michal




------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
