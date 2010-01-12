Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUaZZ-0001wG-Kl
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 06:49:49 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUaZY-0003xb-NF
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 06:49:49 +0000
Received: by pwj11 with SMTP id 11so2362656pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Jan 2010 22:49:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000301ca932c$10f42400$32dc6c00$@co.jp>
References: <000301ca932c$10f42400$32dc6c00$@co.jp>
Date: Mon, 11 Jan 2010 22:49:41 -0800
Message-ID: <364299f41001112249x64cbafabrc63704828f624ef8@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "make clean" has problem?
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Mon, Jan 11, 2010 at 6:08 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> There is a problem about "make clean"(./Makefile), I think.
> Before the following fix added at 12/11/2009, "/opt/ltp/" directory
> was deleted by "make clean":
> http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/Makefile?r1=3D1.53&r2=3D1.54
> But after this fix, "make clean" could not remove "/opt/ltp/" directory.
>
> If we test new release cvs and there are fixes about permissions
> in new cvs, we can't do the test correctly.
> Because, if "/opt/ltp/" directory remained and new cvs's file
> has same time-stamp and different permissions from old cvs's file,
> the install ended with "make: Nothing to be done for `install'."
> message and this new file can't be installed.
> Then test cases that fixed about permissions ended in "FAIL".
> In recent cvs, To test correctly, we must remove "/opt/ltp/" directory
> by manual operation before trying "make install".
>
> I think that it is right specification to remove "/opt/ltp/" directory
> when "make clean" is executed.
>
>
> This problem occurred because "INSTALL_IN_BUILD_TREE :=3D 1" is defined
> in "./include/mk/env_pre.mk" included in "${LTPROOT}/Makefile", I think.
> "$(prefix)" of a judgment of "ifeq ($(strip $(DESTDIR)$(prefix)),)"
> doesn't have value, therefor the result of the judgment becomes "true",
> and "INSTALL_IN_BUILD_TREE :=3D 1" was defined.
>
> So, it is neccessary to define "$(prefix)" by including "./include/mk/
> config.mk" before including "./include/mk/env_pre.mk", isn't it?
>
>
> The following patch can fix this problem:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- Makefile.orig =A0 =A0 =A0 2010-01-09 17:37:04.000000000 +0900
> +++ Makefile =A0 =A02010-01-12 09:49:29.000000000 +0900
> @@ -27,6 +27,7 @@
>
> =A0top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 ?=3D $(CURDIR)
>
> +include $(top_srcdir)/include/mk/config.mk
> =A0include $(top_srcdir)/include/mk/env_pre.mk
> =A0include $(top_srcdir)/include/mk/automake.mk
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Thank you--
>
>
> -Tomonori Mitani
>
>
>
> -------------------------------------------------------------------------=
-----
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and e=
asy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.so

Ugh... good point, wrong file (env_pre.mk):

   94 ifneq ($(abs_builddir),$(abs_srcdir))
   95 OUT_OF_BUILD_TREE		:=3D 1
   96 else
   97 # Stub support for installing directly in the build tree; the
support is not
   98 # there yet, but the variable itself has its own uses...
   99 ifeq ($(strip $(DESTDIR)$(prefix)),)
  100 INSTALL_IN_BUILD_TREE		:=3D 1
  101 endif
  102 endif
  103
  104 # We can piece together where we're located in the source and
object trees with
  105 # just these two vars and $(CURDIR).
  106 export abs_top_srcdir abs_top_builddir
  107
  108 -include $(top_builddir)/include/mk/config.mk
  109
  110 .DEFAULT_GOAL			:=3D all

I'll fix this in <1 hour.
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
