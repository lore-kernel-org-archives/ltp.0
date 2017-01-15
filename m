Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <srikanth007m@gmail.com>) id 1cSlho-00065c-Hf
	for ltp-list@lists.sourceforge.net; Sun, 15 Jan 2017 14:22:48 +0000
Received: from mail-qk0-f182.google.com ([209.85.220.182])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cSlhn-00046B-B5
	for ltp-list@lists.sourceforge.net; Sun, 15 Jan 2017 14:22:48 +0000
Received: by mail-qk0-f182.google.com with SMTP id a20so97484118qkc.1
	for <ltp-list@lists.sourceforge.net>;
	Sun, 15 Jan 2017 06:22:47 -0800 (PST)
MIME-Version: 1.0
References: <MA1PR01MB05655185FD871E8503C51256F7630@MA1PR01MB0565.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <MA1PR01MB05655185FD871E8503C51256F7630@MA1PR01MB0565.INDPRD01.PROD.OUTLOOK.COM>
From: "$rik@nth" <srikanth007m@gmail.com>
Date: Sun, 15 Jan 2017 14:22:30 +0000
Message-ID: <CANKSX+Fv7tTryik+7O=wwRGJE8-oC_HJsYFVumKvQ=-mkTW9CQ@mail.gmail.com>
Subject: Re: [LTP] LTP for ARM64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0100805233129007645=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Senthil K <Senthil.K@aricent.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============0100805233129007645==
Content-Type: multipart/alternative; boundary=94eb2c05e90ac4ffae054622cc09

--94eb2c05e90ac4ffae054622cc09
Content-Type: text/plain; charset=UTF-8

Is this for which OS?
On Fri, Jan 6, 2017 at 7:53 AM Senthil K <Senthil.K@aricent.com> wrote:

>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> Hi All,
>
>
>
>
>
> We are using user space 32bit and kernel space 64 bit for ARMV8 platform.
>
>
>
>
>
> We have compiled the LTP using 32 bit tool chain. Follwoing are the steps
> we have followed
>
>
>
>
>
> export AR=arm-buildroot-linux-ar
>
>
> export LD=arm-buildroot-linux-ld
>
>
> export CC=arm-buildroot-linux-gcc
>
>
>
>
>
> ./configure --host=arm-linux --target=arm-buildroot-linux
> --exec-prefix=/home/
>
>
> make
>
>
> make install.
>
>
>
>
>
> The compilation was successful.
>
>
>
>
>
> We are observing that there are more failures due to "getpwnam(nobody)" -
> ENOENT.
>
>
>
>
>
> We have added the  nobody entry in /etc/passwd file but still we are
> getting the issue.
>
>
>
>
>
> Please share your inputs.
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> *Senthil K*
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> "DISCLAIMER: This message is proprietary to Aricent and is intended solely
> for the use of the individual to whom it is addressed. It may contain
> privileged or confidential information and should not be circulated or used
> for any purpose other than for what
>
> it is intended. If you have received this message in error, please notify
> the originator immediately. If you are not the intended recipient, you are
> notified that you are strictly prohibited from using, copying, altering, or
> disclosing the contents of this
>
> message. Aricent accepts no responsibility for loss or damage arising from
> the use of the information transmitted by this email including damage from
> virus."
>
>
>
>
>
>
> ------------------------------------------------------------------------------
>
> Check out the vibrant tech community on one of the world's most
>
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
>
> Ltp-list mailing list
>
> Ltp-list@lists.sourceforge.net
>
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

--94eb2c05e90ac4ffae054622cc09
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div>Is this for which OS?=C2=A0<br><div class=3D"gmail_quote"><div>On Fri,=
 Jan 6, 2017 at 7:53 AM Senthil K &lt;<a href=3D"mailto:Senthil.K@aricent.c=
om">Senthil.K@aricent.com</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex"><br><br><br><br><br><br><br><br><br><br><br><br><div lang=3D"EN-US" l=
ink=3D"#0563C1" vlink=3D"#954F72" class=3D"gmail_msg"><br><br><div class=3D=
"m_-6140656456562552100WordSection1 gmail_msg"><br><br><p class=3D"MsoNorma=
l gmail_msg" style=3D"background:white"><span style=3D"font-size:9.5pt;font=
-family:&quot;Arial&quot;,sans-serif;color:#222222" class=3D"gmail_msg">Hi =
All,<u class=3D"gmail_msg"></u><u class=3D"gmail_msg"></u></span></p><br><b=
r><p class=3D"MsoNormal gmail_msg" style=3D"background:white"><span style=
=3D"font-size:9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222"=
 class=3D"gmail_msg"><u class=3D"gmail_msg"></u>=C2=A0<u class=3D"gmail_msg=
"></u></span></p><br><br><p class=3D"MsoNormal gmail_msg" style=3D"backgrou=
nd:white"><span style=3D"font-size:9.5pt;font-family:&quot;Arial&quot;,sans=
-serif;color:#222222" class=3D"gmail_msg">We are using user space 32bit and=
 kernel space 64 bit for ARMV8 platform.<u class=3D"gmail_msg"></u><u class=
=3D"gmail_msg"></u></span></p><br><br><p class=3D"MsoNormal gmail_msg" styl=
e=3D"background:white"><span style=3D"font-size:9.5pt;font-family:&quot;Ari=
al&quot;,sans-serif;color:#222222" class=3D"gmail_msg"><u class=3D"gmail_ms=
g"></u>=C2=A0<u class=3D"gmail_msg"></u></span></p><br><br><p class=3D"MsoN=
ormal gmail_msg" style=3D"background:white"><span style=3D"font-size:9.5pt;=
font-family:&quot;Arial&quot;,sans-serif;color:#222222" class=3D"gmail_msg"=
>We have compiled the LTP using 32 bit tool chain. Follwoing are the steps =
we have followed<u class=3D"gmail_msg"></u><u class=3D"gmail_msg"></u></spa=
n></p><br><br><p class=3D"MsoNormal gmail_msg" style=3D"background:white"><=
span style=3D"font-size:9.5pt;font-family:&quot;Arial&quot;,sans-serif;colo=
r:#222222" class=3D"gmail_msg"><u class=3D"gmail_msg"></u>=C2=A0<u class=3D=
"gmail_msg"></u></span></p><br><br><p class=3D"MsoNormal gmail_msg" style=
=3D"background:white"><span style=3D"font-size:9.5pt;font-family:&quot;Aria=
l&quot;,sans-serif;color:#222222" class=3D"gmail_msg">export AR=3Darm-build=
root-linux-ar<u class=3D"gmail_msg"></u><u class=3D"gmail_msg"></u></span><=
/p><br><br><p class=3D"MsoNormal gmail_msg" style=3D"background:white"><spa=
n style=3D"font-size:9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#=
222222" class=3D"gmail_msg">export LD=3Darm-buildroot-linux-ld<u class=3D"g=
mail_msg"></u><u class=3D"gmail_msg"></u></span></p><br><br><p class=3D"Mso=
Normal gmail_msg" style=3D"background:white"><span style=3D"font-size:9.5pt=
;font-family:&quot;Arial&quot;,sans-serif;color:#222222" class=3D"gmail_msg=
">export CC=3Darm-buildroot-linux-gcc<u class=3D"gmail_msg"></u><u class=3D=
"gmail_msg"></u></span></p><br><br><p class=3D"MsoNormal gmail_msg" style=
=3D"background:white"><span style=3D"font-size:9.5pt;font-family:&quot;Aria=
l&quot;,sans-serif;color:#222222" class=3D"gmail_msg"><u class=3D"gmail_msg=
"></u>=C2=A0<u class=3D"gmail_msg"></u></span></p><br><br><p class=3D"MsoNo=
rmal gmail_msg" style=3D"background:white"><span style=3D"font-size:9.5pt;f=
ont-family:&quot;Arial&quot;,sans-serif;color:#222222" class=3D"gmail_msg">=
./configure --host=3Darm-linux --target=3Darm-buildroot-linux --exec-prefix=
=3D/home/<u class=3D"gmail_msg"></u><u class=3D"gmail_msg"></u></span></p><=
br><br><p class=3D"MsoNormal gmail_msg" style=3D"background:white"><span st=
yle=3D"font-size:9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#2222=
22" class=3D"gmail_msg">make=C2=A0<u class=3D"gmail_msg"></u><u class=3D"gm=
ail_msg"></u></span></p><br><br><p class=3D"MsoNormal gmail_msg" style=3D"b=
ackground:white"><span style=3D"font-size:9.5pt;font-family:&quot;Arial&quo=
t;,sans-serif;color:#222222" class=3D"gmail_msg">make install.<u class=3D"g=
mail_msg"></u><u class=3D"gmail_msg"></u></span></p><br><br><p class=3D"Mso=
Normal gmail_msg" style=3D"background:white"><span style=3D"font-size:9.5pt=
;font-family:&quot;Arial&quot;,sans-serif;color:#222222" class=3D"gmail_msg=
"><u class=3D"gmail_msg"></u>=C2=A0<u class=3D"gmail_msg"></u></span></p><b=
r><br><p class=3D"MsoNormal gmail_msg" style=3D"background:white"><span sty=
le=3D"font-size:9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#22222=
2" class=3D"gmail_msg">The compilation was successful.=C2=A0<u class=3D"gma=
il_msg"></u><u class=3D"gmail_msg"></u></span></p><br><br><p class=3D"MsoNo=
rmal gmail_msg" style=3D"background:white"><span style=3D"font-size:9.5pt;f=
ont-family:&quot;Arial&quot;,sans-serif;color:#222222" class=3D"gmail_msg">=
<u class=3D"gmail_msg"></u>=C2=A0<u class=3D"gmail_msg"></u></span></p><br>=
<br><p class=3D"MsoNormal gmail_msg" style=3D"background:white"><span style=
=3D"font-size:9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222"=
 class=3D"gmail_msg">We are observing that there are more failures due to &=
quot;getpwnam(nobody)&quot; - ENOENT.=C2=A0<u class=3D"gmail_msg"></u><u cl=
ass=3D"gmail_msg"></u></span></p><br><br><p class=3D"MsoNormal gmail_msg" s=
tyle=3D"background:white"><span style=3D"font-size:9.5pt;font-family:&quot;=
Arial&quot;,sans-serif;color:#222222" class=3D"gmail_msg"><u class=3D"gmail=
_msg"></u>=C2=A0<u class=3D"gmail_msg"></u></span></p><br><br><p class=3D"M=
soNormal gmail_msg" style=3D"background:white"><span style=3D"font-size:9.5=
pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222" class=3D"gmail_m=
sg">We have added the =C2=A0nobody entry in /etc/passwd file but still we a=
re getting the issue.<u class=3D"gmail_msg"></u><u class=3D"gmail_msg"></u>=
</span></p><br><br><p class=3D"MsoNormal gmail_msg" style=3D"background:whi=
te"><span style=3D"font-size:9.5pt;font-family:&quot;Arial&quot;,sans-serif=
;color:#222222" class=3D"gmail_msg"><u class=3D"gmail_msg"></u>=C2=A0<u cla=
ss=3D"gmail_msg"></u></span></p><br><br><p class=3D"MsoNormal gmail_msg" st=
yle=3D"background:white"><span style=3D"font-size:9.5pt;font-family:&quot;A=
rial&quot;,sans-serif;color:#222222" class=3D"gmail_msg">Please share your =
inputs.<u class=3D"gmail_msg"></u><u class=3D"gmail_msg"></u></span></p><br=
><br><p class=3D"MsoNormal gmail_msg" style=3D"background:white"><span styl=
e=3D"font-size:9.5pt;font-family:&quot;Arial&quot;,sans-serif;color:#222222=
" class=3D"gmail_msg">=C2=A0<u class=3D"gmail_msg"></u><u class=3D"gmail_ms=
g"></u></span></p><br><br><p class=3D"MsoNormal gmail_msg"><u class=3D"gmai=
l_msg"></u>=C2=A0<u class=3D"gmail_msg"></u></p><br><br><p class=3D"MsoNorm=
al gmail_msg"><u class=3D"gmail_msg"></u>=C2=A0<u class=3D"gmail_msg"></u><=
/p><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><tab=
le class=3D"m_-6140656456562552100MsoNormalTable gmail_msg" border=3D"0" ce=
llspacing=3D"0" cellpadding=3D"0" width=3D"100%" style=3D"width:100.0%"><td=
><br><tbody class=3D"gmail_msg"><br><tr class=3D"gmail_msg"><br><td style=
=3D"padding:3.75pt 0in 3.75pt 0in" class=3D"gmail_msg"><br><br><p class=3D"=
MsoNormal gmail_msg" style=3D"line-height:115%"><b class=3D"gmail_msg"><spa=
n style=3D"font-size:9.0pt;line-height:115%;font-family:&quot;Helvetica&quo=
t;,sans-serif" class=3D"gmail_msg">Senthil K</span></b><span style=3D"font-=
size:9.0pt;line-height:115%;font-family:&quot;Helvetica&quot;,sans-serif" c=
lass=3D"gmail_msg"><u class=3D"gmail_msg"></u><u class=3D"gmail_msg"></u></=
span></p><br><br></td><td><br></td></tr><td><br><tr class=3D"gmail_msg"><br=
><td style=3D"padding:3.75pt 0in 3.75pt 0in" class=3D"gmail_msg"><br><br><p=
 class=3D"MsoNormal gmail_msg" style=3D"line-height:115%"><span style=3D"fo=
nt-size:9.0pt;line-height:115%;font-family:&quot;Helvetica&quot;,sans-serif=
" class=3D"gmail_msg"><u class=3D"gmail_msg"></u>=C2=A0<u class=3D"gmail_ms=
g"></u></span></p><br><br></td><td><br></td></tr><td><br><tr class=3D"gmail=
_msg"><br><td style=3D"padding:3.75pt 0in 3.75pt 0in" class=3D"gmail_msg"><=
br><br><p class=3D"MsoNormal gmail_msg" style=3D"line-height:115%"><span st=
yle=3D"font-size:9.0pt;line-height:115%;font-family:&quot;Helvetica&quot;,s=
ans-serif" class=3D"gmail_msg"><u class=3D"gmail_msg"></u>=C2=A0<u class=3D=
"gmail_msg"></u></span></p><br><br></td><td><br></td></tr><td><br><tr class=
=3D"gmail_msg"><br><td style=3D"padding:3.75pt 0in 3.75pt 0in" class=3D"gma=
il_msg"><br><br><p class=3D"MsoNormal gmail_msg" style=3D"line-height:115%"=
><span style=3D"font-size:9.0pt;line-height:115%;font-family:&quot;Helvetic=
a&quot;,sans-serif" class=3D"gmail_msg"><u class=3D"gmail_msg"></u>=C2=A0<u=
 class=3D"gmail_msg"></u></span></p><br><br></td><td><br></td></tr><td><br>=
</td></td></td></td></tbody><td><br></td></td></table><br><br><p class=3D"M=
soNormal gmail_msg"><u class=3D"gmail_msg"></u>=C2=A0<u class=3D"gmail_msg"=
></u></p><br><br><p class=3D"MsoNormal gmail_msg"><u class=3D"gmail_msg"></=
u>=C2=A0<u class=3D"gmail_msg"></u></p><br><br></div><br><br>&quot;DISCLAIM=
ER: This message is proprietary to Aricent and is intended solely for the u=
se of the individual to whom it is addressed. It may contain privileged or =
confidential information and should not be circulated or used for any purpo=
se other than for what<br><br> it is intended. If you have received this me=
ssage in error, please notify the originator immediately. If you are not th=
e intended recipient, you are notified that you are strictly prohibited fro=
m using, copying, altering, or disclosing the contents of this<br><br> mess=
age. Aricent accepts no responsibility for loss or damage arising from the =
use of the information transmitted by this email including damage from viru=
s.&quot;<br><br></div><br><br><br><br>-------------------------------------=
-----------------------------------------<br class=3D"gmail_msg"><br>Check =
out the vibrant tech community on one of the world&#39;s most<br class=3D"g=
mail_msg"><br>engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link=
/slashdot" rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">http://=
sdm.link/slashdot</a>_______________________________________________<br cla=
ss=3D"gmail_msg"><br>Ltp-list mailing list<br class=3D"gmail_msg"><br><a hr=
ef=3D"mailto:Ltp-list@lists.sourceforge.net" class=3D"gmail_msg" target=3D"=
_blank">Ltp-list@lists.sourceforge.net</a><br class=3D"gmail_msg"><br><a hr=
ef=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" rel=3D"norefer=
rer" class=3D"gmail_msg" target=3D"_blank">https://lists.sourceforge.net/li=
sts/listinfo/ltp-list</a><br class=3D"gmail_msg"><br></blockquote></div></d=
iv>

--94eb2c05e90ac4ffae054622cc09--


--===============0100805233129007645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
--===============0100805233129007645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0100805233129007645==--

