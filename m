Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NX0jH-0005s7-KO
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 23:09:51 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NX0jG-0005SF-Q8
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 23:09:51 +0000
Received: by pxi38 with SMTP id 38so468081pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Jan 2010 15:09:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201001181708.24832.vapier@gentoo.org>
References: <364299f41001151349i4e7067fbu68994eaf719b46de@mail.gmail.com>
	<b9d696241001181358g6a9c212by27da3451e4c6d0c3@mail.gmail.com>
	<201001181708.24832.vapier@gentoo.org>
Date: Mon, 18 Jan 2010 15:09:45 -0800
Message-ID: <364299f41001181509k339dd976u4fa87729482495cb@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Add make 3.80 $(abspath ) and $(realpath )
	emulation scripts
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: =?ISO-2022-JP?B?GyRCP0BDK0p+SE8bKEI=?= <mitani@ryobi.co.jp>, Jiri Palecek <jirka@debian.org>, Andi Kleen <andi@firstfloor.org>, LTP list <ltp-list@lists.sourceforge.net>

On Mon, Jan 18, 2010 at 2:08 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Monday 18 January 2010 16:58:58 K.D. Lucas wrote:
>> Is there a bug when trying to make with version 3.81?
>>
>> I just tried compiling LTP 2009.1231 today, and I get:
>>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> configure: WARNING: linux/genetlink.h: present but cannot be compiled
>> configure: WARNING: linux/genetlink.h: =A0 =A0 check for missing prerequ=
isite
>> headers?
>> configure: WARNING: linux/genetlink.h: see the Autoconf documentation
>> configure: WARNING: linux/genetlink.h: =A0 =A0 section "Present But Cann=
ot Be
>> Compiled"
>> configure: WARNING: linux/genetlink.h: proceeding with the compiler's
>
> no output emitted by configure would be related to make. =A0these particu=
lar
> errors are because your distro installs broken kernel headers.

Kelly,
    You're most likely missing flex + bison on the build host (I say
that primarily because I don't see -lfl in the linker line). It's
noted in INSTALL as a requirement, but isn't strictly enforced for pan
today. I'll add a specific check for that in configure sometime in the
next week or so, but the problem is that several tests need to be
skipped if pan isn't available / built because they depend upon it
(runltp invocation, selinux-testsuite, etc).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
