Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NX1Jy-00009b-Dc
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 23:47:46 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NX1Jx-0000f5-KN
	for ltp-list@lists.sourceforge.net; Mon, 18 Jan 2010 23:47:46 +0000
Received: by pwj11 with SMTP id 11so2261975pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Jan 2010 15:47:40 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 18 Jan 2010 15:47:39 -0800
Message-ID: <364299f41001181547y3ab0c634xf95002f4606d48a1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] pan build now independent of bison/flex [was Re: [PATCH] Add
	make 3.80 $(abspath ) and $(realpath ) emulation scripts]
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

2010/1/18 Garrett Cooper <yanegomi@gmail.com>:
> On Mon, Jan 18, 2010 at 2:08 PM, Mike Frysinger <vapier@gentoo.org> wrote:
>> On Monday 18 January 2010 16:58:58 K.D. Lucas wrote:
>>> Is there a bug when trying to make with version 3.81?
>>>
>>> I just tried compiling LTP 2009.1231 today, and I get:
>>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> configure: WARNING: linux/genetlink.h: present but cannot be compiled
>>> configure: WARNING: linux/genetlink.h: =A0 =A0 check for missing prereq=
uisite
>>> headers?
>>> configure: WARNING: linux/genetlink.h: see the Autoconf documentation
>>> configure: WARNING: linux/genetlink.h: =A0 =A0 section "Present But Can=
not Be
>>> Compiled"
>>> configure: WARNING: linux/genetlink.h: proceeding with the compiler's
>>
>> no output emitted by configure would be related to make. =A0these partic=
ular
>> errors are because your distro installs broken kernel headers.
>
> Kelly,
> =A0 =A0You're most likely missing flex + bison on the build host (I say
> that primarily because I don't see -lfl in the linker line). It's
> noted in INSTALL as a requirement, but isn't strictly enforced for pan
> today. I'll add a specific check for that in configure sometime in the
> next week or so, but the problem is that several tests need to be
> skipped if pan isn't available / built because they depend upon it
> (runltp invocation, selinux-testsuite, etc).
> Thanks,

    I just removed the dependency on bison/flex in pan/Makefile on CVS
head, as it was only required by ltp-scanner, an optional non-critical
utility.
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
