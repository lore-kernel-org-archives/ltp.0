Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PFXeQ-0000Dq-U4
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 19:45:10 +0000
Date: Mon, 8 Nov 2010 20:56:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101108195609.GA24484@saboteur.suse.cz>
References: <20101108175836.GA20774@saboteur.suse.cz>
	<AANLkTin1gbGLq=eoyBkLTycX-LxyNtUJQJv1jdnqdXtA@mail.gmail.com>
	<20101108182555.GA21681@saboteur.suse.cz>
	<20101108185223.GB21681@saboteur.suse.cz>
	<AANLkTin_Ufopsjacwr4+nMhLg-6UMtfPO0geeq5+-Y2W@mail.gmail.com>
	<20101108192524.GC21681@saboteur.suse.cz>
	<AANLkTinXqYi7iHTPyMCNOt=kHNeRKAS6btL8aVcj23Tk@mail.gmail.com>
	<20101108193240.GD21681@saboteur.suse.cz>
	<AANLkTinhaO2R8RwtCz3p28QGyRTAouBaCVSKsmMihh15@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTinhaO2R8RwtCz3p28QGyRTAouBaCVSKsmMihh15@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix obvious compilation problems in cap_bounds
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

Hi!
> >> >> >> > > Following patch fixes obvious problems with cap_bounds compi=
lation
> >> >> >> > >
> >> >> >> > > * CAP_LAST_CAP is defined in linux/capability.h =3D> include=
 it
> >> >> >> > >
> >> >> >> > > * remove int errno; definition
> >> >> >> > >
> >> >> >> > > * move #ifdef HAVE_SYS_CAPABILITY_H after int main(int argc,=
 char *argv[])
> >> >> >> > > =A0in check_pe.c
> >> >> >> > >
> >> >> >> > > * small typos and coding style
> >> >> >> >
> >> >> >> > Hi Cyril!
> >> >> >> > =A0 =A0 Quick question -- why doesn't sys/capability.h build on
> >> >> >> > linux/capability.h (in particular what OS did you run into thi=
s issue
> >> >> >> > on)?
> >> >> >>
> >> >> >> You are right, the problem is that HAVE_SYS_CAPABILITY_H is not =
in
> >> >> >> config.h even when libcap-devel is installed and headers are fou=
nd
> >> >> >> (there is only #define HAVE_LIBCAP 1).
> >> >> >>
> >> >> >
> >> >> > Hmm, adding sys/capability.h into AC_CHECK_HEADERS() in configure=
.ac
> >> >> > seem to fixed this. Still I have no idea why AC_CHECK_HEADER() in
> >> >> > m4/ltp-cap.m4 hasn't exported HAVE_SYS_CAPABILITY_H.
> >> >>
> >> >> =A0 =A0 Probably because I forgot to remove the square brackets; gi=
ve the
> >> >> patch attached a shot and let me know how it goes...
> >> >
> >> > Nope, it looks like AC_CHECK_HEADER() does not set HAVE_* at all(1).=
 =A0So
> >> > we need to change AC_HECK_HEADER() to AC_CHECK_HEADERS() in
> >> > m4/ltp-cap.m4.
> >>
> >> =A0 =A0 That's kind of lame :/... Could you try this patch instead ple=
ase?
> >
> > Yes, this works regardless if there are square braces around
> > sys/capability.h or not.
> =


Do you want me to create new patch (for the original issue) without
#include <linux/capability.h>?

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
