Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1NRpdS-0000I7-7S
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 16:18:26 +0000
Received: from mail-bw0-f212.google.com ([209.85.218.212])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NRpdQ-00045x-WE
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 16:18:26 +0000
Received: by bwz4 with SMTP id 4so9527411bwz.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Jan 2010 08:18:18 -0800 (PST)
Message-ID: <4B421480.1040400@petalogix.com>
Date: Mon, 04 Jan 2010 17:17:04 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] clone tests fails
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, vapier@gentoo.org

Hi Mike,

I have one question about one your big patch

http://git.kernel.org/?p=linux/kernel/git/galak/ltp.git;a=commitdiff;h=391dc18fe3271fbf2ca1864a5299f091c31e0018

My question is why you add -1 in lib/cloner.c:65

+       ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
+                       clone_flags, arg);

In previous code in clone testcases was nothing like this.
What reason have you had to add it?

Of course the reason is that on Microblaze some tests failed.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
