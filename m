Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1Olikk-0000si-Tp
	for ltp-list@lists.sourceforge.net; Wed, 18 Aug 2010 13:32:26 +0000
Date: Wed, 18 Aug 2010 15:50:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100818135008.GB475@saboteur.suse.cz>
References: <20100805100954.GB11402@saboteur.suse.cz>
	<20100805135324.GB18296@saboteur.suse.cz>
	<D150E027-5380-4B94-A64C-3FD7C8146334@gmail.com>
	<201008051157.26183.vapier@gentoo.org>
	<AANLkTikZrHrFS6NiS+JXyThPjti0JqaJ5kYSdkeQh1xH@mail.gmail.com>
	<AANLkTi=zBqte75f6=2meSrtrv+mYbSbag7udZcR2jR-n@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=zBqte75f6=2meSrtrv+mYbSbag7udZcR2jR-n@mail.gmail.com>
Subject: Re: [LTP] just another make-3.80 bug
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
Cc: LTP list <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> > diff --git a/include/mk/env_pre.mk b/include/mk/env_pre.mk
> > index 4444124..17a91fa 100644
> > --- a/include/mk/env_pre.mk
> > +++ b/include/mk/env_pre.mk
> > @@ -124,8 +124,13 @@ BUILD_TREE_STATE =A0 =A0 =A0 =A0 =A0 :=3D $(BUILD_=
TREE_NONSRCDIR_INSTAL
> > =A0endif
> > =A0endif
> >
> > -# make 3.80 called it .DEFAULT_TARGET.
> > +ifeq ($(MAKE_3_80_COMPAT),1
> > +# Trick make 3.80 into thinking that the default goal is all.
> > +.PHONY: default
> > +default: all
> > +else
> > =A0.DEFAULT_GOAL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D all
> > +endif
> >
> > =A0endif =A0# END autotools, *clean...
> =

>     I committed the patch to HEAD. Let me know whether or not it
> works; it might not work because `include' creates a pseudo target,
> but please let me know if it works or not.

You are missing ) at the end of ifeq line, but otherwise seems to work
fine. I'll check once more when the compilation finishes.

-- =

Cyril Hrubis
chrubis@suse.cz

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
