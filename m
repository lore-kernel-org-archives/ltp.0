Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OllrI-0001A7-0O
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 16:51:24 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OllrH-0001yJ-1l
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 16:51:23 +0000
Received: by fxm6 with SMTP id 6so526278fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Aug 2010 09:51:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001cb3ea4$e05de680$a119b380$@co.jp>
References: <000001cb3ea4$e05de680$a119b380$@co.jp>
Date: Wed, 18 Aug 2010 12:51:17 -0400
Message-ID: <AANLkTi=RQf6pxYZu-RcYnK1kmusfX1urSseBc97qW3Gs@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] fix two "2-1.c" tests of POSIX
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

2010/8/18 Mitani:
> =A0* =A0 =A0 =A0 provided by nptl, which is developed by Ulrich Drepper.
> =A0*/
>
> -#ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> -#endif
> =A0#include <pthread.h>
> =A0#include <limits.h>
> =A0#include <stdio.h>
> @@ -30,6 +27,10 @@
> =A0#include <unistd.h>
> =A0#include "posixtest.h"
>
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif

defining any _XXX_SOURCE after including any C library headers is
pointless as they are checked in C library headers
-mike

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
