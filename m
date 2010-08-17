Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OlSS8-0006sH-TQ
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:08:08 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSS8-00088J-2H
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:08:08 +0000
Received: by fxm6 with SMTP id 6so4752291fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 13:08:02 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 17 Aug 2010 16:08:02 -0400
Message-ID: <AANLkTik=eFF+crCzH5o55YwVp+wNUZttg=wqZwE-WiEp@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Subject: [LTP] weird indentation in INSTALL
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

i'm looking at the top level INSTALL and cannot figure out what is
going on with the whitespace usage in indenting things.  is it just a
matter of people are using tab stops of 8 spaces and thus dont notice
the random mix of spaces and tabs ?

specifically ("=B7" is a space while "=BB" is a tab):
Using=B7autoconf:
=B7=B7=B7=B7=B7=B7=B7=B7$=B7make=B7autotools=B7#=B7This=B7must=B7be=B7run=
=B7from=B7"$TOP_SRCDIR"!
=BB   $=B7test=B7-d=B7"$TOP_BUILDDIR"=B7||=B7mkdir=B7-p=B7"$TOP_BUILDDIR"
=B7=B7=B7=B7=B7=B7=B7=B7$=B7cd=B7"$TOP_BUILDDIR"=B7&&=B7"$TOP_SRCDIR/config=
ure"=B7\
=BB   =B7=B7#=B7[configure=B7args=B7go=B7here,=B7e.g.=B7CC=3D$CC,=B7LDFLAGS=
=3D$LDFLAGS,=B7etc]

Not=B7using=B7autoconf:

=BB   $=B7test=B7-d=B7"$TOP_BUILDDIR"=B7||=B7mkdir=B7-p=B7"$TOP_BUILDDIR"
=B7=B7=B7=B7=B7=B7=B7=B7$=B7cp=B7"$TOP_SRCDIR/include/config.h.default"=B7\
=BB   =B7=B7=B7=B7=B7"$TOP_BUILDDIR/include/config.h"
=B7=B7=B7=B7=B7=B7=B7=B7$=B7cp=B7"$TOP_SRCDIR/include/mk/config.mk.default"=
=B7\
=BB   =B7=B7=B7=B7=B7"$TOP_BUILDDIR/include/mk/config.mk"

=B7=B7=B7=B7=B7=B7=B7=B7#=B7Fire=B7up=B7your=B7favorite=B7editor=B7and=B7se=
t=B7each=B7value=B7appropriately=B7in
=B7=B7=B7=B7=B7=B7=B7=B7#=B7include/mk/config.mk.=B7Uncomment=B7all=B7value=
s=B7commented=B7out,=B7such=B7as
=BB   #=B7NUMA_LIBS,=B7etc,=B7but=B7only=B7if=B7you're=B7sure=B7that=B7the=
=B7libraries=B7exist=B7and
=BB   #=B7can=B7be=B7linked=B7on=B7your=B7system.
.......
=B7=B7=B7=B7=B7=B7=B7=B7$=B7make=B7all
=B7=B7=B7=B7=B7=B7=B7=B7$=B7make=B7\
=BB   =B7=B7"DESTDIR=3D$SYSROOT"=B7\
=BB   =B7=B7SKIP_IDCHECK=3D[0|1]=B7\
=BB   =B7=B7install
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
