Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWmmS-0001Ys-3C
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 07:43:56 +0000
Received: from rv-out-0708.google.com ([209.85.198.250])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWmmL-00015k-2H
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 07:43:56 +0000
Received: by rv-out-0708.google.com with SMTP id b17so506899rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Fri, 31 Jul 2009 00:43:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907302333s61742580m5dba94b0a2e7afa5@mail.gmail.com>
References: <364299f40907302333s61742580m5dba94b0a2e7afa5@mail.gmail.com>
Date: Fri, 31 Jul 2009 00:43:32 -0700
Message-ID: <364299f40907310043q234fc7ebt4e6ce9a98c2da953@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: LTP list <ltp-list@lists.sourceforge.net>

On Thu, Jul 30, 2009 at 11:33 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> clone(2) is externally defined in sched.h, and as such
> testcases/kernel/security/digsig/writeexec/libwritetest.c fails to
> compile with -Wall due to a shadowed declaration.
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Index: writeexec/libwritetest.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/digsig/writeexec/lib=
writetest.c,v
> retrieving revision 1.1
> diff -u -r1.1 libwritetest.c
> --- writeexec/libwritetest.c =A0 =A01 Nov 2005 16:09:43 -0000 =A0 =A0 =A0=
 1.1
> +++ writeexec/libwritetest.c =A0 =A031 Jul 2009 06:30:49 -0000
> @@ -9,8 +9,6 @@
> =A0#include <dlfcn.h>
> =A0#include <wait.h>
>
> -int clone(int (*fn)(void *), void *child_stack, int flags, void *arg);
> -
> =A0int writer(void *data)
> =A0{
> =A0 =A0 =A0 =A0int fd;

Instead of this, let me do a general purpose `fix' for digsig. There
are a few other issues that need to be resolved.
-Garrett

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
