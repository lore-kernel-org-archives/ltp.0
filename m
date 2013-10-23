Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hong.gyu.kim@lge.com>) id 1VYoB1-0002ci-MX
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 02:28:03 +0000
Received: from lgemrelse7q.lge.com ([156.147.1.151])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VYoAy-0006Pm-SM
	for ltp-list@lists.sourceforge.net; Wed, 23 Oct 2013 02:28:03 +0000
From: "Honggyu Kim" <hong.gyu.kim@lge.com>
Date: Wed, 23 Oct 2013 11:12:46 +0900
Message-ID: <00f001cecf95$5d8754f0$1895fed0$@gyu.kim@lge.com>
MIME-Version: 1.0
Content-Language: ko
Subject: [LTP] [PATCH] getcontext01: fix to check libc version for ARM
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7895589006477471904=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============7895589006477471904==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00F1_01CECFE0.CD6EFCF0"
Content-Language: ko

This is a multi-part message in MIME format.

------=_NextPart_000_00F1_01CECFE0.CD6EFCF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

getcontext function is implemented from libc-2.17 in ARM.

If libc version is less than 2.17, this testcase goes to TCONF.

 

lib/tst_libcvercmp.c: a new file for libc version comparison

Comparison code for libc version is added as a library.

 

Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>

---

include/test.h                                     |    4 ++

lib/tst_libcvercmp.c                               |   65
++++++++++++++++++++

.../kernel/syscalls/getcontext/getcontext01.c      |   16 +++++

3 files changed, 85 insertions(+)

create mode 100644 lib/tst_libcvercmp.c

 

diff --git a/include/test.h b/include/test.h

index d9eba31..47765c2 100644

--- a/include/test.h

+++ b/include/test.h

@@ -180,6 +180,10 @@ struct tst_kern_exv {

 int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers);

+/* lib/tst_libcvercmp.c */

+const char* tst_getlibcver(void);

+int tst_libcvercmp(const char *tst_exv);

+

/* lib/tst_is_cwd.c */

int tst_is_cwd_nfs(void);

int tst_is_cwd_v9fs(void);

diff --git a/lib/tst_libcvercmp.c b/lib/tst_libcvercmp.c

new file mode 100644

index 0000000..2a09ab8

--- /dev/null

+++ b/lib/tst_libcvercmp.c

@@ -0,0 +1,65 @@

+/*

+ *

+ *   Copyright (c) LG Electronics Corp., 2013

+ *

+ *   This program is free software;  you can redistribute it and/or modify

+ *   it under the terms of the GNU General Public License as published by

+ *   the Free Software Foundation; either version 2 of the License, or

+ *   (at your option) any later version.

+ *

+ *   This program is distributed in the hope that it will be useful,

+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of

+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See

+ *   the GNU General Public License for more details.

+ *

+ *   You should have received a copy of the GNU General Public License

+ *   along with this program;  if not, write to the Free Software

+ *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
02110-1301 USA

+ */

+

+/*

+ *

+ *    AUTHOR

+ *      Honggyu Kim <hong.gyu.kim@lge.com>

+ *

+ *    DESCRIPTION

+ *      Compare a given libc version against the current libc version.

+ *      If they are the same - return 0

+ *      If the argument is > current libc version - return positive int

+ *      If the argument is < current libc version - return negative int

+ *

+ */

+

+#include <stdlib.h>

+#include <unistd.h>

+#include <string.h>

+#include <sys/utsname.h>

+#include <gnu/libc-version.h>

+#include "test.h"

+

+static int tst_libcexvcmp(const char *tst_exv, const char *cur_ver)

+{

+         int c1 = 0, c2 = 0, c3 = 0;

+         int t1 = 0, t2 = 0, t3 = 0;

+         int ret;

+

+         sscanf(cur_ver, "%d.%d.%d", &c1, &c2, &c3);

+         sscanf(tst_exv, "%d.%d.%d", &t1, &t2, &t3);

+

+         if ((ret = c1 - t1))

+                   return ret;

+         if ((ret = c2 - t2))

+                   return ret;

+         return c3 - t3;

+}

+

+const char* tst_getlibcver(void)

+{

+         return gnu_get_libc_version();

+}

+

+int tst_libcvercmp(const char *tst_exv)

+{

+         const char* cur_ver = tst_getlibcver();

+         return tst_libcexvcmp(tst_exv, cur_ver);

+}

diff --git a/testcases/kernel/syscalls/getcontext/getcontext01.c
b/testcases/kernel/syscalls/getcontext/getcontext01.c

index 03b2df9..bf994c5 100644

--- a/testcases/kernel/syscalls/getcontext/getcontext01.c

+++ b/testcases/kernel/syscalls/getcontext/getcontext01.c

@@ -54,12 +54,28 @@ int TST_TOTAL = 1;

 int exp_enos[] = { 0 };               /* must be a 0 terminated list */

+#ifdef __arm__

+#define LIBC_VER_GETCONTEXT_ARM_SUPPORT "2.17"

+#endif

+

int main(int ac, char **av)

{

         int lc;

         char *msg;

          ucontext_t ptr;

+

+#ifdef __arm__

+         /* Disable test if the version of the libc is less than 2.17 in
ARM */

+         if ((tst_libcvercmp(LIBC_VER_GETCONTEXT_ARM_SUPPORT)) < 0) {

+                   tst_resm(TCONF, "This test can only run with libc that
are ");

+                   tst_resm(TCONF, "%s and higher (currently libc-%s
used)",

+                                         LIBC_VER_GETCONTEXT_ARM_SUPPORT,

+                                         tst_getlibcver());

+                   tst_exit();

+         }

+#endif

+

         if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)

                    tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

-- 

1.7.9.5

 


------=_NextPart_000_00F1_01CECFE0.CD6EFCF0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><meta =
http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 12 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
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
	{mso-style-type:export-only;}
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
lang=3DEN-US>getcontext function is implemented from libc-2.17 in =
ARM.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>If =
libc version is less than 2.17, this testcase goes to =
TCONF.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>lib/tst_libcvercmp.c: a new file for libc version =
comparison<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Comparison code for libc version is added as a =
library.<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>Signed-off-by: Honggyu Kim =
&lt;hong.gyu.kim@lge.com&gt;<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>---<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> =
include/test.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 4 ++<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> =
lib/tst_libcvercmp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;|&nbsp;&nbsp; 65 =
++++++++++++++++++++<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> =
.../kernel/syscalls/getcontext/getcontext01.c&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; |&nbsp;&nbsp; 16 +++++<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> 3 files changed, 85 =
insertions(+)<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> create mode 100644 =
lib/tst_libcvercmp.c<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>diff --git a/include/test.h =
b/include/test.h<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>index d9eba31..47765c2 100644<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>--- =
a/include/test.h<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+++ b/include/test.h<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>@@ -180,6 +180,10 @@ struct =
tst_kern_exv {<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> <o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>&nbsp;int tst_kvercmp2(int r1, int r2, int r3, struct =
tst_kern_exv *vers);<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> <o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+/* lib/tst_libcvercmp.c */<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+const char* =
tst_getlibcver(void);<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+int tst_libcvercmp(const char =
*tst_exv);<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> /* lib/tst_is_cwd.c */<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> int =
tst_is_cwd_nfs(void);<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> int tst_is_cwd_v9fs(void);<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>diff --git a/lib/tst_libcvercmp.c =
b/lib/tst_libcvercmp.c<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>new file mode 100644<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>index =
0000000..2a09ab8<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>--- /dev/null<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+++ =
b/lib/tst_libcvercmp.c<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>@@ -0,0 +1,65 @@<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+/*<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+ *<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+ *&nbsp;&nbsp; Copyright (c) LG =
Electronics Corp., 2013<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ *<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ *&nbsp;&nbsp; This program is free software;&nbsp; you =
can redistribute it and/or modify<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+ *&nbsp;&nbsp; it under the terms =
of the GNU General Public License as published =
by<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+ =
*&nbsp;&nbsp; the Free Software Foundation; either version 2 of the =
License, or<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ *&nbsp;&nbsp; (at your option) any later =
version.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+ =
*<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+ =
*&nbsp;&nbsp; This program is distributed in the hope that it will be =
useful,<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+ =
*&nbsp;&nbsp; but WITHOUT ANY WARRANTY;&nbsp; without even the implied =
warranty of<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ *&nbsp;&nbsp; MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE.&nbsp; See<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ *&nbsp;&nbsp; the GNU General Public License for more =
details.<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+ =
*<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+ =
*&nbsp;&nbsp; You should have received a copy of the GNU General Public =
License<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+ =
*&nbsp;&nbsp; along with this program;&nbsp; if not, write to the Free =
Software<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+ =
*&nbsp;&nbsp; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, =
MA 02110-1301 USA<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ */<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+/*<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ *<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ *&nbsp;&nbsp;&nbsp; AUTHOR<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+ *&nbsp;&nbsp;&nbsp; &nbsp; =
Honggyu Kim &lt;hong.gyu.kim@lge.com&gt;<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+ *<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+ *&nbsp;&nbsp;&nbsp; =
DESCRIPTION<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ * &nbsp;&nbsp;&nbsp;&nbsp; Compare a given libc version =
against the current libc version.<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+ * &nbsp;&nbsp;&nbsp;&nbsp; If =
they are the same - return 0<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+ * &nbsp;&nbsp;&nbsp;&nbsp; If the =
argument is &gt; current libc version - return positive =
int<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>+ * =
&nbsp;&nbsp;&nbsp;&nbsp; If the argument is &lt; current libc version - =
return negative int<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ *<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+ */<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+#include &lt;stdlib.h&gt;<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+#include =
&lt;unistd.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+#include &lt;string.h&gt;<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+#include =
&lt;sys/utsname.h&gt;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+#include =
&lt;gnu/libc-version.h&gt;<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+#include =
&quot;test.h&quot;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+static int tst_libcexvcmp(const char *tst_exv, const char =
*cur_ver)<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+{<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int c1 =
=3D 0, c2 =3D 0, c3 =3D 0;<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int t1 =
=3D 0, t2 =3D 0, t3 =3D 0;<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
ret;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sscanf(cur_ver, &quot;%d.%d.%d&quot;, &amp;c1, &amp;c2, =
&amp;c3);<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
sscanf(tst_exv, &quot;%d.%d.%d&quot;, &amp;t1, &amp;t2, =
&amp;t3);<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((ret =
=3D c1 - t1))<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((ret =
=3D c2 - t2))<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
ret;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return c3 =
- t3;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+}<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+const char* tst_getlibcver(void)<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+{<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
gnu_get_libc_version();<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+}<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+int tst_libcvercmp(const char =
*tst_exv)<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+{<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const =
char* cur_ver =3D tst_getlibcver();<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
tst_libcexvcmp(tst_exv, cur_ver);<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+}<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>diff --git =
a/testcases/kernel/syscalls/getcontext/getcontext01.c =
b/testcases/kernel/syscalls/getcontext/getcontext01.c<o:p></o:p></span></=
p><p class=3DMsoNormal><span lang=3DEN-US>index 03b2df9..bf994c5 =
100644<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US>--- =
a/testcases/kernel/syscalls/getcontext/getcontext01.c<o:p></o:p></span></=
p><p class=3DMsoNormal><span lang=3DEN-US>+++ =
b/testcases/kernel/syscalls/getcontext/getcontext01.c<o:p></o:p></span></=
p><p class=3DMsoNormal><span lang=3DEN-US>@@ -54,12 +54,28 @@ int =
TST_TOTAL =3D 1;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> <o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>&nbsp;int exp_enos[] =3D { 0 =
};&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; /* must be a 0 terminated list */<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> <o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>+#ifdef =
__arm__<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+#define LIBC_VER_GETCONTEXT_ARM_SUPPORT =
&quot;2.17&quot;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+#endif<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> int main(int ac, char **av)<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> {<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
lc;<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char =
*msg;<o:p></o:p></span></p><p class=3DMsoNormal><span lang=3DEN-US> =
<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ucontext_t ptr;<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+#ifdef __arm__<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Disable test if the version of the libc is less than 2.17 in ARM =
*/<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
((tst_libcvercmp(LIBC_VER_GETCONTEXT_ARM_SUPPORT)) &lt; 0) =
{<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_resm(TCONF, =
&quot;This test can only run with libc that are =
&quot;);<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_resm(TCONF, =
&quot;%s and higher (currently libc-%s =
used)&quot;,<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
LIBC_VER_GETCONTEXT_ARM_SUPPORT,<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tst_getlibcver());<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tst_exit();<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
}<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+#endif<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US>+<o:p></o:p></span></p><p class=3DMsoNormal><span =
lang=3DEN-US> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((msg =
=3D parse_opts(ac, av, NULL, NULL)) !=3D NULL)<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_brkm(TBROK, NULL, =
&quot;OPTION PARSING ERROR - %s&quot;, msg);<o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US> <o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>-- <o:p></o:p></span></p><p =
class=3DMsoNormal><span lang=3DEN-US>1.7.9.5<o:p></o:p></span></p><p =
class=3DMsoNormal><span =
lang=3DEN-US><o:p>&nbsp;</o:p></span></p></div></body></html>
------=_NextPart_000_00F1_01CECFE0.CD6EFCF0--



--===============7895589006477471904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135991&iu=/4140/ostg.clktrk
--===============7895589006477471904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7895589006477471904==--


