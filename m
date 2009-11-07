Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N6ZhT-0003hy-OM
	for ltp-list@lists.sourceforge.net; Sat, 07 Nov 2009 01:02:43 +0000
Received: from mail-pw0-f48.google.com ([209.85.160.48])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6ZhN-0002Zv-Ct
	for ltp-list@lists.sourceforge.net; Sat, 07 Nov 2009 01:02:43 +0000
MIME-Version: 1.0
In-Reply-To: <4AF4B952.4090508@xenotime.net>
References: <1257167821.4977.41.camel@subratamodak.linux.ibm.com>
	<87iqdn76jg.fsf@basil.nowhere.org>
	<364299f40911061339x7b689d3cw705674bd9b332e5c@mail.gmail.com>
	<4AF4B952.4090508@xenotime.net>
Date: Fri, 6 Nov 2009 17:02:31 -0800
Message-ID: <364299f40911061702o3be36380r8c56fb862427ed26@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [patch 1/2] small makefile corrections
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
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: ltp-list <ltp-list@lists.sf.net>, Andi Kleen <andi@firstfloor.org>

On Fri, Nov 6, 2009 at 4:03 PM, Randy Dunlap <rdunlap@xenotime.net> wrote:
>
> Correct filename and spello/typo.
>
> ---
> =A0Makefile =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0README.mk-devel | =A0 =A02 +-
> =A02 files changed, 2 insertions(+), 2 deletions(-)
>
> --- ltp-full-20091031.orig/Makefile
> +++ ltp-full-20091031/Makefile
> @@ -32,7 +32,7 @@ include $(top_srcdir)/include/mk/automak
>
> =A0# This variable is automatically changed from help to all once someone=
 has
> =A0# run configure, or the equivalent steps manually, as described in
> -# README.mk-user.
> +# README.mk-devel.
> =A0ifeq ($(wildcard $(top_builddir)/include/config.h),)
> =A0.DEFAULT_GOAL =A0 =A0 =A0 =A0 =A0:=3D help
> =A0else

Actually it's been merged into INSTALL, but definitely thanks for the catch!

> --- ltp-full-20091031.orig/README.mk-devel
> +++ ltp-full-20091031/README.mk-devel
> @@ -70,7 +70,7 @@ include $(top_srcdir)/include/mk/generic
> =A0Make Rules and Make Variables
> =A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> -When using make rules, avoid writing adhoc rules like:
> +When using make rules, avoid writing ad hoc rules like:
>
> =A0[prog]: [dependencies]
> =A0 =A0 =A0 =A0cc -I../../include $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $(LDLI=
BS) \
>

Ok. Silly me with the typo ><.

Thanks for providing this!
-Garrett

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
