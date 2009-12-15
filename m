Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <nobuhiro@andestech.com>) id 1NKSZP-0007lr-SK
	for ltp-list@lists.sourceforge.net; Tue, 15 Dec 2009 08:15:47 +0000
Received: from 59-124-160-117.hinet-ip.hinet.net ([59.124.160.117]
	helo=ATCPCS06.andestech.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NKSZH-0003mK-L3
	for ltp-list@lists.sourceforge.net; Tue, 15 Dec 2009 08:15:47 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 15 Dec 2009 16:02:58 +0800
Message-ID: <50FD90C65C53FB45BADEEBCD84FF07F201E9A299@ATCPCS06.andestech.com>
From: <nobuhiro@andestech.com>
Subject: [LTP] SHMLBA alignment issue on shmat01 and shmat02
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0890534133716499202=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0890534133716499202==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA7D5C.FA2CACE9"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA7D5C.FA2CACE9
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

I have a question about the SHMLBA alignment on shmat01 and shmat02.
At the end of setup():
        /* some architectures (e.g. parisc) are strange, so better =
always align to
         * next SHMLBA address. */
        base_addr =3D
            (void *)(((unsigned long)(base_addr) + (SHMLBA - 1)) &
                     ~(SHMLBA - 1));

This is what I think, please correct if I'm wrong.
Since shmget() creates the region of a multiple of PAGE_SIZE, the =
base_addr after SHMLBA alignment does not guarantee to be available.
Furthermore, it should be kernel architecture code to take care of the =
D-cache aliasing issue, just like SPARC, ARM, MIPS do.
=20
Thanks.
Nobuhiro

------_=_NextPart_001_01CA7D5C.FA2CACE9
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.6000.16945" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D804080207-15122009><FONT face=3DArial>I have a =
question about the=20
SHMLBA alignment on shmat01 and shmat02.</FONT></SPAN></DIV>
<DIV><SPAN class=3D804080207-15122009><FONT face=3DArial>At the end of=20
setup():</FONT></SPAN></DIV>
<DIV><SPAN class=3D804080207-15122009><FONT=20
face=3DArial>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* some =
architectures=20
(e.g. parisc) are strange, so better always align=20
to<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * next SHMLBA =
address.=20
*/<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; base_addr=20
=3D<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 (void=20
*)(((unsigned long)(base_addr) + (SHMLBA - 1))=20
&amp;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
~(SHMLBA - 1));<BR></FONT></SPAN></DIV>
<DIV><SPAN class=3D804080207-15122009><FONT face=3DArial>This is what I =
think,=20
please correct if I'm wrong.</FONT></SPAN></DIV>
<DIV><SPAN class=3D804080207-15122009><FONT face=3DArial>Since =
shmget()&nbsp;creates=20
the region of a multiple of PAGE_SIZE, </FONT></SPAN><SPAN=20
class=3D804080207-15122009><FONT face=3DArial>t</FONT></SPAN><SPAN=20
class=3D804080207-15122009><FONT face=3DArial>he base_addr after SHMLBA =
alignment=20
does not guarantee to be available.</FONT></SPAN></DIV>
<DIV><SPAN class=3D804080207-15122009><FONT face=3DArial>Furthermore, it =
should be=20
kernel architecture code to take care of the D-cache aliasing issue, =
just like=20
SPARC, ARM, MIPS do.</FONT></SPAN></DIV>
<DIV><SPAN class=3D804080207-15122009><FONT =
face=3DArial></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D804080207-15122009><FONT =
face=3DArial>Thanks.</FONT></SPAN></DIV>
<DIV><SPAN class=3D804080207-15122009><FONT=20
face=3DArial>Nobuhiro</DIV></FONT></SPAN></BODY></HTML>

------_=_NextPart_001_01CA7D5C.FA2CACE9--


--===============0890534133716499202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

--===============0890534133716499202==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0890534133716499202==--

