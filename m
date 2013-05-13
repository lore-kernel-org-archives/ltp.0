Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ubqpr-00078e-R4
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 11:22:31 +0000
Date: Mon, 13 May 2013 13:23:30 +0200
From: chrubis@suse.cz
Message-ID: <20130513112329.GA4114@rei>
References: <518B618F.80400@cn.fujitsu.com>
	<201305091222.52821.vapier@gentoo.org>
	<518C5CE3.9070702@cn.fujitsu.com>
	<201305101127.49679.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201305101127.49679.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2]semctl/semctl01.c: cleanup
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > > i don't see high level DESCRIPTION/ALGORITHM as "useless".  why do you ?
> > 
> > In my opinion, "ALGORITHM" section of many ltp testcases follows one
> > format: ------------------------------------------------
> > setup()
> > loop test frame
> > 	loop all test cases
> > 		TEST(call)
> > 		if call failed
> > 			log the errno
> > 		else
> > 			if functionality is ok
> > 				case PASS
> > 			else
> > 				case FAIL
> > cleanup()
> > ------------------------------------------------
> > 
> > So, i think this section is redundant and useless once someone has
> > learned the test frame.
> 
> and if you delete all the sections, then what are people going to refer to ?

I usually end up with less structured but IMHO more readable
description. Having the descriptions in form of pseudocode seems to be
useless as the actual code is right bellow it. I tend to rewrite these
into something like:

'Call foo with bar options and check for xyz result.'

Which shortens the description into one sentence but all the important
information is preserved.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
