Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matthltc@us.ibm.com>) id 1MMZHU-0003h5-JW
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 03:17:44 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMZHP-0004kh-KF
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 03:17:43 +0000
Date: Thu, 2 Jul 2009 20:17:36 -0700
From: Matt Helsley <matthltc@us.ibm.com>
Message-ID: <20090703031736.GK19135@count0.beaverton.ibm.com>
References: <20090702091341.GG19135@count0.beaverton.ibm.com>
	<364299f40907021918wb3f95e7w6fd24ec8208e7c0@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40907021918wb3f95e7w6fd24ec8208e7c0@mail.gmail.com>
Subject: Re: [LTP] [RFC][PATCH] Use prefix and other autoconf
	variables	uniformly
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Thu, Jul 02, 2009 at 07:18:58PM -0700, Garrett Cooper wrote:
>     I understand what you're trying to accomplish, but part of the
> point behind the current design with the Makefile system was in fact
> for it to be run without intervention from autotools. Hence, the
> directions noted in INSTALL / the help target up at the top.
> Thanks,
> -Garrett

Suitable default files should fix the non-autotools path and allow the
autotools path to use prefix and the other variables. Does that seem
fine to you?

Cheers,
	-Matt

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
