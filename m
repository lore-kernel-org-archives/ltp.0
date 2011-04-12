Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1Q9XDE-0000JN-Vi
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:36:32 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q9XDC-0004Xc-Mk
	for ltp-list@lists.sourceforge.net; Tue, 12 Apr 2011 06:36:32 +0000
Received: by pxi15 with SMTP id 15so3208332pxi.33
	for <ltp-list@lists.sourceforge.net>;
	Mon, 11 Apr 2011 23:36:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1302546710.2580.27.camel@doink>
References: <1302546710.2580.27.camel@doink>
Date: Mon, 11 Apr 2011 23:36:24 -0700
Message-ID: <BANLkTin6AZi22PbxzE=yg576a024P-eAsg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/3, v2] ltp: fix warnings in "aio-stress.c"
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

On Mon, Apr 11, 2011 at 11:31 AM, Alex Elder <aelder@sgi.com> wrote:
> In "testcases/kernel/io/ltp-aiodio/aio-stress.c" there are a
> number of warnings that show up due to mismatches between
> fprintf() conversion specifications and the variables being
> formatted.
>
> Fix most of these by casting the variables to the right type;
> in one case a "%td" is used to signify a ptrdiff_t variable.
>
> Updated to address comments made by Garrett Cooper in review.
> However, both "file_size" and "context_offset" variables represent
> file offsets, and therefore should remain type off_t (rather than
> size_t, which was recommended). =A0Some printf() formats were
> adjusted to use %ld/(long) for printing off_t values.

    Fine minus IO's -> I/O and space between cast values.
Thanks,
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
