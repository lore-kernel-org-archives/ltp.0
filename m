Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nate@refried.org>) id 1N6V5l-00066J-C8
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 20:07:29 +0000
Received: from smtp0.av-mx.com ([137.118.16.56])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6V5f-00008q-BU
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 20:07:24 +0000
Date: Fri, 6 Nov 2009 14:43:35 -0500
From: Nate Straz <nate@refried.org>
Message-ID: <20091106194335.GB32249@refried.org>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060616.40305.vapier@gentoo.org>
	<20091106130906.GW31511@one.firstfloor.org>
	<200911060821.40182.vapier@gentoo.org>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
	<20091106191343.GC819@basil.fritz.box>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091106191343.GC819@basil.fritz.box>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

On Nov  6 20:13, Andi Kleen wrote:
> > So yes, there are known issues with using make versions <3.81. The
> 
> For me it seems more the known issue is in the Makefile. 3.80
> is a widely used Make version.
> 
> > reason being that some macros and functions that I use to determine
> > absolute path, etc were not available in make 3.80.
> 
> Most of my infrastructure in test systems is based on SUSE 10.0 
> and it's impractical to upgrade make everywhere.

openSUSE 10.3 does include make-3.81.  I hope upgrading to the latest
point release won't disrupt your test systems.

http://download.opensuse.org/distribution/10.3/repo/oss/suse/x86_64/make-3.81-66.x86_64.rpm

Nate

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
