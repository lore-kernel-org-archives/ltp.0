Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MYFoW-0006zw-FW
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 08:56:08 +0000
Received: from mail-yw0-f185.google.com ([209.85.211.185])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYFoV-0003a5-Kc
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 08:56:08 +0000
Received: by ywh15 with SMTP id 15so4799454ywh.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 04 Aug 2009 01:56:02 -0700 (PDT)
Message-ID: <4A77F5D9.8030101@petalogix.com>
Date: Tue, 04 Aug 2009 10:48:25 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] Extended return flag
Reply-To: michal.simek@petalogix.com
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
To: LTP <ltp-list@lists.sourceforge.net>, "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>, Jiri Palecek <jpalecek@web.de>

Hi All,

I am thinking that will be good to extend return flag for function not
implemented (errno 38) because
some of tests return it when you don't have enable that option is kernel
config.
What do you think?

Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
