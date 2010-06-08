Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tosubrata@gmail.com>) id 1OLwKJ-0004dY-1t
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 10:46:35 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OLwKI-00038l-8w
	for ltp-list@lists.sourceforge.net; Tue, 08 Jun 2010 10:46:34 +0000
Received: by gwb20 with SMTP id 20so2460265gwb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Jun 2010 03:46:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1275993506.5822.37.camel@munipradeep-laptop>
References: <1275993506.5822.37.camel@munipradeep-laptop>
Date: Tue, 8 Jun 2010 16:16:28 +0530
Message-ID: <AANLkTikReF6tpyTcBysNGSu5hOirEtitIZlJ7UfMfe6M@mail.gmail.com>
From: Subrata Modak <tosubrata@gmail.com>
Subject: Re: [LTP] Patch for echo testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1372078477604753852=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

--===============1372078477604753852==
Content-Type: multipart/alternative; boundary=001636c92ad96fbaa30488828012

--001636c92ad96fbaa30488828012
Content-Type: text/plain; charset=UTF-8

Thanks Muni. Please also post the machine details(arch, kernel version,etc)
so that i can verify the same.

Regards--
Subrata

On Tue, Jun 8, 2010 at 4:08 PM, Munipradeep Beerakam <
mpradeep@linux.vnet.ibm.com> wrote:

> Hi,
>
> echo test is failing with the below errors as we didn't initialized the
> 'addrlen' parameter of getsockname.
>
> ####################################
> ...
> ...
> Creating socket .....
> echoes      1  TBROK  :  getsockname call failed (pid=7086): Invalid
> argument
> echo: Invalid argument
> ...
> ...
> ####################################
>
> So, attached the patch which initializes the 'addrlen' parameter.
>
> Please correct if anything is wrong.
>
> Thanks
> Muni
>
>
> ------------------------------------------------------------------------------
> ThinkGeek and WIRED's GeekDad team up for the Ultimate
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the
> lucky parental unit.  See the prize list and enter to win:
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>


-- 
Regards & Thanks--
Subrata

--001636c92ad96fbaa30488828012
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Thanks Muni. Please also post the machine details(arch, kernel version,etc)=
 so that i can verify the same.<br><br>Regards--<br>Subrata<br><br><div cla=
ss=3D"gmail_quote">On Tue, Jun 8, 2010 at 4:08 PM, Munipradeep Beerakam <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:mpradeep@linux.vnet.ibm.com">mpradeep@=
linux.vnet.ibm.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<br>
echo test is failing with the below errors as we didn&#39;t initialized the=
<br>
&#39;addrlen&#39; parameter of getsockname.<br>
<br>
####################################<br>
...<br>
...<br>
Creating socket .....<br>
echoes =C2=A0 =C2=A0 =C2=A01 =C2=A0TBROK =C2=A0: =C2=A0getsockname call fai=
led (pid=3D7086): Invalid<br>
argument<br>
echo: Invalid argument<br>
...<br>
...<br>
####################################<br>
<br>
So, attached the patch which initializes the &#39;addrlen&#39; parameter.<b=
r>
<br>
Please correct if anything is wrong.<br>
<br>
Thanks<br>
Muni<br>
<br>-----------------------------------------------------------------------=
-------<br>
ThinkGeek and WIRED&#39;s GeekDad team up for the Ultimate<br>
GeekDad Father&#39;s Day Giveaway. ONE MASSIVE PRIZE to the<br>
lucky parental unit. =C2=A0See the prize list and enter to win:<br>
<a href=3D"http://p.sf.net/sfu/thinkgeek-promo" target=3D"_blank">http://p.=
sf.net/sfu/thinkgeek-promo</a><br>_________________________________________=
______<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
<br></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards &amp; Thank=
s--<br>Subrata<br>

--001636c92ad96fbaa30488828012--


--===============1372078477604753852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
--===============1372078477604753852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1372078477604753852==--

