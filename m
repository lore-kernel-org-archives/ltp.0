Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PB4Gw-0003Lh-TI
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:34:26 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB4Gr-0007yh-GV
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:34:26 +0000
Received: by wya21 with SMTP id 21so571156wya.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 04:34:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimEXJFo6vDOxKb_Q=_F92Rcr_xU289N18M6khVu@mail.gmail.com>
References: <AANLkTimEXJFo6vDOxKb_Q=_F92Rcr_xU289N18M6khVu@mail.gmail.com>
Date: Wed, 27 Oct 2010 04:34:14 -0700
Message-ID: <AANLkTimC09CBkscKJvpFTRhs2GuXc0MwiV9GLLVZEb5p@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Shell usage on embedded targets
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
To: David Peverley <pev@sketchymonkey.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Oct 27, 2010 at 4:24 AM, David Peverley <pev@sketchymonkey.com> wro=
te:
> Hi all,
>
> In our embedded rootfs we have both /bin/sh provided by busybox (i.e.
> a true sh) and also a /bin/bash compiled from bash.

    busybox sh is based off ash (which forked off BSD's /bin/sh,
IIRC), but it looks like they stripped away a lot of effective
features in /bin/sh, in an effort to try and trim down the size of the
rootfs. Pity, because it cripples the shell interpreter.
    Who knows if they've been trying to import bugfixes or make it
POSIX compliant either.

> This causes a pain as typically full systems use a symlink from sh to
> bash.

   Actually it's hardlinked in proper configurations that I've run
into. Symlinking allows for naughtiness.

> This breaks runltp (and probably other scritps) as they use
> getopts which I *think* is technically a bash-only builtin?

   Wrong. It's a POSIX shell built-in:
http://www.opengroup.org/onlinepubs/009695399/utilities/getopts.html .

> I've currently re-written the hashbangs before copying to the system. For
> those googling I did :
> =A0 find . -type f | xargs perl -pi -e 's/bin\/sh/bin\/bash/g'
>
> I can't get my head around what a 'neat' solution would be other than
> rewriting all to bash but I'm guessing that isn't a favoured choice
> for most people? I would expect a fair response would be "don't do odd
> things with your target" ;-)

   Or maybe you should just hardlink /bin/bash to /bin/sh like most
Linux targets (or spoof a non-Busybox based environment with a
chrooted env with /bin/bash setup as /bin/sh)? This isn't ideal, but
unless you have access to a /bin/sh that's can do POSIX compliant
shell constructs you're kind of SoL with LTP.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
