Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MTFN8-0004Iv-2P
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 13:27:10 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MTFN2-0000Rq-2W
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 13:27:10 +0000
Received: by fxm4 with SMTP id 4so2726969fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Jul 2009 06:27:00 -0700 (PDT)
Message-ID: <4A65C221.6050605@petalogix.com>
Date: Tue, 21 Jul 2009 15:26:57 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] utimensat_tests.sh
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
To: LTP <ltp-list@lists.sourceforge.net>

Hi All,

is it any reason why is used for utimensat test utimensat_tester user?

I use busybox and there is adduser. I have in on my host pc too.
But I still think that we could use any user which is required for LTP tests
not create new one. Any suggestion which one?

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
