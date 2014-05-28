Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Diwakar.Sharma@in.bosch.com>) id 1WpVwD-0000ey-0n
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 04:58:05 +0000
Received: from smtp6-v.fe.bosch.de ([139.15.237.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WpVw9-00042a-BY
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 04:58:04 +0000
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta24.fe.bosch.de (Postfix) with ESMTP id E7C1DD8009E
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 May 2014 06:57:53 +0200 (CEST)
Received: from localhost (vsgw21.fe.internet.bosch.com [10.4.98.19])
	by vsmta12.fe.internet.bosch.com (Postfix) with SMTP id CB4BA1B8069F
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 May 2014 06:57:53 +0200 (CEST)
From: "Diwakar Sharma (RBEI/ECF3)" <Diwakar.Sharma@in.bosch.com>
Date: Wed, 28 May 2014 12:57:24 +0800
Message-ID: <46CD92664333704E8A06E512A60A9E9F2AD435E199@SGPMBX02.APAC.bosch.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] mknodat01 fails at chown
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8920310346242836877=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============8920310346242836877==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_46CD92664333704E8A06E512A60A9E9F2AD435E199SGPMBX02APACb_"

--_000_46CD92664333704E8A06E512A60A9E9F2AD435E199SGPMBX02APACb_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

I am running the ltp suite on a target with kernel 3.8.13.23 , and mknodat0=
1 test is failing with below error. The problem are the numeric uid/gid. Be=
fore running tests the uid/gid are shown as 'root'

oracle-virtualbox:/opt/ltp/testcases/bin# ls -ltr mknodat*
-rwxrwxr-x 1 root root 87187 May 26 08:10 mknodat01

After running the suite:

oracle-virtualbox:/opt/ltp/testcases/bin# ls -ltr mknodat*
-rwxrwxr-x 1 42949672 42949672 87187 May 26 08:10 mknodat01
oracle-virtualbox:/opt/ltp/testcases/bin# chown root mknodat01
NFS: v4 server xxx.xxx.x.xx does not support accept raw uid/gids. Reenablin=
g the idmapper
chown: mknodat01: Invalid argument

So by the time mknodat01 executes , the uid/gid are already changed to nume=
ric and hence chown fails.
Not getting why it is getting changed, probably some other test code is doi=
ng something?
Any suggestion/solution?

Thanks and Regards
Diwakar Sharma




--_000_46CD92664333704E8A06E512A60A9E9F2AD435E199SGPMBX02APACb_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Calibri, sans-serif" size=3D"2">
<div>Hi,</div>
<div>&nbsp;</div>
<div>I am running the ltp suite on a target with kernel 3.8.13.23 , and mkn=
odat01 test is failing with below error. The problem are the numeric uid/gi=
d. Before running tests the uid/gid are shown as &#8216;root&#8217;</div>
<div><font face=3D"Times New Roman, serif">&nbsp;</font></div>
<div><font face=3D"Arial, sans-serif" size=3D"2" color=3D"#632423">oracle-v=
irtualbox:/opt/ltp/testcases/bin# ls -ltr mknodat*
<br>

-rwxrwxr-x 1 <font color=3D"#FF0000">root</font><font color=3D"#FF0000"> </=
font><font color=3D"#FF0000">root</font> 87187 May 26 08:10 mknodat01</font=
></div>
<div><font face=3D"Times New Roman, serif" color=3D"#632423">&nbsp;</font><=
/div>
<div>After running the suite:</div>
<div><font face=3D"Times New Roman, serif" color=3D"#632423">&nbsp;</font><=
/div>
<div><font face=3D"Arial, sans-serif" size=3D"2" color=3D"#632423">oracle-v=
irtualbox:/opt/ltp/testcases/bin# ls -ltr mknodat*
<br>

-rwxrwxr-x 1 <font color=3D"#FF0000">42949672 42949672</font> 87187 May 26 =
08:10 mknodat01
<br>

oracle-virtualbox:/opt/ltp/testcases/bin# chown root mknodat01 <br>

NFS: v4 server <i>xxx.xxx.x.xx</i> does not support accept raw uid/gids. Re=
enabling the idmapper
<br>

chown: mknodat01: Invalid argument </font></div>
<div><font face=3D"Times New Roman, serif">&nbsp;</font></div>
<div>So by the time mknodat01 executes , the uid/gid are already changed to=
 numeric and hence chown fails.</div>
<div>Not getting why it is getting changed, probably some other test code i=
s doing something?</div>
<div>Any suggestion/solution?</div>
<div><font face=3D"Times New Roman, serif">&nbsp;</font></div>
<div><font face=3D"Aparajita, sans-serif" size=3D"4" color=3D"#002060">Than=
ks and Regards</font></div>
<div><font face=3D"Aparajita, sans-serif" size=3D"4" color=3D"#002060"><b>D=
iwakar Sharma</b></font></div>
<div><font face=3D"Times New Roman, serif">&nbsp;</font></div>
<div><font face=3D"Times New Roman, serif">&nbsp;</font></div>
<div><font face=3D"Times New Roman, serif">&nbsp;</font></div>
</font>
</body>
</html>

--_000_46CD92664333704E8A06E512A60A9E9F2AD435E199SGPMBX02APACb_--



--===============8920310346242836877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
--===============8920310346242836877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8920310346242836877==--


