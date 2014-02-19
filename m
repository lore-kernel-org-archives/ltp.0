Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <pradeep.bola.ext@nsn.com>) id 1WFwyo-0000yc-KL
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 02:33:46 +0000
Received: from demumfd002.nsn-inter.net ([93.183.12.31])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WFwyn-0006wy-6w
	for ltp-list@lists.sourceforge.net; Wed, 19 Feb 2014 02:33:46 +0000
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
	by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id
	s1J2XZ7X012206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Feb 2014 03:33:36 +0100
Received: from USCHHTC002.nsn-intra.net ([10.159.161.15])
	by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP
	id s1J2XYJb003897
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Feb 2014 03:33:35 +0100
From: "Bola, Pradeep (EXT-Tata Consultancy Ser - US/Arlington Heights)"
	<pradeep.bola.ext@nsn.com>
Date: Wed, 19 Feb 2014 02:33:32 +0000
Message-ID: <D29743B70598864B880A3BE89C6E96946FEA75@USCHMBX004.nsn-intra.net>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Support needed for LINUX POSIX compliance test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1547607761321446741=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============1547607761321446741==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D29743B70598864B880A3BE89C6E96946FEA75USCHMBX004nsnintr_"

--_000_D29743B70598864B880A3BE89C6E96946FEA75USCHMBX004nsnintr_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

We are planning to use LTP for doing POSIX compliance test for one of our p=
roject.
LTP covers most of the LINUX POSIX functions.

But I am unable to test few of the stdio POSIX functionalities.
Few of POSIX functions: atoi, atol, calloc, malloc, free, errno, scanf, spr=
ints, system etc .

Can you please let me know how to verify these stdio commands using LTP?

Also need support for testing POSIX compliance for few of the LINUX command=
s.
POSIX Linux commands: arp, cd, mv, date, echo, file, gdb, kill etc.

Regards,
Pradeep Bola




--_000_D29743B70598864B880A3BE89C6E96946FEA75USCHMBX004nsnintr_
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
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<div>Hi,</div>
<div>&nbsp;</div>
<div>We are planning to use LTP for doing POSIX compliance test for one of =
our project.</div>
<div>LTP covers most of the LINUX POSIX functions.</div>
<div>&nbsp;</div>
<div>But I am unable to test few of the stdio POSIX functionalities.</div>
<div>Few of POSIX functions: atoi, atol, calloc, malloc, free, errno, scanf=
, sprints, system etc .</div>
<div>&nbsp;</div>
<div>Can you please let me know how to verify these stdio commands using LT=
P?</div>
<div>&nbsp;</div>
<div>Also need support for testing POSIX compliance for few of the LINUX co=
mmands.</div>
<div>POSIX Linux commands: arp, cd, mv, date, echo, file, gdb, kill etc. </=
div>
<div>&nbsp;</div>
<div>Regards,</div>
<div>Pradeep Bola</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
</span></font>
</body>
</html>

--_000_D29743B70598864B880A3BE89C6E96946FEA75USCHMBX004nsnintr_--


--===============1547607761321446741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
--===============1547607761321446741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1547607761321446741==--

