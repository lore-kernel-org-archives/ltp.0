Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MW96D-0002OO-Af
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 13:21:41 +0000
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MW969-0007C7-2S
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 13:21:41 +0000
Received: by bwz11 with SMTP id 11so714594bwz.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jul 2009 06:21:28 -0700 (PDT)
Message-ID: <4A704CD3.60004@petalogix.com>
Date: Wed, 29 Jul 2009 15:21:23 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] msgctl
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
To: LTP <ltp-list@lists.sourceforge.net>, "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>

Hi,

I am trying to understand why we have two msgctl tests in two files
(tests 08/10, 09/11) -> it should be better/easy to add them together
and generate two executable files instead of one.

Here is description why are in LTP.
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg269854.html

Thanks,
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
