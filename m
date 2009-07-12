Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MPnOl-00069j-SP
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 00:58:35 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MPnOh-0006gQ-7s
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 00:58:35 +0000
Received: by pzk8 with SMTP id 8so1338918pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 11 Jul 2009 17:58:30 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 11 Jul 2009 17:58:30 -0700
Message-ID: <364299f40907111758m79a4cb43w9f25dc229ee0842b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] Adding hooks for mm.h test in autoconf?
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
To: Matt Helsley <matthltc@us.ibm.com>, Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi Matt and Mike,
    I realize this isn't an automake / autoconf support list, but I
ran into a snag when trying to compile libmm in hugetlb, where my
system doesn't have this header, even after I run configure. I added a
test for it in configure, but I'm not sure how to interface with
config.mk. Any hints?
    I'll gladly add the directions to the documentation.
Thanks,
-Garrett

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
