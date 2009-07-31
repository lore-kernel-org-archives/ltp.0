Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1MWtE7-0008HR-Bw
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 14:36:55 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWtE1-00081n-CN
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 14:36:55 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6VEZsPk013768
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2009 08:35:54 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6VEagVa190614
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2009 08:36:43 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6VEagwX023029
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2009 08:36:42 -0600
Date: Fri, 31 Jul 2009 09:36:42 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090731143642.GB9440@us.ibm.com>
References: <364299f40907302333s61742580m5dba94b0a2e7afa5@mail.gmail.com>
	<364299f40907310043q234fc7ebt4e6ce9a98c2da953@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f40907310043q234fc7ebt4e6ce9a98c2da953@mail.gmail.com>
Subject: Re: [LTP] Fix digsig so it passes -Wshadow
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Thu, Jul 30, 2009 at 11:33 PM, Garrett Cooper<yanegomi@gmail.com> wrot=
e:
> > clone(2) is externally defined in sched.h, and as such
> > testcases/kernel/security/digsig/writeexec/libwritetest.c fails to
> > compile with -Wall due to a shadowed declaration.
> >
> > Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> >
> > Index: writeexec/libwritetest.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/digsig/writeexec/l=
ibwritetest.c,v
> > retrieving revision 1.1
> > diff -u -r1.1 libwritetest.c
> > --- writeexec/libwritetest.c =A0 =A01 Nov 2005 16:09:43 -0000 =A0 =A0 =
=A0 1.1
> > +++ writeexec/libwritetest.c =A0 =A031 Jul 2009 06:30:49 -0000
> > @@ -9,8 +9,6 @@
> > =A0#include <dlfcn.h>
> > =A0#include <wait.h>
> >
> > -int clone(int (*fn)(void *), void *child_stack, int flags, void *arg);
> > -
> > =A0int writer(void *data)
> > =A0{
> > =A0 =A0 =A0 =A0int fd;
> =

> Instead of this, let me do a general purpose `fix' for digsig. There
> are a few other issues that need to be resolved.
> -Garrett

Alternatively, since digsig never went upstream and isn't being
maintained, it might be best to drop this from LTP.  <sniff>

-serge

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
