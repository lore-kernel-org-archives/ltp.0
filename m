Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yaneurabeya@gmail.com>) id 1OmS39-00009C-S2
	for ltp-list@lists.sourceforge.net; Fri, 20 Aug 2010 13:54:27 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OmS35-0007zT-Aw
	for ltp-list@lists.sourceforge.net; Fri, 20 Aug 2010 13:54:27 +0000
Received: by pwi9 with SMTP id 9so709064pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 20 Aug 2010 06:54:17 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1081)
From: Garrett Cooper <yaneurabeya@gmail.com>
In-Reply-To: <SNT119-W3821029ADE3BBEE190C837949F0@phx.gbl>
Date: Fri, 20 Aug 2010 06:54:13 -0700
Message-Id: <D2E04B18-BD6D-458D-A41E-BD8BC095E9F1@gmail.com>
References: <SNT119-W3821029ADE3BBEE190C837949F0@phx.gbl>
Subject: Re: [LTP]
	=?utf-8?q?=5BPATCH=5Dfix_the_at=5Fdeny01_failure=E2=80=8F?=
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8101015433863837920=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: GaoGodwin <godwin.gao@hotmail.com>
Cc: ltp-list@lists.sourceforge.net


--===============8101015433863837920==
Content-Type: multipart/alternative; boundary=Apple-Mail-1--937424725


--Apple-Mail-1--937424725
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 20, 2010, at 1:08 AM, GaoGodwin wrote:

> Hi,
>=20
> There are three failures found when running the LTP at_deny01 case.
>=20
> [1] at_deny01    1  TCONF  :  at command not found on system
> [2] /home/test_user_1/at_deny01: line 129: tst_resm: command not found
> [3] You are required to change your password immediately (root =
enforced)
>=20
> The root causes of these failures:
>=20
> [1] In the shell script, if the return value of a function is 0, it =
view as TRUE. In the at_deny01
> 162 if type at > /dev/null; then
> 163         tst_resm TCONF "at command not found on system"
> if the system has at function, shell script will print "at command not =
found on system". This is opposite.
>=20
> [2] In the at_deny01, root user will create user named a test_user_1, =
copy the file at_deny01 to the home directory of test_user_1,
> change user to test_user_1 and run the at_deny01 script.
> when run the script, ${LTPROOT}/testcase/bin is in the environment =
variable of root, but NOT in the test_user_1. So when the test_user_1
> run this script, it can NOT find the tst_resm command.
>=20
> [3] When some boards boot up, the system time is 010100001970. the =
Linux system will let NON-root user change its password immediately=20
> and stop the script running. This patch will let the script run =
normally without changing the password.=20
>=20
> Patch attached, I have checked it on the Ubuntu.
>=20
> Signed-off-by: Godwin Gao <godwin.gao@hotmail.com>

I'd accept item 1, because it fixes the issue seen. I wouldn't accept =
the rest, because:

2. This is a non-issue; you should setup your environmnent properly =
before running scripts because runltp already does this properly. =
Otherwise we'd have an inconsistently `fixed' test script. It doesn't =
look like this is fixed in the patch anyhow.
3. I can't fix every issue pertaining to user logins, and we shouldn't. =
There's enough code in the sourcebase that uses similar logic, so if it =
needs to be expressed somewhere, please let me know so we can address =
this `issue' universally, not just one off in this test script.

Also, why are you calling su with -p now? It's for preserving the =
environment according to the GNU coreutils page: =
http://www.gnu.org/software/coreutils/manual/html_node/su-invocation.html =
.

Thanks,
-Garrett=

--Apple-Mail-1--937424725
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><base href=3D"x-msg://4/"></head><body style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; "><div><div>On Aug 20, 2010, at 1:08 AM, GaoGodwin =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><span class=3D"Apple-style-span" style=3D"border-collapse: =
separate; font-family: Helvetica; font-style: normal; font-variant: =
normal; font-weight: normal; letter-spacing: normal; line-height: =
normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: =
normal; widows: 2; word-spacing: 0px; -webkit-border-horizontal-spacing: =
0px; -webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px; font-size: medium; "><div =
class=3D"hmmessage" style=3D"font-size: 10pt; "><font size=3D"2" =
style=3D"font-size: 10pt; ">Hi,<br><br>There are three failures found =
when running the LTP at_deny01 case.<br><br>[1] =
at_deny01&nbsp;&nbsp;&nbsp; 1&nbsp; TCONF&nbsp; :&nbsp; at command not =
found on system<br>[2] /home/test_user_1/at_deny01: line 129: tst_resm: =
command not found<br>[3] You are required to change your password =
immediately (root enforced)<br><br>The root causes of these =
failures:<br><br>[1] In the shell script, if the return value of a =
function is 0, it view as TRUE. In the at_deny01<br>162 if type at &gt; =
/dev/null; then<br>163&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
tst_resm TCONF "at command not found on system"<br>if the system has at =
function, shell script will print "at command not found on system". This =
is opposite.<br><br>[2] In the at_deny01, root user will create user =
named a test_user_1, copy the file at_deny01 to the home directory of =
test_user_1,<br>change user to test_user_1 and run the at_deny01 =
script.<br>when run the script, ${LTPROOT}/testcase/bin is in the =
environment variable of root, but NOT in the test_user_1. So when the =
test_user_1<br>run this script, it can NOT find the tst_resm =
command.<br><br>[3] When some boards boot up, the system time is =
010100001970. the Linux system will let NON-root user change its =
password immediately<span =
class=3D"Apple-converted-space">&nbsp;</span><br>and stop the script =
running. This patch will let the script run normally without changing =
the password.<span =
class=3D"Apple-converted-space">&nbsp;</span><br><br>Patch attached, I =
have checked it on the Ubuntu.<br><br>Signed-off-by: Godwin Gao &lt;<a =
href=3D"mailto:godwin.gao@hotmail.com">godwin.gao@hotmail.com</a>&gt;<br><=
/font></div></span></blockquote></div><br><div>I'd accept item 1, =
because it fixes the issue seen. I wouldn't accept the rest, =
because:</div><div><br></div><div>2. This is a non-issue; you should =
setup your environmnent properly before running scripts because runltp =
already does this properly. Otherwise we'd have an inconsistently =
`fixed' test script. It doesn't look like this is fixed in the patch =
anyhow.</div><div>3. I can't fix every issue pertaining to user logins, =
and we shouldn't. There's enough code in the sourcebase that uses =
similar logic, so if it needs to be expressed somewhere, please let me =
know so we can address this `issue' universally, not just one off in =
this test script.</div><div><br></div><div>Also, why are you calling su =
with -p now? It's for preserving the environment according to the GNU =
coreutils page:&nbsp;<a =
href=3D"http://www.gnu.org/software/coreutils/manual/html_node/su-invocati=
on.html">http://www.gnu.org/software/coreutils/manual/html_node/su-invocat=
ion.html</a> =
.</div><div><br></div><div>Thanks,</div><div>-Garrett</div></body></html>=

--Apple-Mail-1--937424725--


--===============8101015433863837920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--===============8101015433863837920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8101015433863837920==--

