Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RLf1f-00027K-FY
	for ltp-list@lists.sourceforge.net; Wed, 02 Nov 2011 17:54:59 +0000
Date: Wed, 2 Nov 2011 19:00:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111102180024.GB12153@saboteur.suse.cz>
References: <1320052884-11475-1-git-send-email-carmelo.amoroso@st.com>
	<20111102172631.GA14582@saboteur.suse.cz>
	<CAGH67wQu7Yx8=GMHxXWXsz=i9736jva89QNeobWku=0YJQwTQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGH67wQu7Yx8=GMHxXWXsz=i9736jva89QNeobWku=0YJQwTQQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH] runltp: fix printing of LTP Version
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
> >> Fix function 'version_of_ltp' to reference Version in the correct path
> >> Fix Version's path when settign version_date
> >>
> >> Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
> >> ---
> >> =A0runltp | =A0 =A04 ++--
> >> =A01 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/runltp b/runltp
> >> index 4ef8b38..244cd2f 100755
> >> --- a/runltp
> >> +++ b/runltp
> >> @@ -97,7 +97,7 @@ setup()
> >>
> >> =A0version_of_ltp()
> >> =A0{
> >> - =A0 =A0cat "$LTPROOT/Version"
> >> + =A0 =A0cat "$LTPROOT/testcases/bin/Version"
> >> =A0 =A0 =A0exit 0
> >> =A0}
> >>
> >> @@ -209,7 +209,7 @@ main()
> >>
> >> =A0 =A0 =A0local scenfile=3D
> >>
> >> - =A0 =A0version_date=3D$(cat "$LTPROOT/Version")
> >> + =A0 =A0version_date=3D$(cat "$LTPROOT/testcases/bin/Version")
> >>
> >> =A0 =A0 =A0while getopts a:c:C:d:D:f:F:ehi:K:g:l:m:M:Nno:pqr:s:S:t:T:w=
:x:b:B: arg
> >> =A0 =A0 =A0do =A0case $arg in
> >
> > Right, but there is one more thing to fix.
> >
> > The Version is generated from Changelog, which is abandoned for some
> > time. But we introduced a VERSION file that carries latest version. So
> > the best woul be to drop Changelog completly and use the VERSION file
> > instead, anybody objects to that?
> =

> I'd just generate the version like so:
> =

> VERSION ?=3D $(shell echo ltp-nightly-`env LANG=3DC date +%Y%m%d`)
> =

> in the Makefile, or something like that... I just did it based on the
> ChangeLog as it was the defacto source of truth in the LTP 'release
> process' (which fizzled after Subrata couldn't lead that effort
> anymore).

Now we have the VERSION file, that should defacto carry on that
information for the future. So there is no problem with that, changing
'head ChangeLog' to 'cat VERSION' should be enough. Maybe it would be
nice to use 'git describe' for builds from git repository too.

And we should probably get rid of the ChangeLog and result files, as
they are not maintained anymore, actually if somebody has time to
generate results I would be glad to include them, but I personally don't
have a time to do that.

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
RSA&#174; Conference 2012
Save $700 by Nov 18
Register now&#33;
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
