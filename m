Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PFWei-0004CJ-Cy
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 18:41:24 +0000
Date: Mon, 8 Nov 2010 19:52:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101108185223.GB21681@saboteur.suse.cz>
References: <20101108175836.GA20774@saboteur.suse.cz>
	<AANLkTin1gbGLq=eoyBkLTycX-LxyNtUJQJv1jdnqdXtA@mail.gmail.com>
	<20101108182555.GA21681@saboteur.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101108182555.GA21681@saboteur.suse.cz>
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
> > > Following patch fixes obvious problems with cap_bounds compilation
> > >
> > > * CAP_LAST_CAP is defined in linux/capability.h =3D> include it
> > >
> > > * remove int errno; definition
> > >
> > > * move #ifdef HAVE_SYS_CAPABILITY_H after int main(int argc, char *ar=
gv[])
> > > =A0in check_pe.c
> > >
> > > * small typos and coding style
> > =

> > Hi Cyril!
> >     Quick question -- why doesn't sys/capability.h build on
> > linux/capability.h (in particular what OS did you run into this issue
> > on)?
> =

> You are right, the problem is that HAVE_SYS_CAPABILITY_H is not in
> config.h even when libcap-devel is installed and headers are found
> (there is only #define HAVE_LIBCAP 1).
> =


Hmm, adding sys/capability.h into AC_CHECK_HEADERS() in configure.ac
seem to fixed this. Still I have no idea why AC_CHECK_HEADER() in
m4/ltp-cap.m4 hasn't exported HAVE_SYS_CAPABILITY_H.

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
