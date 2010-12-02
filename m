Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PNx3B-0003EF-Kq
	for ltp-list@lists.sourceforge.net; Thu, 02 Dec 2010 00:29:29 +0000
Received: from out18.sjc.mx.trendmicro.com ([216.99.131.75])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PNx3A-0008M0-2F
	for ltp-list@lists.sourceforge.net; Thu, 02 Dec 2010 00:29:29 +0000
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 2 Dec 2010 09:29:00 +0900
Message-ID: <000c01cb91b7$ea0bddc0$be239940$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] [PATCH] open_posix_testsuite: Don\'t use clock_settime()
	to reset a CPU-time Clock
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
To: guijianfeng@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

I agree the opinion of Gui. 

In my environment, the difference of clock-ID in the same way as 
Gui's opinion occurs with recent git.
"clock_getcpuclockid/2-1.c" succeeded with Gui's patch.


Thank you--

-Tomonori Mitani



------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
