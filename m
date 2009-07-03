Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMYMh-0000a7-On
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 02:19:03 +0000
Received: from an-out-0708.google.com ([209.85.132.240])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMYMc-0006is-VN
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 02:19:03 +0000
MIME-Version: 1.0
In-Reply-To: <20090702091341.GG19135@count0.beaverton.ibm.com>
References: <20090702091341.GG19135@count0.beaverton.ibm.com>
Date: Thu, 2 Jul 2009 19:18:58 -0700
Message-ID: <364299f40907021918wb3f95e7w6fd24ec8208e7c0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [RFC][PATCH] Use prefix and other autoconf variables
	uniformly
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

    I understand what you're trying to accomplish, but part of the
point behind the current design with the Makefile system was in fact
for it to be run without intervention from autotools. Hence, the
directions noted in INSTALL / the help target up at the top.
Thanks,
-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
