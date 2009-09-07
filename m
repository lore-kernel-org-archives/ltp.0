Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Mkcgy-00044A-LK
	for ltp-list@lists.sourceforge.net; Mon, 07 Sep 2009 11:47:28 +0000
Date: Mon, 7 Sep 2009 13:47:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20090907114715.GA10983@schrodinger.suse.cz>
References: <20090831174107.GB30788@schrodinger.suse.cz>
	<1252323725.4922.33.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1252323725.4922.33.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] broken epoll Makefile
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > compilation of testcases/kernel/syscalls/epoll was randomly faling on s390,
> > while trying to find culprint I've noticed that test in Makefile is badly
> > broken. The problematic line is:
> > 
> > LIBC_HAS_EPOLL := $(shell echo '\#include <sys/epoll.h>' | $(CC) -E - > /dev/null 2>&1 && echo yes)
> > 
> > Where sombody added \ to escape # from makefile, but this is being printed into
> > the $(CC) input and because of this LIBC_HAS_EPOLL is set to 'yes' no matter if
> > this header is present or not. However it fails (sometimes) on s390.
> > 
> > This check should be moved to autoconf but just for now I'm too tired to
> > do that.
> 
> Can you please send a patch now ?

Working on. Should be hopefully finished today.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
