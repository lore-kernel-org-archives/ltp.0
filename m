Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jungsoo.son@lge.com>) id 1Ueicx-000476-OG
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 09:13:03 +0000
Received: from lgemrelse7q.lge.com ([156.147.1.151])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ueicv-0004cH-TL
	for ltp-list@lists.sourceforge.net; Tue, 21 May 2013 09:13:03 +0000
From: "Jungsoo Son" <jungsoo.son@lge.com>
Date: Tue, 21 May 2013 17:57:45 +0900
Message-ID: <006901ce5601$42cc89e0$c8659da0$@lge.com>
MIME-Version: 1.0
Content-Language: ko
Subject: [LTP] [PATCH] Makefile: Disable parallel build for
	$(CRITICAL_MAKEFILES)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5499732015535617544=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multipart message in MIME format.

--===============5499732015535617544==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_006A_01CE564C.B2B4F530"
Content-Language: ko

This is a multipart message in MIME format.

------=_NextPart_000_006A_01CE564C.B2B4F530
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

This patch fixes parallel build error. When use parallel build

with -j16 or -j8, $(CRITICAL_MAKEFILES) are created as empty file

because generate-makefiles is called several times. So need to

disable parallel build.

The following code can guarantee sequencial building.

.NOTPARALLEL: $(CRITICAL_MAKEFILES)

 

Signed-off-by: jungsoo.son <jungsoo.son@lge.com>

---

testcases/open_posix_testsuite/Makefile |    2 ++

1 file changed, 2 insertions(+)

 

diff --git a/testcases/open_posix_testsuite/Makefile
b/testcases/open_posix_testsuite/Makefile

index 9c61fa4..bce5cf3 100644

--- a/testcases/open_posix_testsuite/Makefile

+++ b/testcases/open_posix_testsuite/Makefile

@@ -110,5 +110,7 @@ $(CRITICAL_MAKEFILES): \

     $(top_srcdir)/LDLIBS

         @$(MAKE) generate-makefiles

+.NOTPARALLEL: $(CRITICAL_MAKEFILES)

+

#tests-pretty:

#        $(MAKE) all | column -t -s:

-- 

1.7.9.5


------=_NextPart_000_006A_01CE564C.B2B4F530
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 14 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
@font-face
	{font-family:"Malgun Gothic";
	panose-1:2 11 5 3 2 0 0 2 0 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	text-autospace:none;
	word-break:break-hangul;
	font-size:10.0pt;
	font-family:"Malgun Gothic";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Malgun Gothic";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Malgun Gothic";}
/* Page Definitions */
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:3.0cm 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DKO link=3Dblue =
vlink=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal><span =
lang=3DEN-US>This patch fixes parallel build error. When use parallel =
build<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>with =
-j16 or -j8, $(CRITICAL_MAKEFILES) are created as empty =
file<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>because generate-makefiles is called several times. So need =
to<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>disable =
parallel build.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>The following code can guarantee sequencial =
building.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>.NOTPARALLEL: $(CRITICAL_MAKEFILES)<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>Signed-off-by: jungsoo.son =
&lt;jungsoo.son@lge.com&gt;<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>---<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> =
testcases/open_posix_testsuite/Makefile |&nbsp;&nbsp;&nbsp; 2 =
++<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US> 1 file =
changed, 2 insertions(+)<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>diff --git a/testcases/open_posix_testsuite/Makefile =
b/testcases/open_posix_testsuite/Makefile<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>index 9c61fa4..bce5cf3 =
100644<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>--- =
a/testcases/open_posix_testsuite/Makefile<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+++ =
b/testcases/open_posix_testsuite/Makefile<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>@@ -110,5 +110,7 @@ =
$(CRITICAL_MAKEFILES): \<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>&nbsp;&nbsp;&nbsp;&nbsp; =
$(top_srcdir)/LDLIBS<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; @$(MAKE) =
generate-makefiles<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> <o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+.NOTPARALLEL: =
$(CRITICAL_MAKEFILES)<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> #tests-pretty:<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> =
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(MAKE) all | column -t =
-s:<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>-- =
<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>1.7.9.5<o:p></o:p></span></p></div></body></html>
------=_NextPart_000_006A_01CE564C.B2B4F530--



--===============5499732015535617544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
--===============5499732015535617544==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5499732015535617544==--


