Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rdunlap@xenotime.net>) id 1N7ErQ-0001Nt-EW
	for ltp-list@lists.sourceforge.net; Sun, 08 Nov 2009 20:59:44 +0000
Received: from xenotime.net ([72.52.64.118])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1N7ErL-000688-TQ
	for ltp-list@lists.sourceforge.net; Sun, 08 Nov 2009 20:59:44 +0000
Received: from chimera.site ([96.253.169.185]) by xenotime.net for
	<ltp-list@lists.sourceforge.net>; Sun, 8 Nov 2009 11:49:21 -0800
Date: Sun, 8 Nov 2009 11:49:20 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
Message-Id: <20091108114920.68ede189.rdunlap@xenotime.net>
In-Reply-To: <364299f40911081117x47ddffbfl96eeec547b5c95e5@mail.gmail.com>
References: <1257167821.4977.41.camel@subratamodak.linux.ibm.com>
	<364299f40911061728g37c0cd6ble40974b0fe5b5597@mail.gmail.com>
	<20091108095019.184998b2.rdunlap@xenotime.net>
	<200911081313.25577.vapier@gentoo.org>
	<364299f40911081117x47ddffbfl96eeec547b5c95e5@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [LTP] [patch 2/2] INSTALL corrections & TODO
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
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>, Mike Frysinger <vapier@gentoo.org>, ltp-list <ltp-list@lists.sf.net>

On Sun, 8 Nov 2009 11:17:44 -0800 Garrett Cooper wrote:

> On Sun, Nov 8, 2009 at 10:13 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> > On Sunday 08 November 2009 12:50:19 Randy Dunlap wrote:
> >> On Fri, 6 Nov 2009 17:28:42 -0800 Garrett Cooper wrote:
> >> > On Fri, Nov 6, 2009 at 4:03 PM, Randy Dunlap wrote:
> >> > > "Configuration" section to match Makefile message.
> >> > > How to use DESTDIR and --prefix together.
> >> > >
> >> > > TODO:
> >> > > "Quick Start" does not work.
> >> > > "Not using autoconf:" does not work.
> >> > >
> >> > > ---
> >> > > =A0INSTALL | =A0 =A09 ++++++++-
> >> > > =A01 file changed, 8 insertions(+), 1 deletion(-)
> >> > >
> >> > > --- ltp-full-20091031-auto.orig/INSTALL
> >> > > +++ ltp-full-20091031-auto/INSTALL
> >> > > @@ -29,7 +29,7 @@ downloaded from:
> >> > > =A0- http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.bz2
> >> > > =A0- http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.gz
> >> > >
> >> > > -Configuring
> >> > > +Configuration
> >> > > =A0-------------------
> >> > > =A0Using autoconf:
> >> > > =A0 =A0 =A0 =A0 $ make autotools # This must be run from "$TOP_SRC=
DIR!"
> >> > > @@ -74,6 +74,13 @@ in the same directory where the source f
> >> > > =A0 sysroot, as opposed to the host system's sysroot.
> >> > > =A0- Specify SKIP_IDCHECK=3D1 if and when you don't want to modify
> >> > > /etc/{group,passwd} on the target system's sysroot.
> >> > > +- If you want to build and install ltp inside its source tree (e.=
g.,
> >> > > in + =A0$TOP_SRCDIR/ltpbin/), to support multiple versions of LTP =
on one
> >> > > system, + =A0then use
> >> > > +
> >> > > + =A0 =A0 =A0 $ cd $TOP_SRCDIR
> >> > > + =A0 =A0 =A0 $ mkdir ltpbin
> >> > > + =A0 =A0 =A0 $ ./configure DESTDIR=3D$PWD --prefix=3D$PWD/ltpbin
> >> > >
> >> > > =A0If you get a build error, please report it to ltp-list@lists.sf=
.net
> >> > > with following information,
> >> >
> >> > My only question about this is this step above a frequently used use=
case?
> >>
> >> I can't answer that. =A0It seems like a good idea to be able to have
> >> multiple versions of ltp installed and it took me a little while to
> >> figure out how to use both DESTDIR and --prefix, so I'd like a referen=
ce
> >> for it...
> >
> > --prefix and DESTDIR under LTP should work exactly the same as under any
> > autotooled package. =A0passing DESTDIR to configure doesnt make sense i=
mo, nor
> > does this example. =A0this example suggests a file tree of:
> > $PWD/$PWD/ltpbin/.....
> =

> 1. DESTDIR doesn't get saved with configure today (and quite frankly
> won't work).
> 2. --prefix alone will do the trick (unless you're exporting this via
> NFS at $(DESTDIR) or chrooting the path).


whatever.  I sent a patch for what worked for me.

thanks.
---
~Randy

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
