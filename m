Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MyFT2-0005Gs-OV
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 01:49:24 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyFSw-0000cz-Di
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 01:49:24 +0000
Received: by mail-pz0-f188.google.com with SMTP id 26so330320pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 18:49:18 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2009 18:41:31 -0700
Message-ID: <364299f40910141841o53235062k4b2ce3ff508ac247@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [issue 16] ping01 shouldn't use hostname
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
To: LTP list <ltp-list@lists.sourceforge.net>

<output test="ipv6_noexpect : ping6">
ping01      0  TINFO  :  ping with 8 16 32 64 128 256 512 1024 2048
4064 ICMP packets

ping01      0  TINFO  :  calling ping with packet size = 8

ping: unknown host nova_k5

ping01      0  TINFO  :  Cleaning up.

ping01      1  TFAIL  :  Test broken: failed: ping -c 5 -s 8 nova_k5

ping01      0  TINFO  :  Cleaning up.
</output>

Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
