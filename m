Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OlT9t-0004sM-GQ
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:53:21 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlT9s-0004PV-Iz
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:53:21 +0000
Received: by bwz12 with SMTP id 12so4141621bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 13:53:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTik=eFF+crCzH5o55YwVp+wNUZttg=wqZwE-WiEp@mail.gmail.com>
References: <AANLkTik=eFF+crCzH5o55YwVp+wNUZttg=wqZwE-WiEp@mail.gmail.com>
Date: Tue, 17 Aug 2010 13:52:56 -0700
Message-ID: <AANLkTi=4wLOh2=_MOmr1=wKC1569AjvAMrA2BTYVbju1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] weird indentation in INSTALL
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
Cc: ltp-list@lists.sourceforge.net

On Tue, Aug 17, 2010 at 1:08 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> i'm looking at the top level INSTALL and cannot figure out what is
> going on with the whitespace usage in indenting things. =A0is it just a
> matter of people are using tab stops of 8 spaces and thus dont notice
> the random mix of spaces and tabs ?
>
> specifically ("=B7" is a space while "=BB" is a tab):
> Using=B7autoconf:
> =B7=B7=B7=B7=B7=B7=B7=B7$=B7make=B7autotools=B7#=B7This=B7must=B7be=B7run=
=B7from=B7"$TOP_SRCDIR"!
> =BB =A0 $=B7test=B7-d=B7"$TOP_BUILDDIR"=B7||=B7mkdir=B7-p=B7"$TOP_BUILDDI=
R"
> =B7=B7=B7=B7=B7=B7=B7=B7$=B7cd=B7"$TOP_BUILDDIR"=B7&&=B7"$TOP_SRCDIR/conf=
igure"=B7\
> =BB =A0 =B7=B7#=B7[configure=B7args=B7go=B7here,=B7e.g.=B7CC=3D$CC,=B7LDF=
LAGS=3D$LDFLAGS,=B7etc]
>
> Not=B7using=B7autoconf:
>
> =BB =A0 $=B7test=B7-d=B7"$TOP_BUILDDIR"=B7||=B7mkdir=B7-p=B7"$TOP_BUILDDI=
R"
> =B7=B7=B7=B7=B7=B7=B7=B7$=B7cp=B7"$TOP_SRCDIR/include/config.h.default"=
=B7\
> =BB =A0 =B7=B7=B7=B7=B7"$TOP_BUILDDIR/include/config.h"
> =B7=B7=B7=B7=B7=B7=B7=B7$=B7cp=B7"$TOP_SRCDIR/include/mk/config.mk.defaul=
t"=B7\
> =BB =A0 =B7=B7=B7=B7=B7"$TOP_BUILDDIR/include/mk/config.mk"
>
> =B7=B7=B7=B7=B7=B7=B7=B7#=B7Fire=B7up=B7your=B7favorite=B7editor=B7and=B7=
set=B7each=B7value=B7appropriately=B7in
> =B7=B7=B7=B7=B7=B7=B7=B7#=B7include/mk/config.mk.=B7Uncomment=B7all=B7val=
ues=B7commented=B7out,=B7such=B7as
> =BB =A0 #=B7NUMA_LIBS,=B7etc,=B7but=B7only=B7if=B7you're=B7sure=B7that=B7=
the=B7libraries=B7exist=B7and
> =BB =A0 #=B7can=B7be=B7linked=B7on=B7your=B7system.
> .......
> =B7=B7=B7=B7=B7=B7=B7=B7$=B7make=B7all
> =B7=B7=B7=B7=B7=B7=B7=B7$=B7make=B7\
> =BB =A0 =B7=B7"DESTDIR=3D$SYSROOT"=B7\
> =BB =A0 =B7=B7SKIP_IDCHECK=3D[0|1]=B7\
> =BB =A0 =B7=B7install

At one time or another, it might be because I used autoindent in vim
without setting :paste, or it might have been because I copy pasted
stuff, or used yy-p ... I don't know right offhand. I'll clean up the
directions though later on.

Thanks!
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
