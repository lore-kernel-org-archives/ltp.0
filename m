Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1MyWBJ-00088R-8x
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 19:40:13 +0000
Date: Thu, 15 Oct 2009 21:39:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091015193958.GB2875@schrodinger.suse.cz>
References: <20091014115618.7801.69877.sendpatchset@subratamodak.linux.ibm.com>
	<20091015162356.GB4152@schrodinger.suse.cz>
	<20091015173026.GA25999@schrodinger.suse.cz>
	<364299f40910151155x646bcf38naa53e5af4aad75b3@mail.gmail.com>
	<364299f40910151209s4a75e999he76b9c1d9b58a88a@mail.gmail.com>
	<364299f40910151211r48d7510fnfc3c69a685923ca5@mail.gmail.com>
	<20091015192053.GA2875@schrodinger.suse.cz>
	<364299f40910151225lea3392fj9e36f4afe43fe67d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40910151225lea3392fj9e36f4afe43fe67d@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Re: compile fails for libcpuset.c on
	SLES-11	s390x with ltp-full-20090930
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
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>, Mark Ver <markver@us.ibm.com>, Sachin P Sant <sachinp@in.ibm.com>

Hi!
>     This can be corrected by adding this logic to a common Makefile if
> you like, so that way it does get picked up from one common source.
> This makes more sense from a design perspective.

Okay, this way people wouldn't be using ugly hacks to include that header. IMHO
the easier to use is the buildsystem, the less ugly hacks will come.

-- 
Cyril Hrubis
chrubis@suse.cz

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
