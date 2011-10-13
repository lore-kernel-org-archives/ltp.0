Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <joshiplns@gmail.com>) id 1REKdl-0007Q7-TS
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 12:44:01 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1REKdg-0007kE-HS
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 12:44:01 +0000
Received: by bkat8 with SMTP id t8so669169bka.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Oct 2011 05:43:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20111013121742.GA23592@saboteur.suse.cz>
References: <CADfK0X7-VwdyCDMZe5VJfv+KchEKqRRw6e-9dv4=ine+36rDzQ@mail.gmail.com>
	<CADfK0X5k6se_VirWQk-Fh1Dibx0Xpg-Wq8ekXDqHCj1bY+jhLw@mail.gmail.com>
	<CAMhs6YxRdWGBwg2R4aCSJtB9ZFTYFfOEO+=GvrL0yKa0cM-Z6Q@mail.gmail.com>
	<CADfK0X4ScZbwutFoB5h05jD3-qeCdwURjyNfNRbTMHxxdO_neg@mail.gmail.com>
	<CADfK0X7hP+5B8UA4pm9gDk40t+rpC_KNMQ3hdiNJq6H5x4DV6A@mail.gmail.com>
	<20111012134133.GA21367@saboteur.suse.cz>
	<CADfK0X435BeEb91Jsp96kRJgkaW-4aHHsLqNdU2WU+59HTPdug@mail.gmail.com>
	<20111013121742.GA23592@saboteur.suse.cz>
Date: Thu, 13 Oct 2011 18:13:49 +0530
Message-ID: <CADfK0X7FS36gcXC=H+zE+2NvSb53KkEeXFCPR55PY9rH8H+C2g@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============8077645249772236160=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8077645249772236160==
Content-Type: multipart/alternative; boundary=00151747c1520cca2404af2d7ef1

--00151747c1520cca2404af2d7ef1
Content-Type: text/plain; charset=ISO-8859-1

Hi ,

Yes I Did that.

+++++++++++++++
[Joshi@myserver ltp-full-20110915]$ sudo ./configure
--prefix=/tftpboot/arm/beagleboard/ltp-full-20110915
+++++++++++++++

Still having Problem with Cross_Compilation.

-Joshi
On Thu, Oct 13, 2011 at 5:47 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I exported CROSS_COMPILER path and ran configure the path from where LTP
> > execute.
> > and did make and make install as *ROOT* user.
> >
> > I think , i want to modify Make-file in latest LTP for setting to my tool
> > chain.
> >
> > Could any one share Knowledge on 'How to modify the LTP-Make-file to our
> > cross_compiler platform'
>
> As Garrett said in previous mail, you need to pass correct parameters to
> configure script, and these pointed out were --host, --build, CC,
> CFLAGS, LDFLAGS. And as I said earlier, I didn't tried to cross compile
> LTP so I do not have definitive answer how to do that. All I have are
> hints.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>



-- 
*
*

--00151747c1520cca2404af2d7ef1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font color=3D"#333399"><font size=3D"4"><font face=3D"tre=
buchet ms,sans-serif">Hi ,<br><br>Yes I Did that.<br><br>+++++++++++++++<br=
>[Joshi@myserver ltp-full-20110915]$ sudo ./configure --prefix=3D/tftpboot/=
arm/beagleboard/ltp-full-20110915<br>
+++++++++++++++<br><br>Still having Problem with Cross_Compilation.<br><br>=
-Joshi<br></font></font></font><div class=3D"gmail_quote">On Thu, Oct 13, 2=
011 at 5:47 PM, Cyril Hrubis <span dir=3D"ltr">&lt;<a href=3D"mailto:chrubi=
s@suse.cz">chrubis@suse.cz</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">Hi!<br>
<div class=3D"im">&gt; I exported CROSS_COMPILER path and ran configure the=
 path from where LTP<br>
&gt; execute.<br>
&gt; and did make and make install as *ROOT* user.<br>
&gt;<br>
&gt; I think , i want to modify Make-file in latest LTP for setting to my t=
ool<br>
&gt; chain.<br>
&gt;<br>
&gt; Could any one share Knowledge on &#39;How to modify the LTP-Make-file =
to our<br>
&gt; cross_compiler platform&#39;<br>
<br>
</div>As Garrett said in previous mail, you need to pass correct parameters=
 to<br>
configure script, and these pointed out were --host, --build, CC,<br>
CFLAGS, LDFLAGS. And as I said earlier, I didn&#39;t tried to cross compile=
<br>
LTP so I do not have definitive answer how to do that. All I have are<br>
hints.<br>
<font color=3D"#888888"><br>
--<br>
Cyril Hrubis<br>
<a href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a><br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br><div><div style=
=3D"color: rgb(80, 0, 80);"><font style=3D"color: rgb(102, 0, 204); font-fa=
mily: trebuchet ms,sans-serif;" size=3D"4"><b><br></b></font></div></div><s=
pan style=3D"color: rgb(51, 51, 153);"></span><span style=3D"color: rgb(51,=
 51, 153);"></span><br>

</div>

--00151747c1520cca2404af2d7ef1--


--===============8077645249772236160==
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
--===============8077645249772236160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8077645249772236160==--

