Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MdC1j-00053E-Oq
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 23:54:11 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MdC1b-0006hY-JL
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2009 23:54:11 +0000
Received: from svexch01.mvista.com (svexch01.mvista.com [10.0.0.82])
	by hermes.mvista.com (Postfix) with ESMTP id 8D2CC1B732
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Aug 2009 16:53:57 -0700 (PDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA1F95.CCDF8380"
Date: Mon, 17 Aug 2009 16:52:58 -0700
Message-ID: <8368651DACC1964480F951191B94A078010C61D2@svexch01.mvista.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] [PATCH] open10, use tst_tmpdir and tst_rmdir functions
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA1F95.CCDF8380
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CA1F95.CCDF8380"


------_=_NextPart_002_01CA1F95.CCDF8380
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This patch adds functions to create and cleanup temporary test =
directories, code style changes to match other open tests.

Signed-off-by: Henry Yei<hyei@mvista.com>

=20

diff -Nurp -x CVS ltp-20090531/testcases/kernel/syscalls/open/open10.c =
ltp-wdir/testcases/kernel/syscalls/open/open10.c

--- ltp-20090531/testcases/kernel/syscalls/open/open10.c    2009-03-23 =
06:35:58.000000000 -0700

+++ ltp-wdir/testcases/kernel/syscalls/open/open10.c  2009-08-17 =
16:41:41.008259471 -0700

@@ -74,6 +74,8 @@ int local_flag;

 #define ROOT_SETGID    "root_setgid"

 #define    MSGSIZE           150

=20

+void cleanup(void);

+

 char progname[] =3D "open10()";

=20

 int issu()

@@ -121,13 +123,14 @@ int main(int ac, char *av[])

       * parse standard options

       */

      if ((msg =3D parse_opts(ac, av, (option_t *) NULL, NULL)) !=3D =
(char *)NULL) {

-           tst_resm(TBROK, "OPTION PARSING ERROR - %s", msg);

-           tst_exit();

+           tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);

       /*NOTREACHED*/}

=20

+     tst_tmpdir();

+

      if (issu() !=3D 0) {

            tst_resm(TINFO, "Must be root to run this test.");

-           tst_exit();

+           cleanup();

      }

      for (lc =3D 0; TEST_LOOPING(lc); lc++) {

=20

@@ -145,8 +148,7 @@ int main(int ac, char *av[])

=20

            /* Get the uid of user1 */

            if ((user1 =3D getpwnam("nobody")) =3D=3D NULL) {

-                 tst_resm(TBROK, "nobody not in /etc/passwd");

-                 tst_exit();

+                 tst_brkm(TBROK, cleanup, "nobody not in /etc/passwd");

            }

            user1_uid =3D user1->pw_uid;

=20

@@ -155,14 +157,13 @@ int main(int ac, char *av[])

             */

            if ((group =3D getgrnam("nobody")) =3D=3D NULL) {

                  if ((group =3D getgrnam("nogroup")) =3D=3D NULL) {

-                       tst_resm(TBROK,

+                       tst_brkm(TBROK, cleanup,

                               "nobody/nogroup not in /etc/group");

-                       tst_exit();

                  }

            }

            group1_gid =3D group->gr_gid;

            if ((group =3D getgrnam("bin")) =3D=3D NULL) {

-                 tst_resm(TBROK, "bin not in /etc/group");

+                 tst_brkm(TBROK, cleanup, "bin not in /etc/group");

            }

            group2_gid =3D group->gr_gid;

=20

@@ -510,6 +511,21 @@ int main(int ac, char *av[])

            }

=20

      }

-     tst_exit();

+     cleanup();

      return 0;

 }

+

+void cleanup(void)

+{

+     /*

+     * print timing status if that option was specified.

+     * print errno log if that option was specified

+     */

+     TEST_CLEANUP;

+

+     /* Remove tmp dir and all files in it */

+     tst_rmdir();

+

+     /* exit with return code appropriate for results */

+     tst_exit();

+}

=20


------_=_NextPart_002_01CA1F95.CCDF8380
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
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
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:Consolas;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoPlainText>This patch adds functions to create and cleanup =
temporary
test directories, code style changes to match other open =
tests.<o:p></o:p></p>

<p class=3DMsoPlainText>Signed-off-by: Henry Yei&lt;<a
href=3D"mailto:hyei@mvista.com">hyei@mvista.com</a>&gt;<o:p></o:p></p>

<p class=3DMsoPlainText><o:p>&nbsp;</o:p></p>

<p class=3DMsoPlainText>diff -Nurp -x CVS
ltp-20090531/testcases/kernel/syscalls/open/open10.c
ltp-wdir/testcases/kernel/syscalls/open/open10.c<o:p></o:p></p>

<p class=3DMsoPlainText>--- =
ltp-20090531/testcases/kernel/syscalls/open/open10.c=A0=A0=A0 2009-03-23
06:35:58.000000000 -0700<o:p></o:p></p>

<p class=3DMsoPlainText>+++ =
ltp-wdir/testcases/kernel/syscalls/open/open10.c=A0 2009-08-17
16:41:41.008259471 -0700<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -74,6 +74,8 @@ int local_flag;<o:p></o:p></p>

<p class=3DMsoPlainText>=A0#define ROOT_SETGID=A0=A0=A0 =
&quot;root_setgid&quot;<o:p></o:p></p>

<p class=3DMsoPlainText>=A0#define=A0=A0=A0 =
MSGSIZE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 150<o:p></o:p></p>

<p class=3DMsoPlainText>=A0<o:p></o:p></p>

<p class=3DMsoPlainText>+void cleanup(void);<o:p></o:p></p>

<p class=3DMsoPlainText>+<o:p></o:p></p>

<p class=3DMsoPlainText>=A0char progname[] =3D =
&quot;open10()&quot;;<o:p></o:p></p>

<p class=3DMsoPlainText>=A0<o:p></o:p></p>

<p class=3DMsoPlainText>=A0int issu()<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -121,13 +123,14 @@ int main(int ac, char =
*av[])<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0 =A0* parse standard =
options<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0 =A0*/<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0 if ((msg =3D parse_opts(ac, av, =
(option_t *) NULL,
NULL)) !=3D (char *)NULL) {<o:p></o:p></p>

<p class=3DMsoPlainText>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_resm(TBROK, =
&quot;OPTION PARSING ERROR -
%s&quot;, msg);<o:p></o:p></p>

<p class=3DMsoPlainText>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
tst_exit();<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_brkm(TBROK, =
cleanup, &quot;OPTION PARSING
ERROR - %s&quot;, msg);<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0 =
=A0/*NOTREACHED*/}<o:p></o:p></p>

<p class=3DMsoPlainText>=A0<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0 tst_tmpdir();<o:p></o:p></p>

<p class=3DMsoPlainText>+<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0 if (issu() !=3D 0) =
{<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
tst_resm(TINFO, &quot;Must be root to run
this test.&quot;);<o:p></o:p></p>

<p class=3DMsoPlainText>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
tst_exit();<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
cleanup();<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0 }<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0 for (lc =3D 0; TEST_LOOPING(lc); =
lc++) {<o:p></o:p></p>

<p class=3DMsoPlainText>=A0<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -145,8 +148,7 @@ int main(int ac, char =
*av[])<o:p></o:p></p>

<p class=3DMsoPlainText>=A0<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Get the uid =
of user1 */<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((user1 =3D =
getpwnam(&quot;nobody&quot;)) =3D=3D
NULL) {<o:p></o:p></p>

<p =
class=3DMsoPlainText>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
tst_resm(TBROK, &quot;nobody not in
/etc/passwd&quot;);<o:p></o:p></p>

<p =
class=3DMsoPlainText>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
tst_exit();<o:p></o:p></p>

<p =
class=3DMsoPlainText>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
tst_brkm(TBROK, cleanup, &quot;nobody
not in /etc/passwd&quot;);<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
}<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 user1_uid =3D =
user1-&gt;pw_uid;<o:p></o:p></p>

<p class=3DMsoPlainText>=A0<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -155,14 +157,13 @@ int main(int ac, char =
*av[])<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0*/<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((group =3D =
getgrnam(&quot;nobody&quot;)) =3D=3D
NULL) {<o:p></o:p></p>

<p =
class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
if ((group =3D
getgrnam(&quot;nogroup&quot;)) =3D=3D NULL) {<o:p></o:p></p>

<p =
class=3DMsoPlainText>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 tst_resm(TBROK,<o:p></o:p></p>

<p =
class=3DMsoPlainText>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 tst_brkm(TBROK, cleanup,<o:p></o:p></p>

<p =
class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0&quot;nobody/nogroup not
in /etc/group&quot;);<o:p></o:p></p>

<p =
class=3DMsoPlainText>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 tst_exit();<o:p></o:p></p>

<p =
class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
}<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
}<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 group1_gid =3D =
group-&gt;gr_gid;<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((group =3D =
getgrnam(&quot;bin&quot;)) =3D=3D
NULL) {<o:p></o:p></p>

<p =
class=3DMsoPlainText>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
tst_resm(TBROK, &quot;bin not in
/etc/group&quot;);<o:p></o:p></p>

<p =
class=3DMsoPlainText>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
tst_brkm(TBROK, cleanup, &quot;bin not
in /etc/group&quot;);<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
}<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 group2_gid =3D =
group-&gt;gr_gid;<o:p></o:p></p>

<p class=3DMsoPlainText>=A0<o:p></o:p></p>

<p class=3DMsoPlainText>@@ -510,6 +511,21 @@ int main(int ac, char =
*av[])<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
}<o:p></o:p></p>

<p class=3DMsoPlainText>=A0<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0 }<o:p></o:p></p>

<p class=3DMsoPlainText>-=A0=A0=A0=A0 tst_exit();<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0 cleanup();<o:p></o:p></p>

<p class=3DMsoPlainText>=A0=A0=A0=A0=A0 return 0;<o:p></o:p></p>

<p class=3DMsoPlainText>=A0}<o:p></o:p></p>

<p class=3DMsoPlainText>+<o:p></o:p></p>

<p class=3DMsoPlainText>+void cleanup(void)<o:p></o:p></p>

<p class=3DMsoPlainText>+{<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0 /*<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0  * print timing status if that =
option was
specified.<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0  * print errno log if that option =
was specified<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0  */<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0 TEST_CLEANUP;<o:p></o:p></p>

<p class=3DMsoPlainText>+<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0 /* Remove tmp dir and all files in =
it */<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0 tst_rmdir();<o:p></o:p></p>

<p class=3DMsoPlainText>+<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0 /* exit with return code =
appropriate for results */<o:p></o:p></p>

<p class=3DMsoPlainText>+=A0=A0=A0=A0 tst_exit();<o:p></o:p></p>

<p class=3DMsoPlainText>+}<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01CA1F95.CCDF8380--

------_=_NextPart_001_01CA1F95.CCDF8380
Content-Type: application/octet-stream;
	name="open10.patch"
Content-Transfer-Encoding: base64
Content-Description: open10.patch
Content-Disposition: attachment;
	filename="open10.patch"

ZGlmZiAtTnVycCAteCBDVlMgbHRwLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
b3Blbi9vcGVuMTAuYyBsdHAtd2Rpci90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vb3Bl
bjEwLmMKLS0tIGx0cC0yMDA5MDUzMS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL29wZW4vb3Bl
bjEwLmMJMjAwOS0wMy0yMyAwNjozNTo1OC4wMDAwMDAwMDAgLTA3MDAKKysrIGx0cC13ZGlyL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvb3Blbi9vcGVuMTAuYwkyMDA5LTA4LTE3IDE2OjQxOjQx
LjAwODI1OTQ3MSAtMDcwMApAQCAtNzQsNiArNzQsOCBAQCBpbnQgbG9jYWxfZmxhZzsKICNkZWZp
bmUgUk9PVF9TRVRHSUQJInJvb3Rfc2V0Z2lkIgogI2RlZmluZQlNU0dTSVpFCQkxNTAKIAordm9p
ZCBjbGVhbnVwKHZvaWQpOworCiBjaGFyIHByb2duYW1lW10gPSAib3BlbjEwKCkiOwogCiBpbnQg
aXNzdSgpCkBAIC0xMjEsMTMgKzEyMywxNCBAQCBpbnQgbWFpbihpbnQgYWMsIGNoYXIgKmF2W10p
CiAJICogcGFyc2Ugc3RhbmRhcmQgb3B0aW9ucwogCSAqLwogCWlmICgobXNnID0gcGFyc2Vfb3B0
cyhhYywgYXYsIChvcHRpb25fdCAqKSBOVUxMLCBOVUxMKSkgIT0gKGNoYXIgKilOVUxMKSB7Ci0J
CXRzdF9yZXNtKFRCUk9LLCAiT1BUSU9OIFBBUlNJTkcgRVJST1IgLSAlcyIsIG1zZyk7Ci0JCXRz
dF9leGl0KCk7CisJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiT1BUSU9OIFBBUlNJTkcgRVJS
T1IgLSAlcyIsIG1zZyk7CiAJIC8qTk9UUkVBQ0hFRCovfQogCisJdHN0X3RtcGRpcigpOworCiAJ
aWYgKGlzc3UoKSAhPSAwKSB7CiAJCXRzdF9yZXNtKFRJTkZPLCAiTXVzdCBiZSByb290IHRvIHJ1
biB0aGlzIHRlc3QuIik7Ci0JCXRzdF9leGl0KCk7CisJCWNsZWFudXAoKTsKIAl9CiAJZm9yIChs
YyA9IDA7IFRFU1RfTE9PUElORyhsYyk7IGxjKyspIHsKIApAQCAtMTQ1LDggKzE0OCw3IEBAIGlu
dCBtYWluKGludCBhYywgY2hhciAqYXZbXSkKIAogCQkvKiBHZXQgdGhlIHVpZCBvZiB1c2VyMSAq
LwogCQlpZiAoKHVzZXIxID0gZ2V0cHduYW0oIm5vYm9keSIpKSA9PSBOVUxMKSB7Ci0JCQl0c3Rf
cmVzbShUQlJPSywgIm5vYm9keSBub3QgaW4gL2V0Yy9wYXNzd2QiKTsKLQkJCXRzdF9leGl0KCk7
CisJCQl0c3RfYnJrbShUQlJPSywgY2xlYW51cCwgIm5vYm9keSBub3QgaW4gL2V0Yy9wYXNzd2Qi
KTsKIAkJfQogCQl1c2VyMV91aWQgPSB1c2VyMS0+cHdfdWlkOwogCkBAIC0xNTUsMTQgKzE1Nywx
MyBAQCBpbnQgbWFpbihpbnQgYWMsIGNoYXIgKmF2W10pCiAJCSAqLwogCQlpZiAoKGdyb3VwID0g
Z2V0Z3JuYW0oIm5vYm9keSIpKSA9PSBOVUxMKSB7CiAJCQlpZiAoKGdyb3VwID0gZ2V0Z3JuYW0o
Im5vZ3JvdXAiKSkgPT0gTlVMTCkgewotCQkJCXRzdF9yZXNtKFRCUk9LLAorCQkJCXRzdF9icmtt
KFRCUk9LLCBjbGVhbnVwLAogCQkJCQkgIm5vYm9keS9ub2dyb3VwIG5vdCBpbiAvZXRjL2dyb3Vw
Iik7Ci0JCQkJdHN0X2V4aXQoKTsKIAkJCX0KIAkJfQogCQlncm91cDFfZ2lkID0gZ3JvdXAtPmdy
X2dpZDsKIAkJaWYgKChncm91cCA9IGdldGdybmFtKCJiaW4iKSkgPT0gTlVMTCkgewotCQkJdHN0
X3Jlc20oVEJST0ssICJiaW4gbm90IGluIC9ldGMvZ3JvdXAiKTsKKwkJCXRzdF9icmttKFRCUk9L
LCBjbGVhbnVwLCAiYmluIG5vdCBpbiAvZXRjL2dyb3VwIik7CiAJCX0KIAkJZ3JvdXAyX2dpZCA9
IGdyb3VwLT5ncl9naWQ7CiAKQEAgLTUxMCw2ICs1MTEsMjEgQEAgaW50IG1haW4oaW50IGFjLCBj
aGFyICphdltdKQogCQl9CiAKIAl9Ci0JdHN0X2V4aXQoKTsKKwljbGVhbnVwKCk7CiAJcmV0dXJu
IDA7CiB9CisKK3ZvaWQgY2xlYW51cCh2b2lkKQoreworCS8qCisJICogcHJpbnQgdGltaW5nIHN0
YXR1cyBpZiB0aGF0IG9wdGlvbiB3YXMgc3BlY2lmaWVkLgorCSAqIHByaW50IGVycm5vIGxvZyBp
ZiB0aGF0IG9wdGlvbiB3YXMgc3BlY2lmaWVkCisJICovCisJVEVTVF9DTEVBTlVQOworCisJLyog
UmVtb3ZlIHRtcCBkaXIgYW5kIGFsbCBmaWxlcyBpbiBpdCAqLworCXRzdF9ybWRpcigpOworCisJ
LyogZXhpdCB3aXRoIHJldHVybiBjb2RlIGFwcHJvcHJpYXRlIGZvciByZXN1bHRzICovCisJdHN0
X2V4aXQoKTsKK30K

------_=_NextPart_001_01CA1F95.CCDF8380
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
------_=_NextPart_001_01CA1F95.CCDF8380
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA1F95.CCDF8380--

