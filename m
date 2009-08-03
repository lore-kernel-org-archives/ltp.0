Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MXvag-0007as-4L
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:20:30 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MXvad-00015j-Rr
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 11:20:30 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n73BFZX1004120
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:15:35 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n73BKMsb187436
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:20:22 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n73BKL8O004836
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Aug 2009 05:20:22 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090731143642.GB9440@us.ibm.com>
References: <364299f40907302333s61742580m5dba94b0a2e7afa5@mail.gmail.com>
	<364299f40907310043q234fc7ebt4e6ce9a98c2da953@mail.gmail.com>
	<20090731143642.GB9440@us.ibm.com>
Date: Mon, 03 Aug 2009 16:50:17 +0530
Message-Id: <1249298418.7460.27.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Fix digsig so it passes -Wshadow
Reply-To: subrata@linux.vnet.ibm.com
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Fri, 2009-07-31 at 09:36 -0500, Serge E. Hallyn wrote: 
> Quoting Garrett Cooper (yanegomi@gmail.com):
> > On Thu, Jul 30, 2009 at 11:33 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> > > clone(2) is externally defined in sched.h, and as such
> > > testcases/kernel/security/digsig/writeexec/libwritetest.c fails to
> > > compile with -Wall due to a shadowed declaration.
> > >
> > > Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> > >
> > > Index: writeexec/libwritetest.c
> > > ===================================================================
> > > RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/digsig/writeexec/libwritetest.c,v
> > > retrieving revision 1.1
> > > diff -u -r1.1 libwritetest.c
> > > --- writeexec/libwritetest.c    1 Nov 2005 16:09:43 -0000       1.1
> > > +++ writeexec/libwritetest.c    31 Jul 2009 06:30:49 -0000
> > > @@ -9,8 +9,6 @@
> > >  #include <dlfcn.h>
> > >  #include <wait.h>
> > >
> > > -int clone(int (*fn)(void *), void *child_stack, int flags, void *arg);
> > > -
> > >  int writer(void *data)
> > >  {
> > >        int fd;
> > 
> > Instead of this, let me do a general purpose `fix' for digsig. There
> > are a few other issues that need to be resolved.
> > -Garrett
> 
> Alternatively, since digsig never went upstream and isn't being
> maintained, it might be best to drop this from LTP.  <sniff>

Oh. Is it ? So, should i finally drop this from LTP ?

Regards--
Subrata

> 
> -serge
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
