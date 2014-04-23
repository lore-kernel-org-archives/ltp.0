Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <qutherond@adeneo-embedded.com>) id 1WczBb-0006fT-3n
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 15:34:11 +0000
Received: from smtp.adetelgroup.com ([94.247.26.71] helo=hbg-pa71.hmc-pa.adm)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WczBZ-0000Lk-Nq
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 15:34:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by hbg-pa71.hmc-pa.adm (Postfix) with ESMTP id 77A174384A
	for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Apr 2014 17:16:31 +0200 (CEST)
Received: from hbg-pa71.hmc-pa.adm ([127.0.0.1])
	by localhost (hbg-pa71.hmc-pa.adm [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id UT3vQc1vuH8x for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Apr 2014 17:16:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by hbg-pa71.hmc-pa.adm (Postfix) with ESMTP id A2D3F43890
	for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Apr 2014 17:16:23 +0200 (CEST)
Received: from hbg-pa71.hmc-pa.adm ([127.0.0.1])
	by localhost (hbg-pa71.hmc-pa.adm [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6u5wk3-ehQR0 for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Apr 2014 17:16:23 +0200 (CEST)
Received: from hbg-pa73.hmc-pa.adm (unknown [10.210.21.2])
	by hbg-pa71.hmc-pa.adm (Postfix) with ESMTP id 7EFE743858
	for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Apr 2014 17:16:23 +0200 (CEST)
Date: Wed, 23 Apr 2014 17:16:20 +0200 (CEST)
From: THEROND Quentin <qutherond@adeneo-embedded.com>
Message-ID: <1271937164.305548.1398266180588.JavaMail.zimbra@adeneo-embedded.com>
MIME-Version: 1.0
Subject: [LTP] ltp-ddt issue
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2558222114816574302=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2558222114816574302==
Content-Type: multipart/alternative; 
	boundary="----=_Part_305547_667179393.1398266180588"

------=_Part_305547_667179393.1398266180588
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit



hello, 




I working on ltp-ddt and i have a problem. If i launch <<./runltp -f ddt/usb_stress_io>> on BEAGLEBONE the test PASS but if i launch a same command on BEAGLEBOARD the test FAIL. LTP-DDT return: 


sh: 1: source: not found 
sh: 1: do_cmd: not found 
sh: 1: check_config_options: not found 
sh: 1: do_cmd: not found 



Can you help me? 



Thank you, 



THEROND Quentin 

------=_Part_305547_667179393.1398266180588
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><div style=3D"font-family: 'Time=
s New Roman'; font-size: 13px; background-color: #fdfdfd;" data-mce-style=
=3D"font-family: 'Times New Roman'; font-size: 13px; background-color: #fdf=
dfd;"><p style=3D"margin: 0px; font-size: 12pt; font-family: 'Times New Rom=
an', serif;" data-mce-style=3D"margin: 0px; font-size: 12pt; font-family: '=
Times New Roman', serif;">hello,</p></div><div style=3D"font-family: 'Times=
 New Roman'; font-size: 13px; background-color: #fdfdfd;" data-mce-style=3D=
"font-family: 'Times New Roman'; font-size: 13px; background-color: #fdfdfd=
;"><p style=3D"margin: 0px; font-size: 12pt; font-family: 'Times New Roman'=
, serif;" data-mce-style=3D"margin: 0px; font-size: 12pt; font-family: 'Tim=
es New Roman', serif;">&nbsp;</p><p style=3D"margin: 0px; font-size: 12pt; =
font-family: 'Times New Roman', serif;" data-mce-style=3D"margin: 0px; font=
-size: 12pt; font-family: 'Times New Roman', serif;">I working on ltp-ddt a=
nd i have a problem. If i launch &lt;&lt;./runltp -f ddt/usb_stress_io&gt;&=
gt; on BEAGLEBONE the test PASS but if i launch a same command on BEAGLEBOA=
RD the test FAIL. LTP-DDT return:</p><p style=3D"margin: 0px; font-size: 12=
pt; font-family: 'Times New Roman', serif;" data-mce-style=3D"margin: 0px; =
font-size: 12pt; font-family: 'Times New Roman', serif;"><br>sh: 1: source:=
 not found<br>sh: 1: do_cmd: not found<br>sh: 1: check_config_options: not =
found<br>sh: 1: do_cmd: not found</p><p style=3D"margin: 0px; font-size: 12=
pt; font-family: 'Times New Roman', serif;" data-mce-style=3D"margin: 0px; =
font-size: 12pt; font-family: 'Times New Roman', serif;">&nbsp;</p><p style=
=3D"margin: 0px; font-size: 12pt; font-family: 'Times New Roman', serif;" d=
ata-mce-style=3D"margin: 0px; font-size: 12pt; font-family: 'Times New Roma=
n', serif;">Can you help me?</p><p style=3D"margin: 0px; font-size: 12pt; f=
ont-family: 'Times New Roman', serif;" data-mce-style=3D"margin: 0px; font-=
size: 12pt; font-family: 'Times New Roman', serif;">&nbsp;</p><p style=3D"m=
argin: 0px; font-size: 12pt; font-family: 'Times New Roman', serif;" data-m=
ce-style=3D"margin: 0px; font-size: 12pt; font-family: 'Times New Roman', s=
erif;">Thank you,</p><p style=3D"margin: 0px; font-size: 12pt; font-family:=
 'Times New Roman', serif;" data-mce-style=3D"margin: 0px; font-size: 12pt;=
 font-family: 'Times New Roman', serif;">&nbsp;</p><p style=3D"margin: 0px;=
 font-size: 12pt; font-family: 'Times New Roman', serif;" data-mce-style=3D=
"margin: 0px; font-size: 12pt; font-family: 'Times New Roman', serif;">THER=
OND Quentin</p></div></div></div></body></html>
------=_Part_305547_667179393.1398266180588--


--===============2558222114816574302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
--===============2558222114816574302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2558222114816574302==--

