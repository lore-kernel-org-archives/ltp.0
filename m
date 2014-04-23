Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <qutherond@adeneo-embedded.com>) id 1WczBb-00045c-U2
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 15:34:11 +0000
Received: from smtp.adetelgroup.com ([94.247.26.71] helo=hbg-pa71.hmc-pa.adm)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WczBZ-0001KK-Mr
	for ltp-list@lists.sourceforge.net; Wed, 23 Apr 2014 15:34:11 +0000
Received: from localhost (localhost [127.0.0.1])
	by hbg-pa71.hmc-pa.adm (Postfix) with ESMTP id 8108C4384D
	for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Apr 2014 17:24:42 +0200 (CEST)
Received: from hbg-pa71.hmc-pa.adm ([127.0.0.1])
	by localhost (hbg-pa71.hmc-pa.adm [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id jEOZ5KvZCYD0 for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Apr 2014 17:24:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by hbg-pa71.hmc-pa.adm (Postfix) with ESMTP id 538B6438F7
	for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Apr 2014 17:24:34 +0200 (CEST)
Received: from hbg-pa71.hmc-pa.adm ([127.0.0.1])
	by localhost (hbg-pa71.hmc-pa.adm [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1oKgGv1ZQ-8f for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Apr 2014 17:24:34 +0200 (CEST)
Received: from hbg-pa73.hmc-pa.adm (unknown [10.210.21.2])
	by hbg-pa71.hmc-pa.adm (Postfix) with ESMTP id 33BED4384D
	for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Apr 2014 17:24:34 +0200 (CEST)
Date: Wed, 23 Apr 2014 17:24:31 +0200 (CEST)
From: THEROND Quentin <qutherond@adeneo-embedded.com>
Message-ID: <522788825.306663.1398266671270.JavaMail.zimbra@adeneo-embedded.com>
In-Reply-To: <1271937164.305548.1398266180588.JavaMail.zimbra@adeneo-embedded.com>
References: <1271937164.305548.1398266180588.JavaMail.zimbra@adeneo-embedded.com>
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
Content-Type: multipart/mixed; boundary="===============1316949681635605167=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1316949681635605167==
Content-Type: multipart/alternative; 
	boundary="----=_Part_306662_1073453496.1398266671269"

------=_Part_306662_1073453496.1398266671269
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


------=_Part_306662_1073453496.1398266671269
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><div><span style=3D"font-family: 'Tim=
es New Roman', serif; font-size: 12pt; background-color: rgb(253, 253, 253)=
;">hello,</span></div><div style=3D"color:#000;font-weight:normal;font-styl=
e:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-s=
ize:12pt;"><div style=3D"font-family: times new roman, new york, times, ser=
if; font-size: 12pt; color: #000000"><div style=3D"font-family: 'Times New =
Roman'; font-size: 13px; background-color: #fdfdfd;"><p style=3D"margin: 0p=
x; font-size: 12pt; font-family: 'Times New Roman', serif;">&nbsp;</p><p st=
yle=3D"margin: 0px; font-size: 12pt; font-family: 'Times New Roman', serif;=
">I working on ltp-ddt and i have a problem. If i launch &lt;&lt;./runltp -=
f ddt/usb_stress_io&gt;&gt; on BEAGLEBONE the test PASS but if i launch a s=
ame command on BEAGLEBOARD the test FAIL. LTP-DDT return:</p><p style=3D"ma=
rgin: 0px; font-size: 12pt; font-family: 'Times New Roman', serif;"><br>sh:=
 1: source: not found<br>sh: 1: do_cmd: not found<br>sh: 1: check_config_op=
tions: not found<br>sh: 1: do_cmd: not found</p><p style=3D"margin: 0px; fo=
nt-size: 12pt; font-family: 'Times New Roman', serif;">&nbsp;</p><p style=
=3D"margin: 0px; font-size: 12pt; font-family: 'Times New Roman', serif;">C=
an you help me?</p><p style=3D"margin: 0px; font-size: 12pt; font-family: '=
Times New Roman', serif;">&nbsp;</p><p style=3D"margin: 0px; font-size: 12p=
t; font-family: 'Times New Roman', serif;">Thank you,</p><p style=3D"margin=
: 0px; font-size: 12pt; font-family: 'Times New Roman', serif;">&nbsp;</p><=
p style=3D"margin: 0px; font-size: 12pt; font-family: 'Times New Roman', se=
rif;">THEROND Quentin</p></div></div></div><div><br></div></div></body></ht=
ml>
------=_Part_306662_1073453496.1398266671269--


--===============1316949681635605167==
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
--===============1316949681635605167==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1316949681635605167==--

