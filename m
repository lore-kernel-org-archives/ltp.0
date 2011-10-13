Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joshiplns@gmail.com>) id 1REJlM-00057E-Pe
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 11:47:48 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1REJlL-0000Le-VH
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 11:47:48 +0000
Received: by wwg14 with SMTP id 14so1385244wwg.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Oct 2011 04:47:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGH67wTJVjjYHOqdcXqV8motaWeXWbin0RVDoB3iOSMh0ehyBA@mail.gmail.com>
References: <CADfK0X7-VwdyCDMZe5VJfv+KchEKqRRw6e-9dv4=ine+36rDzQ@mail.gmail.com>
	<CADfK0X5k6se_VirWQk-Fh1Dibx0Xpg-Wq8ekXDqHCj1bY+jhLw@mail.gmail.com>
	<CAMhs6YxRdWGBwg2R4aCSJtB9ZFTYFfOEO+=GvrL0yKa0cM-Z6Q@mail.gmail.com>
	<CADfK0X4ScZbwutFoB5h05jD3-qeCdwURjyNfNRbTMHxxdO_neg@mail.gmail.com>
	<CADfK0X7hP+5B8UA4pm9gDk40t+rpC_KNMQ3hdiNJq6H5x4DV6A@mail.gmail.com>
	<20111012134133.GA21367@saboteur.suse.cz>
	<CAGH67wTJVjjYHOqdcXqV8motaWeXWbin0RVDoB3iOSMh0ehyBA@mail.gmail.com>
Date: Thu, 13 Oct 2011 17:16:31 +0530
Message-ID: <CADfK0X6Rjn_+NPdO5XcZz7Ovk70RaLV4uHJ3abBTcKyRmfo9KA@mail.gmail.com>
From: "Josh!" <joshiplns@gmail.com>
Subject: Re: [LTP] ltp-pan: cannot execute binary file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3307060263675568197=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3307060263675568197==
Content-Type: multipart/alternative; boundary=485b392b17201b903c04af2cb1bb

--485b392b17201b903c04af2cb1bb
Content-Type: text/plain; charset=ISO-8859-1

Hi..

Yes i need modify Make-file to my Cross_Compiler platform.

Joshi

On Wed, Oct 12, 2011 at 8:24 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Wed, Oct 12, 2011 at 6:41 AM, Cyril Hrubis <chrubis@suse.cz> wrote:
> > Hi!
> >> >
> >> > I'm sharing you following info regarding your last comment
> >> >
> >> > +++++
> >> > /opt/Joshi_LTP4/bin # file ltp-pan
> >> > ltp-pan: ELF 32-bit LSB execable, Intel 80386SYSV), for GNU/Li
> dynamically
> >> > linkhared libs), not stripped
> >> > +++++
> >> >
> >> > Even though exporting CROSS_COMPILER it still compiling for X86 not
> for
> >> > armv7a.
> >> > In Make file not able to find out CROSS_COMPILER .
> >> >
> >
> > Hmm, what are the exact steps that have you done?
> >
> > I haven't tried cross compiling myself, but there seems to be --host and
> > --build configure parameters that should do the trick (in case this
> > actually works).
>
> You'll need to do more than just set --host, --build, etc. You'll need
> to pass in CC, CFLAGS, and LDFLAGS.
> -Garrett
>

--485b392b17201b903c04af2cb1bb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font color=3D"#333399"><font size=3D"4"><font face=3D"tre=
buchet ms,sans-serif">Hi..<br><br>Yes i need modify Make-file to my Cross_C=
ompiler platform.<br><br>Joshi<br></font></font></font><br><div class=3D"gm=
ail_quote">
On Wed, Oct 12, 2011 at 8:24 PM, Garrett Cooper <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.com</a>&gt;</span> wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bor=
der-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Wed, Oct 12, 2011 at 6:41 AM, Cyril Hr=
ubis &lt;<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<=
br>
&gt; Hi!<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I&#39;m sharing you following info regarding your last commen=
t<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; +++++<br>
&gt;&gt; &gt; /opt/Joshi_LTP4/bin # file ltp-pan<br>
&gt;&gt; &gt; ltp-pan: ELF 32-bit LSB execable, Intel 80386SYSV), for GNU/L=
i dynamically<br>
&gt;&gt; &gt; linkhared libs), not stripped<br>
&gt;&gt; &gt; +++++<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Even though exporting CROSS_COMPILER it still compiling for X=
86 not for<br>
&gt;&gt; &gt; armv7a.<br>
&gt;&gt; &gt; In Make file not able to find out CROSS_COMPILER .<br>
&gt;&gt; &gt;<br>
&gt;<br>
&gt; Hmm, what are the exact steps that have you done?<br>
&gt;<br>
&gt; I haven&#39;t tried cross compiling myself, but there seems to be --ho=
st and<br>
&gt; --build configure parameters that should do the trick (in case this<br=
>
&gt; actually works).<br>
<br>
</div></div>You&#39;ll need to do more than just set --host, --build, etc. =
You&#39;ll need<br>
to pass in CC, CFLAGS, and LDFLAGS.<br>
<font color=3D"#888888">-Garrett<br>
</font></blockquote></div><br><br clear=3D"all"><br><span style=3D"color: r=
gb(51, 51, 153);"></span><span style=3D"color: rgb(51, 51, 153);"></span><b=
r>
</div>

--485b392b17201b903c04af2cb1bb--


--===============3307060263675568197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
--===============3307060263675568197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3307060263675568197==--

