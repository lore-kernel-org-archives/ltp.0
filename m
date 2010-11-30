Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1PNJ0f-0002mc-B7
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 05:44:13 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PNJ0e-00082d-GN
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 05:44:13 +0000
Received: by wwb39 with SMTP id 39so2206061wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 29 Nov 2010 21:44:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTimx0uR1v1AEP3DTx=-d1fxudUir3ngoDrjxvBtr@mail.gmail.com>
References: <AANLkTinw1Yc+QGtMuKH=xep4VGjusBdO2+mQeQhmM15K@mail.gmail.com>
	<20101129133724.GA4065@hallyn.com>
	<AANLkTimLXaH_mRJ7xxfj93RJt6wPEcheC3Mg6nONkSq4@mail.gmail.com>
	<AANLkTimx0uR1v1AEP3DTx=-d1fxudUir3ngoDrjxvBtr@mail.gmail.com>
Date: Tue, 30 Nov 2010 11:14:06 +0530
Message-ID: <AANLkTikUWuOYH=pGWn6SNZKug8iNEJeNJLoTRcVgGQt3@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: Re: [LTP] networkstress tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7589938962101584939=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ajay.khandelwal@st.com, ltp-list@lists.sourceforge.net

--===============7589938962101584939==
Content-Type: multipart/alternative; boundary=0016368341d84d2dde04963ead49

--0016368341d84d2dde04963ead49
Content-Type: text/plain; charset=ISO-8859-1

okk.
i just mentioned the adresses of remote host and local host in the scripts.

On Tue, Nov 30, 2010 at 11:07 AM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Mon, Nov 29, 2010 at 9:33 PM, ARJIT SHARMA <joyarjit@gmail.com> wrote:
> > Actually Network related tests are failing, like :--
> >
> > network_stress.broken_ip
> >
> > network_stress.icmp
> >
> > network_stress.interface
> >
> > network_stress.multicast
> >
> > network_stress.tcp
> >
> >
> > here I am sending you the log of "network_stress.broken.ip" testcase...
> > similar error is come in all the above mentioned tests
> > "TBROK: Failed to get the interface name at the remote host.".
>
>    You didn't mention that you've hacked the scripts to get them to
> pass instead of potentially addressing the main issue, which is the
> unbound variables in the shell scripts (which I did explicitly when I
> coded up the general purpose libraries to avoid QA issues like this,
> or identify problems).
>    I will look at it in a while.
> Thanks,
> -Garrett
>



-- 
Best Regards,
Arjit Sharma.

--0016368341d84d2dde04963ead49
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>okk.</div>
<div>i just=A0mentioned the adresses of remote host and local host in the s=
cripts.<br><br></div>
<div class=3D"gmail_quote">On Tue, Nov 30, 2010 at 11:07 AM, Garrett Cooper=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail=
.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div class=3D"im">On Mon, Nov 29, 2010 at 9:33 PM, ARJIT SHARMA &lt;<a href=
=3D"mailto:joyarjit@gmail.com">joyarjit@gmail.com</a>&gt; wrote:<br>&gt; Ac=
tually Network related tests are failing, like :--<br>&gt;<br>&gt; network_=
stress.broken_ip<br>
&gt;<br>&gt; network_stress.icmp<br>&gt;<br>&gt; network_stress.interface<b=
r>&gt;<br>&gt; network_stress.multicast<br>&gt;<br>&gt; network_stress.tcp<=
br>&gt;<br>&gt;<br>&gt; here I am sending you the log of &quot;network_stre=
ss.broken.ip&quot; testcase...<br>
&gt; similar error is come in all the above mentioned tests<br>&gt; &quot;T=
BROK: Failed to get the interface name at the remote host.&quot;.<br><br></=
div>=A0 =A0You didn&#39;t mention that you&#39;ve hacked the scripts to get=
 them to<br>
pass instead of potentially addressing the main issue, which is the<br>unbo=
und variables in the shell scripts (which I did explicitly when I<br>coded =
up the general purpose libraries to avoid QA issues like this,<br>or identi=
fy problems).<br>
=A0 =A0I will look at it in a while.<br>Thanks,<br><font color=3D"#888888">=
-Garrett<br></font></blockquote></div><br><br clear=3D"all"><br>-- <br>
<div>Best Regards,</div>
<div>Arjit Sharma.</div><br>

--0016368341d84d2dde04963ead49--


--===============7589938962101584939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
--===============7589938962101584939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7589938962101584939==--

