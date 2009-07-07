Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MO1Qn-0005mF-D4
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 03:33:21 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MO1Qi-0006zw-Ay
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 03:33:21 +0000
Received: by pzk8 with SMTP id 8so4255025pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 06 Jul 2009 20:33:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090707021215.GC32310@count0.beaverton.ibm.com>
References: <364299f40907061818q7cda3465vffb00323af18c5f8@mail.gmail.com>
	<20090707021215.GC32310@count0.beaverton.ibm.com>
Date: Mon, 6 Jul 2009 20:33:14 -0700
Message-ID: <364299f40907062033j1660f689t65b8b8bdfb402f11@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 4/4] Make makefiles more autoconf friendly
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
To: Matt Helsley <matthltc@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Mon, Jul 6, 2009 at 7:12 PM, Matt Helsley<matthltc@us.ibm.com> wrote:
> (Reviewing inline patches is much easier..)

Ok. I didn't know what the procedure was for submitting patches to the
group, because it doesn't mention it in the DCO, but I'll do that next
round.

> Most of this looks good to me.
>
> Introducing include/mk seems like a very good idea -- incredible numbers =
of
> Makefiles could be factored into common includes there. It would
> probably make maintenance of the LTP Makefiles alot easier in the long
> run.

Bingo sir ;)! That's why I was asking whether or not I could do away
with subdir makes -- it would make life for me as a developer a lot
easier, because we have to backtrack with subdir ?=3D [...] in the
Makefiles and could just use -I/path/to/srcdir . If we were using a
wrapper script, like bash, perl, or python, etc then we could _easily_
get away with having to deal with the srcdir stuff because we could
walk up the tree, but I'd rather not go that route :\...

> On Mon, Jul 06, 2009 at 06:18:10PM -0700, Garrett Cooper wrote:
>> 1. Many Makefiles have hardcoded /opt/ltp paths in them. Let's make
>> things more modular by making sure the files either get parsed by
>> autoconf with configure, or instead of having the hardcoded path,
>> include include/mk/config.mk (which is in and of itself a configure'd
>> file), thus ensuring feature parity in all of our Makefiles.
>> 2. These files also contain various cleanup items with other vars and
>> rules conforming to the Draft 1 spec of master_rules.mk.
>>
>> This requires PATCH 2/4 and PATCH 3/4.
>>
>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

[...]

> Shouldn't the old files be left as defaults so we don't need to run
> autotools to get a working make/install?
>
> <snip>

Sure. I could do that with a large chunk of the generated files, but I
was just trying to avoid it as much as possible.

>> Index: include/mk/config.mk.in
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> RCS file: include/mk/config.mk.in
>> diff -N include/mk/config.mk.in
>> --- /dev/null 1 Jan 1970 00:00:00 -0000
>> +++ include/mk/config.mk.in =A0 7 Jul 2009 01:15:48 -0000
>> @@ -0,0 +1,61 @@
>> +#
>> +# =A0 =A0config.mk.in.
>> +#
>> +# =A0 =A0Copyright (C) 2009, Cisco Systems Inc.
>> +#
>> +# =A0 =A0This program is free software; you can redistribute it and/or =
modify
>> +# =A0 =A0it under the terms of the GNU General Public License as publis=
hed by
>> +# =A0 =A0the Free Software Foundation; either version 2 of the License,=
 or
>> +# =A0 =A0(at your option) any later version.
>> +#
>> +# =A0 =A0This program is distributed in the hope that it will be useful,
>> +# =A0 =A0but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# =A0 =A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> +# =A0 =A0GNU General Public License for more details.
>> +#
>> +# =A0 =A0You should have received a copy of the GNU General Public Lice=
nse along
>> +# =A0 =A0with this program; if not, write to the Free Software Foundati=
on, Inc.,
>> +# =A0 =A051 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> +#
>> +# Garrett Cooper, July 2009
>> +#
>> +# Copyright (c) 2009 by Cisco Systems, Inc.
>> +# All rights reserved
>> +#
>> +
>> +AR =A0 =A0 =A0 =A0 =A0 =3D @AR@
>> +CC =A0 =A0 =A0 =A0 =A0 =3D @CC@
>> +RANLIB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D @RANLIB@
>> +
>> +# Avoid overwriting definitions in leaf callers.
>> +CPPFLAGS =A0 =A0 ?=3D @CPPFLAGS@
>> +CFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D @CFLAGS@
>> +LDLIBS =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D @LIBS@
>> +LDFLAGS =A0 =A0 =A0 =A0 =A0 =A0 =A0?=3D @LDFLAGS@
>> +
>> +AIO_LIBS =A0 =A0 =3D @AIO_LIBS@
>> +CRYPTO_LIB =A0 =3D @CRYPTO_LIB@
>> +SELINUX_LIBS =3D @SELINUX_LIBS@
>> +
>> +RPMBUILD =A0 =A0 ?=3D rpmbuild
>> +
>> +prefix =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D @prefix@
>
> I think you should set PREFIX too. Most Makefiles that honored prefix at
> all expected that variable name. Perhaps it would be best to start with
> that and then, if it's best, gradually change all the Makefiles?

Sure -- will add that then too :).

>> +
>> +#
>> +# Default to /opt/ltp if the directory specified was a zero-length stri=
ng, to
>> +# avoid spurious Make system errors.
>> +#
>> +# XXX (garrcoop): I'm almost positive there's a better way to do this in
>> +# autoconf. Haven't figured it out yet...
>> +#
>> +ifeq ($(strip $(prefix)),)
>> +prefix =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D /opt/ltp
>> +endif
>
> I thought the point was not having to run autoconf to get the default
> build and install via Makefiles.

Yeah, I thought about it and wondered to myself -- how many folks are
there out there that actually handcraft config.h and config.mk files.
Probably not that many folks to be honest...

>> +
>> +datarootdir =A0=3D @datarootdir@
>> +includedir =A0 =3D @includedir@
>> +mandir =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D @mandir@
>> +
>> +#export AR CC CFLAGS CPPFLAGS LDLIBS LDFLAGS RANLIB
>> +export AR CC CPPFLAGS LDLIBS LDFLAGS RANLIB
>
> Perhaps now is a good time to delete the commented-out export line?

Yeah, silly me -- forgot about that =3D].

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have =

the opportunity to enter the BlackBerry Developer Challenge. See full prize =

details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
