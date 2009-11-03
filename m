Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1N5QWJ-0001f1-2x
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 21:02:27 +0000
Received: from mail-px0-f179.google.com ([209.85.216.179])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5QWC-00010u-OU
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 21:02:27 +0000
Received: by pxi9 with SMTP id 9so4152554pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Nov 2009 13:02:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200911031533.53910.vapier@gentoo.org>
References: <b9d696240911031223h6734d911s57830e7d859813f9@mail.gmail.com>
	<200911031533.53910.vapier@gentoo.org>
Date: Tue, 3 Nov 2009 13:02:14 -0800
Message-ID: <b9d696240911031302v7ac8fb27jdf53c159c2ac95f9@mail.gmail.com>
From: "K.D. Lucas" <kdlucas@gmail.com>
Subject: Re: [LTP] 20091031 won't run
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2970062890922368486=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

--===============2970062890922368486==
Content-Type: multipart/alternative; boundary=000e0cd185b80949ab04777dcff3

--000e0cd185b80949ab04777dcff3
Content-Type: text/plain; charset=ISO-8859-1

I tried to execute runltp as root.
So in the past I've always extracted and built it in
/var/tmp/<username>/ltp-full-<version>/
and I don't think it ever tried to write to /opt/ltp. So this seems like a
change in behavior.

kdl

On Tue, Nov 3, 2009 at 12:33 PM, Mike Frysinger <vapier@gentoo.org> wrote:

> On Tuesday 03 November 2009 15:23:47 K.D. Lucas wrote:
> > I downloaded the latest LTP, which is version 20091031. I ran
> ./configure,
> > make, and make install. I notice that now make tries to write file to
> > /opt/ltp/, so I needed to run make as root.
>
> ltp installs to wherever you configured and installed it to.  the default
> is
> merely /opt/ltp/.  so if you didnt change the default, then it's up to you
> to
> make sure the install location is available.
>
> > When I go to run ltp, I get:
> >
> > FATAL: Test suite not installed correctly
> > INFO: as root user type 'make ; make install'
>
> what user did you run `ltp` as ?
> -mike
>



-- 
K.D. Lucas
kdlucas@gmail.com

--000e0cd185b80949ab04777dcff3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I tried to execute runltp as root.</div><div>So in the past I&#39;ve a=
lways extracted and built it in /var/tmp/&lt;username&gt;/ltp-full-&lt;vers=
ion&gt;/</div><div>and I don&#39;t think it ever tried to write to /opt/ltp=
. So this seems like a change in behavior.</div>
<div><br></div><div>kdl</div><br><div class=3D"gmail_quote">On Tue, Nov 3, =
2009 at 12:33 PM, Mike Frysinger <span dir=3D"ltr">&lt;<a href=3D"mailto:va=
pier@gentoo.org">vapier@gentoo.org</a>&gt;</span> wrote:<br><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex;">
<div class=3D"im">On Tuesday 03 November 2009 15:23:47 K.D. Lucas wrote:<br=
>
&gt; I downloaded the latest LTP, which is version 20091031. I ran ./config=
ure,<br>
&gt; make, and make install. I notice that now make tries to write file to<=
br>
&gt; /opt/ltp/, so I needed to run make as root.<br>
<br>
</div>ltp installs to wherever you configured and installed it to. =A0the d=
efault is<br>
merely /opt/ltp/. =A0so if you didnt change the default, then it&#39;s up t=
o you to<br>
make sure the install location is available.<br>
<div class=3D"im"><br>
&gt; When I go to run ltp, I get:<br>
&gt;<br>
&gt; FATAL: Test suite not installed correctly<br>
&gt; INFO: as root user type &#39;make ; make install&#39;<br>
<br>
</div>what user did you run `ltp` as ?<br>
<font color=3D"#888888">-mike<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>K.D. Lucas<br><a=
 href=3D"mailto:kdlucas@gmail.com">kdlucas@gmail.com</a><br>

--000e0cd185b80949ab04777dcff3--


--===============2970062890922368486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============2970062890922368486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2970062890922368486==--

