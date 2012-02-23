Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S0aAK-0002t3-0y
	for ltp-list@lists.sourceforge.net; Thu, 23 Feb 2012 15:01:04 +0000
Date: Thu, 23 Feb 2012 16:01:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120223150127.GA5960@saboteur.suse.cz>
References: <1324980149-29612-1-git-send-email-YanFeng.Shang@windriver.com>
	<20120202161442.GC3605@saboteur.suse.cz>
	<201202021133.54143.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201202021133.54143.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] hugeshmat01 isn't adapt to mips with 64bit ELF
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
Cc: Shang Yanfeng <YanFeng.Shang@windriver.com>, Haotian.Zhang@windriver.com, ltp-list@lists.sourceforge.net

Hi!
> > > --- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> > > +++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
> > > 
> > >  #define CASE1		20		/* memory location.		   */
> > >  #if __WORDSIZE==64
> > > +#if defined(__mips__)
> > > +#define UNALIGNED      0x1000000eee
> > > +#else
> > >  #define UNALIGNED      0x10000000eee
> > > +#endif
> > >  #else
> > >  #define UNALIGNED      0x60000eee
> > >  #endif
> > 
> > I wonder why we need such #ifdef for 64 bit systems in the first place,
> > or is the unaligned address 0x60000eee too low for 64 bit system?
> > 
> > Garrett, Mike any clue?
> 
> i can only guess that the author was attempting to locate a highly-unlikely-
> to-be-used memory location

Hmm, okay. So what we need is to create library function that returns
highly-unlikely memory location (I've seen this code in several places
and I would like to avoid the duplication).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
