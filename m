Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <pramod_gajula@infosys.com>) id 1RaQ35-0006lc-IM
	for ltp-list@lists.sourceforge.net; Tue, 13 Dec 2011 10:57:27 +0000
Received: from kecgate02.infosys.com ([122.98.14.32])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RaQ30-0004CZ-2k
	for ltp-list@lists.sourceforge.net; Tue, 13 Dec 2011 10:57:27 +0000
From: Pramod Gajula <pramod_gajula@infosys.com>
Date: Tue, 13 Dec 2011 16:27:13 +0530
Message-ID: <82BEC95A68153C46932D3E196B922B7217E7AE57AC@BLRKECMBX07.ad.infosys.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Testcases for interaces and devices on linux
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8033379856911659797=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============8033379856911659797==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_82BEC95A68153C46932D3E196B922B7217E7AE57ACBLRKECMBX07ad_"

--_000_82BEC95A68153C46932D3E196B922B7217E7AE57ACBLRKECMBX07ad_
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to find  Testcases for below features on linux using LTP,


1. UART  6. Ethernet - MAC

2. SPI

3. I2C
4. I2S

5. SDIO



It will be great if someone can guide me, to find testcases for above fea=
tures.

Regards,
Pramod

**************** CAUTION - Disclaimer *****************
This e-mail contains PRIVILEGED AND CONFIDENTIAL INFORMATION intended sol=
ely 
for the use of the addressee(s). If you are not the intended recipient, p=
lease 
notify the sender by e-mail and delete the original message. Further, you=
 are not 
to copy, disclose, or distribute this e-mail or its contents to any other=
 person and 
any such actions are unlawful. This e-mail may contain viruses. Infosys h=
as taken 
every reasonable precaution to minimize this risk, but is not liable for =
any damage 
you may sustain as a result of any virus in this e-mail. You should carry=
 out your 
own virus checks before opening the e-mail or attachment. Infosys reserve=
s the 
right to monitor and review the content of all messages sent to or from t=
his e-mail 
address. Messages sent to or from this e-mail address may be stored on th=
e 
Infosys e-mail system.
***INFOSYS******** End of Disclaimer ********INFOSYS***

--_000_82BEC95A68153C46932D3E196B922B7217E7AE57ACBLRKECMBX07ad_
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-mi=
crosoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:wo=
rd" xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:m=3D"htt=
p://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http://www.w3.org=
/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/h=
tml; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word=
 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
p
=09{mso-style-priority:99;
=09mso-margin-top-alt:auto;
=09margin-right:0in;
=09mso-margin-bottom-alt:auto;
=09margin-left:0in;
=09font-size:12.0pt;
=09font-family:"Times New Roman","serif";}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri","sans-serif";}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue v=
link=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi,<o:p></o:=
p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I&#8=
217;m trying to find &nbsp;Testcases for below features on linux using LT=
P,<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p style=3D'ma=
rgin:0in;margin-bottom:.0001pt'>1. <span style=3D'font-size:11.0pt;font-f=
amily:"Calibri","sans-serif";color:black'>UART&nbsp; 6. Ethernet - MAC<o:=
p></o:p></span></p><p style=3D'margin:0in;margin-bottom:.0001pt'>2. <span=
 style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:black=
'>SPI<o:p></o:p></span></p><p style=3D'margin:0in;margin-bottom:.0001pt'>=
3.<span style=3D'font-family:"Calibri","sans-serif";color:black'> </span>=
<span style=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:=
black'>I2C<o:p></o:p></span></p><p class=3DMsoNormal>4. I2S<o:p></o:p></p=
><p style=3D'margin:0in;margin-bottom:.0001pt'>5.<span style=3D'font-fami=
ly:"Calibri","sans-serif";color:black'> </span><span style=3D'font-size:1=
1.0pt;font-family:"Calibri","sans-serif";color:black'>SDIO<o:p></o:p></sp=
an></p><p style=3D'margin:0in;margin-bottom:.0001pt'><span style=3D'font-=
size:11.0pt;font-family:"Calibri","sans-serif";color:black'><o:p>&nbsp;</=
o:p></span></p><p style=3D'margin:0in;margin-bottom:.0001pt'><span style=
=3D'font-size:11.0pt;font-family:"Calibri","sans-serif";color:black'>It w=
ill be great if someone can guide me, to find testcases for above feature=
s.<o:p></o:p></span></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p clas=
s=3DMsoNormal>Regards,<o:p></o:p></p><p class=3DMsoNormal>Pramod<o:p></o:=
p></p></div></body></html>
<table><tr><td bgcolor=3D#ffffff><font color=3D#000000><pre>*************=
*** CAUTION - Disclaimer *****************
This e-mail contains PRIVILEGED AND CONFIDENTIAL INFORMATION intended sol=
ely 
for the use of the addressee(s). If you are not the intended recipient, p=
lease 
notify the sender by e-mail and delete the original message. Further, you=
 are not 
to copy, disclose, or distribute this e-mail or its contents to any other=
 person and 
any such actions are unlawful. This e-mail may contain viruses. Infosys h=
as taken 
every reasonable precaution to minimize this risk, but is not liable for =
any damage 
you may sustain as a result of any virus in this e-mail. You should carry=
 out your 
own virus checks before opening the e-mail or attachment. Infosys reserve=
s the 
right to monitor and review the content of all messages sent to or from t=
his e-mail 
address. Messages sent to or from this e-mail address may be stored on th=
e 
Infosys e-mail system.
***INFOSYS******** End of Disclaimer ********INFOSYS***</pre></font></td>=
</tr></table>

--_000_82BEC95A68153C46932D3E196B922B7217E7AE57ACBLRKECMBX07ad_--


--===============8033379856911659797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
--===============8033379856911659797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8033379856911659797==--

