Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi@firstfloor.org>) id 1N6UG8-000262-LI
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:14:08 +0000
Received: from one.firstfloor.org ([213.235.205.2])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6UFx-0007FU-Bn
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:14:03 +0000
Date: Fri, 6 Nov 2009 20:13:43 +0100
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20091106191343.GC819@basil.fritz.box>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060616.40305.vapier@gentoo.org>
	<20091106130906.GW31511@one.firstfloor.org>
	<200911060821.40182.vapier@gentoo.org>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
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
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>, Mike Frysinger <vapier@gentoo.org>

> So yes, there are known issues with using make versions <3.81. The

For me it seems more the known issue is in the Makefile. 3.80
is a widely used Make version.

> reason being that some macros and functions that I use to determine
> absolute path, etc were not available in make 3.80.

Most of my infrastructure in test systems is based on SUSE 10.0 
and it's impractical to upgrade make everywhere.

I find it very sad that LTP now descended into "version hell"
and abandoned old distributions.
 
> I've considered adding a configure check for the make version. I'm
> probably going to do it this weekend to avoid support issues like
> these.

That's not a solution.

Please just fix the makefiles or revert this misguided change
and give us working makefiles back.

From a quick look at the mailing list archives that doesn't
even seem to be the only problem with this "improvement".

Thanks.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
