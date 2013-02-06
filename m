Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rmsrox@yahoo.co.in>) id 1U3CUg-0007vV-VY
	for ltp-list@lists.sourceforge.net; Wed, 06 Feb 2013 21:25:27 +0000
Received: from nm13-vm7.bullet.mail.sg3.yahoo.com ([106.10.149.22])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1U3CUf-0005Oy-E9
	for ltp-list@lists.sourceforge.net; Wed, 06 Feb 2013 21:25:26 +0000
Message-ID: <1360185916.37504.YahooMailNeo@web193606.mail.sg3.yahoo.com>
Date: Thu, 7 Feb 2013 05:25:16 +0800 (SGT)
From: Ranjeet Sangle <rmsrox@yahoo.co.in>
MIME-Version: 1.0
Subject: [LTP] Cross compiling Open Posix testsuite
Reply-To: Ranjeet Sangle <rmsrox@yahoo.co.in>
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1534673301089911159=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============1534673301089911159==
Content-Type: multipart/alternative;
	boundary="-1007894763-1358373329-1360185916=:37504"

---1007894763-1358373329-1360185916=:37504
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all,=0A=0AFirst question on this forum, so please be nice if I haven'=
t included any relevant info :).=0A=0AI am trying to cross compile Open Pos=
ix testsuite (located at=A0ltp-full-20130109/testcases/open_posix_testsuite=
 ) on x86 machine for a mips32 machine. I haven't found any way to do this,=
 most of the material in the directory describes how to build and run on th=
e machine. My target machine does not support the build tools (like make), =
hence I have no option but to compile it on a x86 machine and then port it =
over to the mips32 machine.=0A=0AAny pointers would be appreciated.=A0=0A=
=0A=0AThanks,=0ARanjeet
---1007894763-1358373329-1360185916=:37504
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:10pt"><div>Hello all,</div>=
<div><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13px; font-fam=
ily: 'times new roman', 'new york', times, serif; background-color: transpa=
rent; font-style: normal;">First question on this forum, so please be nice =
if I haven't included any relevant info :).</div><div style=3D"color: rgb(0=
, 0, 0); font-size: 13px; font-family: 'times new roman', 'new york', times=
, serif; background-color: transparent; font-style: normal;"><br></div><div=
 style=3D"color: rgb(0, 0, 0); font-size: 13px; font-family: 'times new rom=
an', 'new york', times, serif; background-color: transparent; font-style: n=
ormal;">I am trying to cross compile Open Posix testsuite (located at&nbsp;=
ltp-full-20130109/testcases/open_posix_testsuite ) on x86 machine for a mip=
s32 machine. I haven't found any way to do this, most of the material in th=
e
 directory describes how to build and run on the machine. My target machine=
 does not support the build tools (like make), hence I have no option but t=
o compile it on a x86 machine and then port it over to the mips32 machine.<=
/div><div style=3D"color: rgb(0, 0, 0); font-size: 13px; font-family: 'time=
s new roman', 'new york', times, serif; background-color: transparent; font=
-style: normal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13=
px; font-family: 'times new roman', 'new york', times, serif; background-co=
lor: transparent; font-style: normal;"><span style=3D"background-color: tra=
nsparent;">Any pointers would be appreciated.&nbsp;</span><br></div><div st=
yle=3D"color: rgb(0, 0, 0); font-size: 13px; font-family: 'times new roman'=
, 'new york', times, serif; background-color: transparent; font-style: norm=
al;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13px; font-fam=
ily: 'times new roman', 'new york', times, serif; background-color:
 transparent; font-style: normal;">Thanks,</div><div style=3D"color: rgb(0,=
 0, 0); font-size: 13px; font-family: 'times new roman', 'new york', times,=
 serif; background-color: transparent; font-style: normal;">Ranjeet</div></=
div></body></html>
---1007894763-1358373329-1360185916=:37504--


--===============1534673301089911159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
--===============1534673301089911159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1534673301089911159==--

