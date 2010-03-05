Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Kiran.Girmaji@emerson.com>) id 1NnW9i-0005Rm-Pa
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 11:57:22 +0000
Received: from usstlz-psecap04.emerson.com ([144.191.128.16]
	helo=USSTLZ-PSECAP05.EMERSON.COM)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NnW9i-0004OX-1J
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 11:57:22 +0000
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 5 Mar 2010 19:41:11 +0800
Message-ID: <89D32649C0790143AB985A5BF77A104F02F4E803@etsmsg-hkexm05.etsmsg.org>
From: <Kiran.Girmaji@Emerson.com>
Subject: [LTP] clock_getres01 test fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8235061068676712611=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8235061068676712611==
Content-Class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CABC58.E1558798"

------_=_NextPart_001_01CABC58.E1558798
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
While running LTP-20091231,  clock_getres01 test fails on my target with
following output -
=20
Could anyone tell me a reason for this?
=20
tag=3Dclock_getres01 stime=3D1105549839
cmdline=3D"clock_getres01"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
RESULT: return value(ret)=3D       0 errno=3D0 (Success)
EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
RESULT: return value(ret)=3D       0 errno=3D0 (Success)
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
EXPECT: return value(ret)=3D0 errno=3D0 (Success)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
EXPECT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
RESULT: return value(ret)=3D-1 errno=3D22 (Invalid argument)
EXPECT: return value(ret)=3D(N >=3D 0) errno=3D0 (Success)
RESULT: return value(ret)=3D       0 errno=3D0 (Success)
clock_getres01    0  TINFO  :  (case00) START
clock_getres01    1  TPASS  :  (case00) END
clock_getres01    0  TINFO  :  (case01) START
clock_getres01    2  TPASS  :  (case01) END
clock_getres01    0  TINFO  :  (case02) START
clock_getres01    3  TFAIL  :  (case02) END
clock_getres01    0  TINFO  :  (case03) START
clock_getres01    4  TFAIL  :  (case03) END
clock_getres01    0  TINFO  :  (case04) START
clock_getres01    5  TPASS  :  (case04) END
clock_getres01    0  TINFO  :  (case05) START
clock_getres01    6  TPASS  :  (case05) END
clock_getres01    7  TFAIL  :  clock_getres01 failed: errno=3D???(0):
Success
NG
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>


------_=_NextPart_001_01CABC58.E1558798
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16981" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D054523711-05032010>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D054523711-05032010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D054523711-05032010>While =
running=20
LTP-20091231, &nbsp;clock_getres01 test fails on my target with =
following output=20
-</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D054523711-05032010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D054523711-05032010>Could =
anyone tell me=20
a reason for this?</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D054523711-05032010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D054523711-05032010>tag=3Dclock_getres01=20
stime=3D1105549839<BR>cmdline=3D"clock_getres01"<BR>contacts=3D""<BR>anal=
ysis=3Dexit<BR>&lt;&lt;&lt;test_output&gt;&gt;&gt;<BR>EXPECT:=20
return value(ret)=3D(N &gt;=3D 0) errno=3D0 (Success)<BR>RESULT: return=20
value(ret)=3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 errno=3D0 =
(Success)<BR>EXPECT:=20
return value(ret)=3D(N &gt;=3D 0) errno=3D0 (Success)<BR>RESULT: return=20
value(ret)=3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 errno=3D0 =
(Success)<BR>EXPECT:=20
return value(ret)=3D0 errno=3D0 (Success)<BR>RESULT: return =
value(ret)=3D-1 errno=3D22=20
(Invalid argument)<BR>EXPECT: return value(ret)=3D0 errno=3D0 =
(Success)<BR>RESULT:=20
return value(ret)=3D-1 errno=3D22 (Invalid argument)<BR>EXPECT: return =
value(ret)=3D-1=20
errno=3D22 (Invalid argument)<BR>RESULT: return value(ret)=3D-1 =
errno=3D22 (Invalid=20
argument)<BR>EXPECT: return value(ret)=3D(N &gt;=3D 0) errno=3D0 =
(Success)<BR>RESULT:=20
return value(ret)=3D&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0 errno=3D0=20
(Success)<BR>clock_getres01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; =
:&nbsp;=20
(case00) START<BR>clock_getres01&nbsp;&nbsp;&nbsp; 1&nbsp; TPASS&nbsp; =
:&nbsp;=20
(case00) END<BR>clock_getres01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; =
:&nbsp;=20
(case01) START<BR>clock_getres01&nbsp;&nbsp;&nbsp; 2&nbsp; TPASS&nbsp; =
:&nbsp;=20
(case01) END<BR>clock_getres01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; =
:&nbsp;=20
(case02) START<BR>clock_getres01&nbsp;&nbsp;&nbsp; 3&nbsp; TFAIL&nbsp; =
:&nbsp;=20
(case02) END<BR>clock_getres01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; =
:&nbsp;=20
(case03) START<BR>clock_getres01&nbsp;&nbsp;&nbsp; 4&nbsp; TFAIL&nbsp; =
:&nbsp;=20
(case03) END<BR>clock_getres01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; =
:&nbsp;=20
(case04) START<BR>clock_getres01&nbsp;&nbsp;&nbsp; 5&nbsp; TPASS&nbsp; =
:&nbsp;=20
(case04) END<BR>clock_getres01&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; =
:&nbsp;=20
(case05) START<BR>clock_getres01&nbsp;&nbsp;&nbsp; 6&nbsp; TPASS&nbsp; =
:&nbsp;=20
(case05) END<BR>clock_getres01&nbsp;&nbsp;&nbsp; 7&nbsp; TFAIL&nbsp; =
:&nbsp;=20
clock_getres01 failed: errno=3D???(0):=20
Success<BR>NG<BR>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<BR>initiation_s=
tatus=3D"ok"<BR>duration=3D0=20
termination_type=3Dexited termination_id=3D1 corefile=3Dno<BR>cutime=3D0 =

cstime=3D0<BR>&lt;&lt;&lt;test_end&gt;&gt;&gt;<BR></SPAN></FONT></DIV></B=
ODY></HTML>

------_=_NextPart_001_01CABC58.E1558798--


--===============8235061068676712611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============8235061068676712611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8235061068676712611==--

