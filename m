Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kdlucas@gmail.com>) id 1N5RB9-00015S-Vn
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 21:44:39 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N5RB0-0006f0-S3
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 21:44:39 +0000
Received: by pwj6 with SMTP id 6so2885741pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Nov 2009 13:44:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200911031619.18266.vapier@gentoo.org>
References: <b9d696240911031223h6734d911s57830e7d859813f9@mail.gmail.com>
	<200911031533.53910.vapier@gentoo.org>
	<b9d696240911031302v7ac8fb27jdf53c159c2ac95f9@mail.gmail.com>
	<200911031619.18266.vapier@gentoo.org>
Date: Tue, 3 Nov 2009 13:44:25 -0800
Message-ID: <b9d696240911031344n3946572ahf75471061ab874e@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============7347414008455169894=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

--===============7347414008455169894==
Content-Type: multipart/alternative; boundary=000e0cd23a82dc353f04777e656e

--000e0cd23a82dc353f04777e656e
Content-Type: text/plain; charset=ISO-8859-1

So I see it did install in /opt/ltp and runs fine from there. I've been
running LTP approximately once per day since 2005 and this is the first time
it's ever installed in /opt/ltp. The last version I ran was 20090731.

I'll modify it to do what I want.

kdl

On Tue, Nov 3, 2009 at 1:19 PM, Mike Frysinger <vapier@gentoo.org> wrote:

> On Tuesday 03 November 2009 16:02:14 K.D. Lucas wrote:
> > I tried to execute runltp as root.
> > So in the past I've always extracted and built it in
> > /var/tmp/<username>/ltp-full-<version>/
> > and I don't think it ever tried to write to /opt/ltp. So this seems like
> a
> > change in behavior.
>
> you said you did `make install`.  it needs to install somewhere and
> /opt/ltp
> is that somewhere.  maybe this behavior has changed, maybe it hasnt.  all
> that
> really matters is that ltp now behaves like a standard configure && make
> package.  if you dont like the default of /opt/ltp, then it's up to you to
> select a place you do like.
> -mike
>



-- 
K.D. Lucas
kdlucas@gmail.com

--000e0cd23a82dc353f04777e656e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

So I see it did install in /opt/ltp and runs fine from there. I&#39;ve been=
 running LTP approximately once per day since 2005 and this is the first ti=
me it&#39;s ever installed in /opt/ltp. The last version I ran was 20090731=
.<div>
<br></div><div>I&#39;ll modify it to do what I want.</div><div><br></div><d=
iv>kdl<br><br><div class=3D"gmail_quote">On Tue, Nov 3, 2009 at 1:19 PM, Mi=
ke Frysinger <span dir=3D"ltr">&lt;<a href=3D"mailto:vapier@gentoo.org">vap=
ier@gentoo.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div class=3D"im">On Tuesday 03 November 20=
09 16:02:14 K.D. Lucas wrote:<br>
&gt; I tried to execute runltp as root.<br>
&gt; So in the past I&#39;ve always extracted and built it in<br>
&gt; /var/tmp/&lt;username&gt;/ltp-full-&lt;version&gt;/<br>
&gt; and I don&#39;t think it ever tried to write to /opt/ltp. So this seem=
s like a<br>
&gt; change in behavior.<br>
<br>
</div>you said you did `make install`. =A0it needs to install somewhere and=
 /opt/ltp<br>
is that somewhere. =A0maybe this behavior has changed, maybe it hasnt. =A0a=
ll that<br>
really matters is that ltp now behaves like a standard configure &amp;&amp;=
 make<br>
package. =A0if you dont like the default of /opt/ltp, then it&#39;s up to y=
ou to<br>
select a place you do like.<br>
<font color=3D"#888888">-mike<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>K.D. Lucas<br><a=
 href=3D"mailto:kdlucas@gmail.com">kdlucas@gmail.com</a><br>
</div>

--000e0cd23a82dc353f04777e656e--


--===============7347414008455169894==
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
--===============7347414008455169894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7347414008455169894==--

