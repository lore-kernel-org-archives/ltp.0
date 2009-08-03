Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <matt@apochromatic.org>) id 1MXvh6-00047P-Ap
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:27:08 +0000
Received: from cs20.apochromatic.org ([204.152.189.161])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MXvgw-0002RO-Rm
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:27:08 +0000
Date: Mon, 3 Aug 2009 12:26:20 +0100
From: Matt Fleming <matt@console-pimps.org>
Message-ID: <20090803112620.GB17501@console-pimps.org>
References: <20090730075802.GE3058@console-pimps.org>
	<4A717D05.2070603@petalogix.com>
	<1249298395.7460.24.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1249298395.7460.24.camel@subratamodak.linux.ibm.com>
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Aug 03, 2009 at 04:49:55PM +0530, Subrata Modak wrote:
> On Thu, 2009-07-30 at 12:59 +0200, Michal Simek wrote: 
> > Hi Matt,
> > > Attached is a patch to skip testcases fcntl24, fcntl25 and fcntl26 if
> > > the host is running on tmpfs. The reason being that, as documented here
> > > http://bugzilla.kernel.org/show_bug.cgi?id=13626, F_SETLEASE and F_WRLCK
> > > cannot work on tmpfs.
> 
> Thanks for this patch, except that it does not have a Signed-off-by:
> Matt Fleming <matt@console-pimps.org>, though i have added the same in
> CVS log message:
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/fcntl/fcntl24.c?view=log,
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/fcntl/fcntl25.c?view=log,
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/kernel/syscalls/fcntl/fcntl26.c?view=log,
> 

Oops, sorry I forgot the SOB line. Thanks for applying them!


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
