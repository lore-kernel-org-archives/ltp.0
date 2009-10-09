Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mw9HK-0004en-8s
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 06:48:38 +0000
Received: from mail-px0-f172.google.com ([209.85.216.172])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mw9HF-0007lC-L5
	for ltp-list@lists.sourceforge.net; Fri, 09 Oct 2009 06:48:38 +0000
MIME-Version: 1.0
In-Reply-To: <20091009.152108.954124754429052503.yamato@redhat.com>
References: <20091009.152108.954124754429052503.yamato@redhat.com>
Date: Thu, 8 Oct 2009 23:48:27 -0700
Message-ID: <364299f40910082348j371f839cice2b3e3113c5f084@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Checking flex existance in configure
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
To: Masatake YAMATO <yamato@redhat.com>
Cc: ltp-list@lists.sf.net

On Thu, Oct 8, 2009 at 11:21 PM, Masatake YAMATO <yamato@redhat.com> wrote:
> Hi,
>
>
> In INSTALL file:
>
> =A0 =A03. Run "make" to build everything.
> =A0 =A0 =A0 *NOTE: Some of the Makefiles (example: pan/Makefile) require =
the lex (or
> =A0 =A0 =A0 flex) package to be installed.
>
> I've added AC_PROG_LEX to configure.ac to check the existance of flex or =
lex command.
>
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
>
> Index: config.mk.in
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/config.mk.in,v
> retrieving revision 1.5
> diff -u -r1.5 config.mk.in
> --- config.mk.in =A0 =A0 =A0 =A07 Sep 2009 07:08:53 -0000 =A0 =A0 =A0 1.5
> +++ config.mk.in =A0 =A0 =A0 =A09 Oct 2009 06:13:07 -0000
> @@ -2,6 +2,9 @@
> =A0AR =3D @AR@
> =A0RANLIB =3D @RANLIB@
>
> +LEX =3D @LEX@
> +LEXLIB =3D @LEXLIB@
> +
> =A0CPPFLAGS =3D @CPPFLAGS@
> =A0CFLAGS =3D @CFLAGS@
> =A0LDFLAGS =3D @LDFLAGS@
> Index: configure.ac
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/configure.ac,v
> retrieving revision 1.16
> diff -u -r1.16 configure.ac
> --- configure.ac =A0 =A0 =A0 =A09 Sep 2009 17:48:08 -0000 =A0 =A0 =A0 1.16
> +++ configure.ac =A0 =A0 =A0 =A09 Oct 2009 06:13:07 -0000
> @@ -8,6 +8,7 @@
> =A0AC_PROG_CC
> =A0AC_PROG_AR
> =A0AC_PROG_RANLIB
> +AC_PROG_LEX
>
> =A0AC_CHECK_HEADERS_ONCE([ \
> =A0ifaddrs.h \
> Index: pan/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/pan/Makefile,v
> retrieving revision 1.19
> diff -u -r1.19 Makefile
> --- pan/Makefile =A0 =A0 =A0 =A019 May 2009 09:39:11 -0000 =A0 =A0 =A01.19
> +++ pan/Makefile =A0 =A0 =A0 =A09 Oct 2009 06:13:07 -0000
> @@ -1,3 +1,4 @@
> +include ../config.mk
>
> =A0LOADLIBES +=3D -lm
> =A0LFLAGS +=3D -l -w
> Index: testcases/ballista/ballista/compile/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/ballista/ballista/compile/Makefile,v
> retrieving revision 1.2
> diff -u -r1.2 Makefile
> --- testcases/ballista/ballista/compile/Makefile =A0 =A0 =A0 =A026 Feb 20=
09 06:29:46 -0000 =A0 =A0 =A01.2
> +++ testcases/ballista/ballista/compile/Makefile =A0 =A0 =A0 =A09 Oct 200=
9 06:13:08 -0000
> @@ -15,6 +15,9 @@
> =A0# along with this program; if not, write to the Free Software
> =A0# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA =A002111-1=
307, USA.
>
> +include ../../../config.mk
> +
> +
> =A0dFLAGS=3D-g -DDEBUG
> =A0FLAGS=3D -O -Wall
> =A0PFLAGS=3D -p -g3
> @@ -53,7 +56,7 @@
> =A0lex.yy.o: lex.yy.c
>
> =A0lex.yy.c: ballista.l tokens.h
> - =A0 =A0 =A0 flex ballista.l
> + =A0 =A0 =A0 $(LEX) ballista.l
>
> =A0blexer.o: blexer.c blexer.h jlist.h butil.h

I'll gladly add in the one-liner to ballista.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
