Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NLBp8-0002sN-KA
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 08:35:02 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLBp3-0006xv-CU
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 08:35:02 +0000
Received: by pwj11 with SMTP id 11so1283285pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 17 Dec 2009 00:34:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B28C683.3030106@cn.fujitsu.com>
References: <4B28C683.3030106@cn.fujitsu.com>
Date: Thu, 17 Dec 2009 00:34:51 -0800
Message-ID: <364299f40912170034h44dd353bg582ae92dd22b2eb6@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/3] ade: fix the bug of objdump01
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Dec 16, 2009 at 3:37 AM, liubo <liubo2009@cn.fujitsu.com> wrote:
> - LTP needs to test "objdump", but ade's Makefile exclude it.
> - objdump01 case uses *.obj instead, so s/*.o/*.obj/
>
> This patch fixed these.
>
> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
>
> ---
> =A0testcases/commands/ade/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0testcases/commands/ade/objdump/Makefile =A0| =A0 =A04 ++--
> =A0testcases/commands/ade/objdump/objdump01 | =A0 =A02 +-
> =A03 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/commands/ade/Makefile b/testcases/commands/ade/Mak=
efile
> index cf7a487..79de5ec 100644
> --- a/testcases/commands/ade/Makefile
> +++ b/testcases/commands/ade/Makefile
> @@ -25,6 +25,6 @@ top_srcdir =A0 =A0 =A0 =A0 =A0 =A0?=3D ../../..
> =A0include $(top_srcdir)/include/mk/env_pre.mk
>
> =A0# XXX (garrcoop): objdump's Makefile needs fixing.
> -FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D objdump
> +FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D
>
> =A0include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/commands/ade/objdump/Makefile b/testcases/commands=
/ade/objdump/Makefile
> index 862438c..7fffc88 100644
> --- a/testcases/commands/ade/objdump/Makefile
> +++ b/testcases/commands/ade/objdump/Makefile
> @@ -29,8 +29,8 @@ test: CPPFLAGS +=3D -O
> =A0test_arch.obj: test.o
> =A0 =A0 =A0 =A0mv $< "$@"
>
> -test_D: test.o
> - =A0 =A0 =A0 $(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION) $@
> +test_D: test_arch.obj
> + =A0 =A0 =A0 $(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
>
> =A0INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D objdump01
>
> diff --git a/testcases/commands/ade/objdump/objdump01 b/testcases/command=
s/ade/objdump/objdump01
> index 379a4f8..dd18e46 100755
> --- a/testcases/commands/ade/objdump/objdump01
> +++ b/testcases/commands/ade/objdump/objdump01
> @@ -41,7 +41,7 @@ export DUMP=3D/usr/bin/objdump
> =A0do_setup()
> =A0{
> =A0mkdir $TCtmp
> -/usr/bin/ar -cr $TCtmp/lib.a $TCsrc/test_arch.o
> +/usr/bin/ar -cr $TCtmp/lib.a $TCsrc/test_arch.obj
>
> =A0echo 1; $DUMP -f $TCsrc/test > $TCtmp/er_dump_f
> =A0echo 2; $DUMP -h $TCsrc/test > $TCtmp/er_dump_h

This was fixed last week, IIRC.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
