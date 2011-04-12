Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q9WzM-0008NN-ID
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:22:12 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q9WzL-0006P1-Pt
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:22:12 +0000
Received: by pwj9 with SMTP id 9so3394995pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 23:22:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1302546720.2580.29.camel@doink>
References: <1302546720.2580.29.camel@doink>
Date: Mon, 11 Apr 2011 23:22:05 -0700
Message-ID: <BANLkTimqaMit_JMGLvDJFzsoJZMQhf0JSQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/3, v2] ltp: fix warnings in "fsstress.c"
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
To: aelder@sgi.com
Cc: ltp-list@lists.sourceforge.net

On Mon, Apr 11, 2011 at 11:32 AM, Alex Elder <aelder@sgi.com> wrote:
> Fix remaining warnings in "testcases/kernel/fs/fsstress/fsstress.c".
> Three of them are due to mismatches between fprintf() conversion
> specifications and the variables being formatted. =A0Fix these by
> casting the variables to the right type.
>
> Two others are due to the use of a __uint64_t local variable to
> represent a value of type __u64 (which evidently can be defined
> differently in some environments). =A0Fix these by using the exact
> matching type in the cases that produce the warning messages.
>
> Updated to address the concern raised by Garrett Cooper about the
> use of types that are not identical to what's used in the XFS
> ioctl() interface in the kernel. =A0Also added memset() calls so we're
> sure no garbage resides in data structures passed between user space
> and the kernel.

1. Please use sizeof() instead of bareword sizeof.
2. I'm not sure if this is necessarily LKML style (the code I've
sampled in the mainline kernel do this however), but casts don't
require spurious spaces in FreeBSD for instance, i.e.

    foo =3D (void*)bar;

instead of

    foo =3D (void*) bar;

Cheers,
-Garrett

---------------------------------------------------------------------------=
---
Forrester Wave Report - Recovery time is now measured in hours and minutes
not days. Key insights are discussed in the 2010 Forrester Wave Report as
part of an in-depth evaluation of disaster recovery service providers.
Forrester found the best-in-class provider in terms of services and vision.
Read this report now!  http://p.sf.net/sfu/ibm-webcastpromo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
