Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <benoit.marcot@arm.com>) id 1UwXQ2-0003D6-Qi
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 12:53:22 +0000
Received: from service87.mimecast.com ([91.220.42.44])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwXQ0-0003k8-R0
	for ltp-list@lists.sourceforge.net; Tue, 09 Jul 2013 12:53:22 +0000
From: Benoit Marcot <Benoit.Marcot@arm.com>
Date: Tue, 9 Jul 2013 13:37:04 +0100
Message-ID: <1C23526A7C42DB45BBF55B662C7C530E25B424AA42@BUNGLE.Emea.Arm.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] [PATCH] flock03.c: fixes a typo when compiling with UCLINUX=1
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0655492416997276186=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============0655492416997276186==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_1C23526A7C42DB45BBF55B662C7C530E25B424AA42BUNGLEEmeaArm_"

--_000_1C23526A7C42DB45BBF55B662C7C530E25B424AA42BUNGLEEmeaArm_
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

flock03.c: This patch fixes a typo when compiling with UCLINUX=3D1.

Corrects FILENAME to FILE_NAME, and removes some trailing white-spaces in
empty lines.

Signed-off-by: Benoit Marcot <benoit.marcot@arm.com>
---
testcases/kernel/syscalls/flock/flock03.c | 10 +++++-----
1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/s=
yscalls/flock/flock03.c
index bacf4f6..a7a1cd9 100644
--- a/testcases/kernel/syscalls/flock/flock03.c
+++ b/testcases/kernel/syscalls/flock/flock03.c
@@ -86,13 +86,13 @@ int main(int argc, char **argv)
                                 "file, errno %d", errno);
                pid =3D FORK_OR_VFORK();
-
+
                if (pid =3D=3D -1)
                        tst_brkm(TFAIL, cleanup, "fork() failed, errno %d",
                                 errno);
                if (pid =3D=3D 0) {
#ifdef UCLINUX
-                       if (self_exec(argv[0], "ds", fd, FILENAME) < 0)
+                       if (self_exec(argv[0], "ds", fd, FILE_NAME) < 0)
                                tst_brkm(TFAIL, cleanup, "self_exec failed,=
 "
                                         "errno &d", errno);
#else
@@ -161,7 +161,7 @@ static void childfunc(int fd)
        }
        TEST(flock(fd2, LOCK_EX | LOCK_NB));
-
+
        if (TEST_RETURN =3D=3D -1) {
                fprintf(stderr, "CHILD: Unable to lock file after "
                        "unlocking: %s\n", strerror(TEST_ERRNO));
@@ -169,10 +169,10 @@ static void childfunc(int fd)
        } else {
                fprintf(stderr, "CHILD: Locking after unlock passed\n");
        }
-
+
        close(fd);
        close(fd2);
-
+
        exit(0);
}
--
1.8.3

-- IMPORTANT NOTICE: The contents of this email and any attachments are con=
fidential and may also be privileged. If you are not the intended recipient=
, please notify the sender immediately and do not disclose the contents to =
any other person, use it for any purpose, or store or copy the information =
in any medium. Thank you.
--_000_1C23526A7C42DB45BBF55B662C7C530E25B424AA42BUNGLEEmeaArm_
Content-Type: text/html; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0cm;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";
=09mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;
=09font-family:"Calibri","sans-serif";
=09mso-fareast-language:EN-US;}
@page WordSection1
=09{size:612.0pt 792.0pt;
=09margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
=09{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-GB" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">flock03.c: This patch fixes a typo when compiling wi=
th UCLINUX=3D1.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Corrects FILENAME to FILE_NAME, and removes some tra=
iling white-spaces in<o:p></o:p></p>
<p class=3D"MsoNormal">empty lines.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Benoit Marcot &lt;benoit.marcot@arm.c=
om&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">testcases/kernel/syscalls/flock/flock03.c | 10 &#43;=
&#43;&#43;&#43;&#43;-----<o:p></o:p></p>
<p class=3D"MsoNormal">1 file changed, 5 insertions(&#43;), 5 deletions(-)<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/testcases/kernel/syscalls/flock/flock03=
.c b/testcases/kernel/syscalls/flock/flock03.c<o:p></o:p></p>
<p class=3D"MsoNormal">index bacf4f6..a7a1cd9 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/testcases/kernel/syscalls/flock/flock03.c<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/testcases/kernel/syscalls/flock/fl=
ock03.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -86,13 &#43;86,13 @@ int main(int argc, char **ar=
gv)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;fil=
e, errno %d&quot;, errno);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pid =3D FORK_OR_VFORK();<o:p></=
o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pid =3D=3D -1)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; tst_brkm(TFAIL, cleanup, &quot;fork() failed, errno %d&quot;,<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; errno);<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pid =3D=3D 0) {<o:p></o:p></p>
<p class=3D"MsoNormal">#ifdef UCLINUX<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (self_exec(argv[0], &quot;ds&quot;, fd, FILENAME) &lt; 0)<o:p></o=
:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (self_exec(argv[0], &quot;ds&quot;, fd, FILE_NAME) &lt; 0)<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;tst_brkm(TFAIL,=
 cleanup, &quot;self_exec failed, &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;errno &amp;d&quot;, errno);<o:=
p></o:p></p>
<p class=3D"MsoNormal">#else<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -161,7 &#43;161,7 @@ static void childfunc(int fd=
)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TEST=
(flock(fd2, LOCK_EX | LOCK_NB));<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (TEST_=
RETURN =3D=3D -1) {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;CHILD: Unable =
to lock file after &quot;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; &quot;unlocking: %s\n&quot;, strerror(TEST_ERRNO));<o:p></o:p><=
/p>
<p class=3D"MsoNormal">@@ -169,10 &#43;169,10 @@ static void childfunc(int =
fd)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fprintf(stderr, &quot;CHILD: Locking=
 after unlock passed\n&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o=
:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(fd)=
;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close(fd2=
);<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(0);<=
o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">1.8.3<o:p></o:p></p>
</div>
<br>
<font face=3D"Arial" color=3D"Black" size=3D"2">-- IMPORTANT NOTICE: The co=
ntents of this email and any attachments are confidential and may also be p=
rivileged. If you are not the intended recipient, please notify the sender =
immediately and do not disclose the contents
 to any other person, use it for any purpose, or store or copy the informat=
ion in any medium. Thank you.<br>
</font>
</body>
</html>
--_000_1C23526A7C42DB45BBF55B662C7C530E25B424AA42BUNGLEEmeaArm_--



--===============0655492416997276186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
--===============0655492416997276186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0655492416997276186==--


