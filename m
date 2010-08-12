Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OjQXT-0000lf-MS
	for ltp-list@lists.sourceforge.net; Thu, 12 Aug 2010 05:41:15 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OjQXS-0002Na-Ol
	for ltp-list@lists.sourceforge.net; Thu, 12 Aug 2010 05:41:15 +0000
Received: by bwz8 with SMTP id 8so842169bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 11 Aug 2010 22:41:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000301cb38f5$a5992050$f0cb60f0$@co.jp>
References: <000301cb38f5$a5992050$f0cb60f0$@co.jp>
Date: Wed, 11 Aug 2010 22:41:08 -0700
Message-ID: <AANLkTimX003iAzr5XJtOoeRrLdV_Vpy8oe0mg=kA_fj5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "8-3-buildonly"
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
Cc: ltp-list@lists.sourceforge.net, =?Big5?B?t+2ueSCwt6Wr?= <toza@ryobi.co.jp>

2010/8/10 Mitani <mitani@ryobi.co.jp>:
> Hi,
>
> I tried to build open_posix_testsuite testcases with latest git:
> =A0 ltp-dev-7c67a09a10268b5f9f503e0254f1f0f9f5ac2b69.tar.gz
>
> Several testcases failed to build.
> One of them is as follows:
> ------------
> [...]
> conformance/definitions/sched_h/8-3-buildonly compile FAILED
> ../../../conformance/definitions/sched_h/8-3-buildonly.c:24:2: error: #er=
ror
> SCHED_SPORADIC not defined
> [...]
> ------------
>
>
> "8-3-buildonly.c" outputs "SCHED_SPORADIC not defined" message by
> condition:
>
> ------------(8-3-buildonly.c)
> [...]
> #include <sched.h>
> #include <unistd.h>
>
> #if (defined(_POSIX_SPORADIC_SERVER) && _POSIX_SPORADIC_SERVER !=3D -1) \
> =A0 =A0|| (defined(_POSIX_THREAD_SPORADIC_SERVER) && \
> =A0 =A0 =A0 =A0POSIX_THREAD_SPORADIC_SERVER !=3D -1)
>
> #ifndef SCHED_SPORADIC
> #error SCHED_SPORADIC not defined
> #endif
>
> #endif
> ------------
>
> I noticed that "POSIX_THREAD_SPORADIC_SERVER" parameter has not "_"
> in its top.
>
>
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ---
> a/testcases/open_posix_testsuite/conformance/definitions/sched_h/8-3-buil=
don
> ly.c =A0 =A02010-08-05 22:28:15.000000000 +0900
> +++
> b/testcases/open_posix_testsuite/conformance/definitions/sched_h/8-3-buil=
don
> ly.c =A0 =A02010-08-11 10:22:24.000000000 +0900
> @@ -18,7 +18,7 @@
>
> =A0#if (defined(_POSIX_SPORADIC_SERVER) && _POSIX_SPORADIC_SERVER !=3D -1=
) \
> =A0 =A0 || (defined(_POSIX_THREAD_SPORADIC_SERVER) && \
> - =A0 =A0 =A0 POSIX_THREAD_SPORADIC_SERVER !=3D -1)
> + =A0 =A0 =A0 _POSIX_THREAD_SPORADIC_SERVER !=3D -1)
>
> =A0#ifndef SCHED_SPORADIC
> =A0#error SCHED_SPORADIC not defined
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> After applying above patch, "8-3-buildonly.c" succeeded to build.

Committed -- thanks!
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
