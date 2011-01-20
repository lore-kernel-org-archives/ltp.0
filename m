Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <green.hu@gmail.com>) id 1PfvS8-00074I-FI
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 14:25:32 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfvS7-0000Wf-5e
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 14:25:32 +0000
Received: by fxm17 with SMTP id 17so661401fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Jan 2011 06:25:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTim11yKENwbO=t2ueyQsF6CjpmJYB4t_cYavu2S2@mail.gmail.com>
References: <AANLkTikm9cgL0w6WF+D_=GRLb1Wd8wdW_90f0T7SkSAW@mail.gmail.com>
	<AANLkTim11yKENwbO=t2ueyQsF6CjpmJYB4t_cYavu2S2@mail.gmail.com>
Date: Thu, 20 Jan 2011 22:25:24 +0800
Message-ID: <AANLkTim17mnJupGyFkpbYHd70hiGY01ArcuQZBTmsO+B@mail.gmail.com>
From: GreenTime <green.hu@gmail.com>
Subject: Re: [LTP] [PATCH] mmap03 to support NDS32 cpu
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5499191615311384599=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============5499191615311384599==
Content-Type: multipart/alternative; boundary=20cf3054a4578b35a9049a47e78c

--20cf3054a4578b35a9049a47e78c
Content-Type: text/plain; charset=ISO-8859-1

2011/1/20 Garrett Cooper <yanegomi@gmail.com>

> On Thu, Jan 20, 2011 at 1:41 AM, GreenTime <green.hu@gmail.com> wrote:
> > Hi Garrett,
> >
> > I add a new cpu macro __NDS32__ in mmap03 for it to pass.
>
> What in the world does __NDS32__ stand for?
> Thanks,
> -Garrett
>

It's a new cpu architecture.

This is their open source website. http://osdk.andestech.com/

This is their website. http://www.andestech.com/

__NDS32__ is a predefine macro of their toolchain.

GreenTime :)

--20cf3054a4578b35a9049a47e78c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/1/20 Garrett Cooper <span dir=3D"lt=
r">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.com</a>&gt;</sp=
an><br><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex=
; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On Thu, Jan 20, 2011 at 1:41 AM, GreenTime &lt;<a href=3D=
"http://green.hu" target=3D"_blank">green.hu</a>@<a href=3D"http://gmail.co=
m" target=3D"_blank">gmail.com</a>&gt; wrote:<br>
&gt; Hi Garrett,<br>
&gt;<br>
&gt; I add a new cpu macro __NDS32__ in mmap03 for it to pass.<br>
<br>
</div>What in the world does __NDS32__ stand for?<br>
Thanks,<br>
<font color=3D"#888888">-Garrett<br>
</font></blockquote></div><br>It&#39;s a new cpu architecture.<br><br>This =
is their open source website. <a href=3D"http://osdk.andestech.com/">http:/=
/osdk.andestech.com/</a><br><br>This is their website. <a href=3D"http://ww=
w.andestech.com/">http://www.andestech.com/</a><br>
<br>__NDS32__ is a predefine macro of their toolchain.<br><br>GreenTime :)<=
br>=A0<br><br>

--20cf3054a4578b35a9049a47e78c--


--===============5499191615311384599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
--===============5499191615311384599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5499191615311384599==--

