Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vishwa.hochihally@gmail.com>) id 1OTAFP-0008VJ-4z
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 09:03:23 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OTAFK-0007cU-8B
	for ltp-list@lists.sourceforge.net; Mon, 28 Jun 2010 09:03:23 +0000
Received: by pwi10 with SMTP id 10so1210981pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 Jun 2010 02:03:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimZ-GQtuu-_1pB_Llzrr46CE0EbEFnd_OnjnjmF@mail.gmail.com>
References: <AANLkTilncmIFzbwnHMEJKXsJagIMP9mSicqIZ5dQelLJ@mail.gmail.com>
	<AANLkTimZ-GQtuu-_1pB_Llzrr46CE0EbEFnd_OnjnjmF@mail.gmail.com>
Date: Mon, 28 Jun 2010 14:33:12 +0530
Message-ID: <AANLkTim0JhFpvTVlo-DMkhjdWzcuf1ob3nUWpkK-vT9y@mail.gmail.com>
From: vishwanath govind <vishwa.hochihally@gmail.com>
Subject: Re: [LTP] Not cloning all the files from ltp-dev
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4335488451111144990=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============4335488451111144990==
Content-Type: multipart/alternative; boundary=0016e64afa46ea969c048a136356

--0016e64afa46ea969c048a136356
Content-Type: text/plain; charset=ISO-8859-1

Thanks Garrett.
Regards
Vishwa

On Mon, Jun 28, 2010 at 1:22 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

>  On Mon, Jun 28, 2010 at 12:28 AM, vishwanath govind
> <vishwa.hochihally@gmail.com> wrote:
> > Hi,
> >  I have tried to clone the latest LTP source through GIT but missing
> > "configure" file in it.
> >
> > Here are my steps:
> >
> >   # git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp
> >
> >  # ls ltp
> > COPYING  ChangeLog   INSTALL   Makefile.release  README.ltp-devel.in<http://readme.ltp-devel.in/>
> > TODO          doc         include  ltp-devel.spec.in  m4   result
> > runltp         runtest  testcases    tools  ver_linux
> > CREDITS  IDcheck.sh  Makefile  README            README.mk-devel
> > configure.ac  execltp.in  lib      ltpmenu            pan
> runalltests.sh
> > runltplite.sh  scripts  testscripts  utils
> > Why is "configure" file is missing here?
> >
> > Please let me know your thoughts?
>
> configure should never be checked in to git.
>
> Read INSTALL for more details on how to generate it.
>
> Thanks,
> -Garrett
>

--0016e64afa46ea969c048a136356
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Thanks Garrett. </div>
<div>Regards</div>
<div>Vishwa<br><br></div>
<div class=3D"gmail_quote">On Mon, Jun 28, 2010 at 1:22 PM, Garrett Cooper =
<span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.=
com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On Mon, Jun 28, 2010 at 12:28 AM, vishwanath govind<br>&l=
t;<a href=3D"mailto:vishwa.hochihally@gmail.com">vishwa.hochihally@gmail.co=
m</a>&gt; wrote:<br>&gt; Hi,<br>&gt; =A0I have tried=A0to clone the latest =
LTP source through GIT but missing<br>
&gt; &quot;configure&quot; file in it.<br>&gt;<br>&gt; Here are my steps:<b=
r>&gt;<br>&gt; =A0 # git://<a href=3D"http://ltp.git.sourceforge.net/gitroo=
t/ltp/ltp-dev.git" target=3D"_blank">ltp.git.sourceforge.net/gitroot/ltp/lt=
p-dev.git</a> ltp<br>
&gt;<br>&gt; =A0# ls ltp<br>&gt; COPYING=A0 ChangeLog=A0=A0 INSTALL=A0=A0 M=
akefile.release=A0 <a href=3D"http://readme.ltp-devel.in/" target=3D"_blank=
">README.ltp-devel.in</a><br>&gt; TODO=A0=A0=A0=A0=A0=A0=A0=A0=A0 doc=A0=A0=
=A0=A0=A0=A0=A0=A0 include=A0 <a href=3D"http://ltp-devel.spec.in/" target=
=3D"_blank">ltp-devel.spec.in</a>=A0 m4=A0=A0 result<br>
&gt; runltp=A0=A0=A0=A0=A0=A0=A0=A0 runtest=A0 testcases=A0=A0=A0 tools=A0 =
ver_linux<br>&gt; CREDITS=A0 IDcheck.sh=A0 Makefile=A0 README=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 README.mk-devel<br>&gt; <a href=3D"http://configure.a=
c/" target=3D"_blank">configure.ac</a>=A0 <a href=3D"http://execltp.in/" ta=
rget=3D"_blank">execltp.in</a>=A0 lib=A0=A0=A0=A0=A0 ltpmenu=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 pan=A0 runalltests.sh<br>
&gt; runltplite.sh=A0 scripts=A0 testscripts=A0 utils<br>&gt; Why is &quot;=
configure&quot; file is missing here?<br>&gt;<br>&gt; Please let me know yo=
ur thoughts?<br><br></div></div>configure should never be checked in to git=
.<br>
<br>Read INSTALL for more details on how to generate it.<br><br>Thanks,<br>=
<font color=3D"#888888">-Garrett<br></font></blockquote></div><br>

--0016e64afa46ea969c048a136356--


--===============4335488451111144990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============4335488451111144990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4335488451111144990==--

