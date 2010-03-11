Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NpZmF-0001Ew-M9
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 04:13:39 +0000
Received: from mail-iw0-f176.google.com ([209.85.223.176])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NpZmE-0003Hc-Vg
	for ltp-list@lists.sourceforge.net; Thu, 11 Mar 2010 04:13:39 +0000
Received: by iwn6 with SMTP id 6so5636313iwn.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Mar 2010 20:13:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000a01cac032$c4126c80$4c374580$@co.jp>
References: <000a01cac032$c4126c80$4c374580$@co.jp>
Date: Wed, 10 Mar 2010 20:13:29 -0800
Message-ID: <364299f41003102013w226e9321kde2344f650028b7c@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] "check_for_unshare.c" build failed
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

On Wed, Mar 10, 2010 at 1:19 AM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
>
> I tried to build LTP modules from following git:
>
...

> How about changing Makefile as follows?
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- ./testcases/kernel/containers/Makefile =A0 =A0 =A02010-03-10
> 01:23:25.000000000 +0900
> +++ ./testcases/kernel/containers/Makefile.new =A02010-03-10
> 15:27:20.000000000 +0900
> @@ -28,6 +28,8 @@
>
> =A0LIB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D -ld
>
> +CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D -ldl
> +
> =A0INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D *.sh

    I realize that this has already been resolved, but just to make
sure we're all clear LDLIBS should contain -l arguments, LDFLAGS
should contain all non- -l arguments which get passed to ld(1),
CPPFLAGS should contain all items which need to get passed to cpp(1)
and cc(1), and CFLAGS should contain everything that needs to go
strictly to cc(1).
    So... -l arguments should _NEVER_ be put in CFLAGS.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
