Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <siva.padhy@lge.com>) id 1VdzTC-0002ox-MY
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 09:32:14 +0000
Received: from lgeamrelo02.lge.com ([156.147.1.126])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VdzTA-0007wj-KN
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 09:32:14 +0000
From: Siva Padhy <siva.padhy@lge.com>
Date: Wed, 6 Nov 2013 18:32:04 +0900
Message-ID: <81212EE27BC298499DBD7CA069AAD071428CD96A47@LGEVEXMBAPSVC2.LGE.NET>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] [PATCH] BindMounts: fix to properly unmount during cleanup in
 fs_bind
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4268433099479628177=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============4268433099479628177==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_81212EE27BC298499DBD7CA069AAD071428CD96A47LGEVEXMBAPSVC_"

--_000_81212EE27BC298499DBD7CA069AAD071428CD96A47LGEVEXMBAPSVC_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

While running fs_bound testcases, some test directory structure are mounted
using -rbind option. While exiting the testcase the umount is not properly
done, hence the below testcase are falling into TWARN.

  fs_bind/test02
  fs_bind/test38

The warning message is as below for respective testcases
  TWARN  :  rbind/test02 did not properly clean up "/tmp/ltp-XXXX9qdYqG/san=
dbox"
  TWARN  :  rbind/test38 did not properly clean up "/tmp/ltp-XXXX9qdYqG/san=
dbox"

This patch unmount all the mounted/submounted parts of the filesystem prope=
rly.

Change-Id: Ica6d1799b89e933587c11c1755dff996ddbdf8c5
Signed-off-by: Siva <siva.padhy@lge.com>
---
testcases/kernel/fs/fs_bind/rbind/test02 |    2 ++
testcases/kernel/fs/fs_bind/rbind/test38 |    5 +++++
2 files changed, 7 insertions(+)

diff --git a/testcases/kernel/fs/fs_bind/rbind/test02 b/testcases/kernel/fs=
/fs_bind/rbind/test02
index 3ab7b6c..eab9cdc 100755
--- a/testcases/kernel/fs/fs_bind/rbind/test02
+++ b/testcases/kernel/fs/fs_bind/rbind/test02
@@ -76,8 +76,10 @@ trap '' ERR
{
               umount parent1/child1/a
               umount parent1/child1/b
+             umount parent2/child2/b
               umount parent1/child1
               umount parent1/child1
+             umount parent2/child2
               umount parent1/child1
               umount parent1/child1
               umount share1
diff --git a/testcases/kernel/fs/fs_bind/rbind/test38 b/testcases/kernel/fs=
/fs_bind/rbind/test38
index c9cf3e1..c944ce5 100755
--- a/testcases/kernel/fs/fs_bind/rbind/test38
+++ b/testcases/kernel/fs/fs_bind/rbind/test38
@@ -77,6 +77,7 @@ trap '' ERR
{
               umount share1/a
               umount parent1/child1/b
+             umount parent2/child1/b
               umount parent2/child1/c
               umount parent1/child1
               umount parent1/child1
@@ -86,6 +87,10 @@ trap '' ERR
               umount parent2
               umount share1
               umount share1
+             umount parent1
+             umount share2
+             umount parent2/child2
+             umount parent2
                rm -rf parent* share*
               cleanup
--
1.7.9.5


--_000_81212EE27BC298499DBD7CA069AAD071428CD96A47LGEVEXMBAPSVC_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><META HTTP-EQUIV=3D"Content-Type" CONTENT=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
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
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>While running fs=
_bound testcases, some test directory structure are mounted<o:p></o:p></p><=
p class=3DMsoNormal>using -rbind option. While exiting the testcase the umo=
unt is not properly<o:p></o:p></p><p class=3DMsoNormal>done, hence the belo=
w testcase are falling into TWARN.<o:p></o:p></p><p class=3DMsoNormal><o:p>=
&nbsp;</o:p></p><p class=3DMsoNormal>&nbsp; fs_bind/test02<o:p></o:p></p><p=
 class=3DMsoNormal>&nbsp; fs_bind/test38<o:p></o:p></p><p class=3DMsoNormal=
><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>The warning message is as below =
for respective testcases<o:p></o:p></p><p class=3DMsoNormal>&nbsp; TWARN&nb=
sp; :&nbsp; rbind/test02 did not properly clean up &quot;/tmp/ltp-XXXX9qdYq=
G/sandbox&quot;<o:p></o:p></p><p class=3DMsoNormal>&nbsp; TWARN&nbsp; :&nbs=
p; rbind/test38 did not properly clean up &quot;/tmp/ltp-XXXX9qdYqG/sandbox=
&quot;<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DM=
soNormal>This patch unmount all the mounted/submounted parts of the filesys=
tem properly.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p cl=
ass=3DMsoNormal>Change-Id: Ica6d1799b89e933587c11c1755dff996ddbdf8c5<o:p></=
o:p></p><p class=3DMsoNormal>Signed-off-by: Siva &lt;siva.padhy@lge.com&gt;=
<o:p></o:p></p><p class=3DMsoNormal>---<o:p></o:p></p><p class=3DMsoNormal>=
 testcases/kernel/fs/fs_bind/rbind/test02 |&nbsp;&nbsp;&nbsp; 2 ++<o:p></o:=
p></p><p class=3DMsoNormal> testcases/kernel/fs/fs_bind/rbind/test38 |&nbsp=
;&nbsp;&nbsp; 5 +++++<o:p></o:p></p><p class=3DMsoNormal> 2 files changed, =
7 insertions(+)<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>diff --git a/testcases/kernel/fs/fs_bind/rbind/test02 b/t=
estcases/kernel/fs/fs_bind/rbind/test02<o:p></o:p></p><p class=3DMsoNormal>=
index 3ab7b6c..eab9cdc 100755<o:p></o:p></p><p class=3DMsoNormal>--- a/test=
cases/kernel/fs/fs_bind/rbind/test02<o:p></o:p></p><p class=3DMsoNormal>+++=
 b/testcases/kernel/fs/fs_bind/rbind/test02<o:p></o:p></p><p class=3DMsoNor=
mal>@@ -76,8 +76,10 @@ trap '' ERR<o:p></o:p></p><p class=3DMsoNormal> {<o:=
p></o:p></p><p class=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount parent1/child1/a<o:p></o=
:p></p><p class=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount parent1/child1/b<o:p></o:p></=
p><p class=3DMsoNormal>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; umount parent2/child2/b<o:p></o:p></p><p class=3DMsoN=
ormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; umount parent1/child1<o:p></o:p></p><p class=3DMsoNormal> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; umount parent1/child1<o:p></o:p></p><p class=3DMsoNormal>+&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount pa=
rent2/child2<o:p></o:p></p><p class=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount parent1/c=
hild1<o:p></o:p></p><p class=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount parent1/child1<o=
:p></o:p></p><p class=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount share1<o:p></o:p></p><p=
 class=3DMsoNormal>diff --git a/testcases/kernel/fs/fs_bind/rbind/test38 b/=
testcases/kernel/fs/fs_bind/rbind/test38<o:p></o:p></p><p class=3DMsoNormal=
>index c9cf3e1..c944ce5 100755<o:p></o:p></p><p class=3DMsoNormal>--- a/tes=
tcases/kernel/fs/fs_bind/rbind/test38<o:p></o:p></p><p class=3DMsoNormal>++=
+ b/testcases/kernel/fs/fs_bind/rbind/test38<o:p></o:p></p><p class=3DMsoNo=
rmal>@@ -77,6 +77,7 @@ trap '' ERR<o:p></o:p></p><p class=3DMsoNormal> {<o:=
p></o:p></p><p class=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount share1/a<o:p></o:p></p><=
p class=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount parent1/child1/b<o:p></o:p></p><p cla=
ss=3DMsoNormal>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; umount parent2/child1/b<o:p></o:p></p><p class=3DMsoNormal> &=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; umount parent2/child1/c<o:p></o:p></p><p class=3DMsoNormal> &nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; umount parent1/child1<o:p></o:p></p><p class=3DMsoNormal> &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umo=
unt parent1/child1<o:p></o:p></p><p class=3DMsoNormal>@@ -86,6 +87,10 @@ tr=
ap '' ERR<o:p></o:p></p><p class=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount parent2<o:p>=
</o:p></p><p class=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount share1<o:p></o:p></p><p cl=
ass=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; umount share1<o:p></o:p></p><p class=3DMsoNormal=
>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
umount parent1<o:p></o:p></p><p class=3DMsoNormal>+&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umount share2<o:p></o:p></=
p><p class=3DMsoNormal>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; umount parent2/child2<o:p></o:p></p><p class=3DMsoNor=
mal>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; umount parent2<o:p></o:p></p><p class=3DMsoNormal> <o:p></o:p></p><p cla=
ss=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rm -rf parent* share*<o:p></o:p></p><p class=
=3DMsoNormal> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; cleanup<o:p></o:p></p><p class=3DMsoNormal>-- <o:p>=
</o:p></p><p class=3DMsoNormal>1.7.9.5<o:p></o:p></p><p class=3DMsoNormal><=
o:p>&nbsp;</o:p></p></div></body></html>=

--_000_81212EE27BC298499DBD7CA069AAD071428CD96A47LGEVEXMBAPSVC_--


--===============4268433099479628177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
--===============4268433099479628177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4268433099479628177==--

