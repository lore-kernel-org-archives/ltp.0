Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matt@apochromatic.org>) id 1MWXow-00008B-9p
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 15:45:30 +0000
Received: from cs20.apochromatic.org ([204.152.189.161])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWXor-0002E8-Vl
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 15:45:30 +0000
Date: Thu, 30 Jul 2009 16:44:52 +0100
From: Matt Fleming <matt@console-pimps.org>
Message-ID: <20090730154452.GG3058@console-pimps.org>
References: <20090730075802.GE3058@console-pimps.org>
	<4A717D05.2070603@petalogix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4A717D05.2070603@petalogix.com>
Subject: Re: [LTP] fcntl24,25,26 fail when run on tmpfs
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
To: Michal Simek <michal.simek@petalogix.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jul 30, 2009 at 12:59:17PM +0200, Michal Simek wrote:
> Hi Matt,
> > Attached is a patch to skip testcases fcntl24, fcntl25 and fcntl26 if
> > the host is running on tmpfs. The reason being that, as documented here
> > http://bugzilla.kernel.org/show_bug.cgi?id=13626, F_SETLEASE and F_WRLCK
> > cannot work on tmpfs.
> >   
> I tested it and works. The same issue is for RAMFS. But for this fs in
> necessary to create
> tst_is_cwd_ramfs function. Maybe worth to add together
> tst_is_cwd_tmpfs.c and tst_cwd_has_free.c too.
>

Thanks for testing. Yes, the same issue will affect ramfs too.

I'm not quite sure what sure why you're saying tst_cwd_has_free is
needed?

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
