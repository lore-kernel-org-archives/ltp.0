Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Feng.Gao@windriver.com>) id 1OouMf-0002XC-IB
	for ltp-list@lists.sourceforge.net; Fri, 27 Aug 2010 08:32:45 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OouMb-0003ed-TG
	for ltp-list@lists.sourceforge.net; Fri, 27 Aug 2010 08:32:45 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 27 Aug 2010 10:32:32 +0200
Message-ID: <52CF90264091A14888078A031D780F430111B8DA@ism-mail03.corp.ad.wrs.com>
From: "Gao, Feng" <Feng.Gao@windriver.com>
Subject: [LTP] About the cacheflush01 testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7230747700739483500=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: fgao0@windriver.com

This is a multi-part message in MIME format.

--===============7230747700739483500==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CB45C2.64B0EEC1"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB45C2.64B0EEC1
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
In the cacheflush01 testcase, it will check if the return value is =
EINVAL when the argument cache is not one of ICACHE, BCACHE or DCACHE.
=20
But in the latest kernel, the return values of function cacheflush do =
NOT have EINVAL,  it is no consistent with the linux manual.
A related patch about the cacheflush function:
http://lkml.org/lkml/2009/4/9/203
But Ralf had refused this patch:
http://www.spinics.net/lists/linux-man/msg00906.html
=20
When run the ltp, cacheflush01 will fail at MIPS boards. So advice to =
delete the cacheflush01 case.
=20
Thanks,
Feng Gao

------_=_NextPart_001_01CB45C2.64B0EEC1
Content-Type: text/html;
	charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN"><HTML =
DIR=3Dltr><HEAD><META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312"></HEAD><BODY><DIV><FONT face=3D'Arial' color=3D#000000 =
size=3D2>Hi,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>In the cacheflush01 testcase, it will =
check if the =0A=
return value is EINVAL when the argument cache is not one of ICACHE, =
BCACHE or =0A=
DCACHE.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>But&nbsp;in the latest kernel, the =
return values of =0A=
function cacheflush&nbsp;do NOT have EINVAL,&nbsp; it is no consistent =
with the =0A=
linux manual.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>A related patch about the cacheflush =0A=
function:</FONT><BR><A href=3D"http://lkml.org/lkml/2009/4/9/203" =0A=
target=3D_blank>http://lkml.org/lkml/2009/4/9/203</A><BR><FONT =
face=3DArial =0A=
size=3D2>But Ralf had refused this patch:</FONT><BR><A =0A=
href=3D"http://www.spinics.net/lists/linux-man/msg00906.html" =0A=
target=3D_blank>http://www.spinics.net/lists/linux-man/msg00906.html</A><=
/DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>When run the ltp,&nbsp;cacheflush01 =
will&nbsp;fail =0A=
at MIPS boards. So advice to delete the cacheflush01 case.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Thanks,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Feng Gao</FONT></DIV></BODY></HTML>
------_=_NextPart_001_01CB45C2.64B0EEC1--


--===============7230747700739483500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
--===============7230747700739483500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7230747700739483500==--

