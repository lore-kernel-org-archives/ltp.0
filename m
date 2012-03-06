Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <a2zpavani@gmail.com>) id 1S4x1l-0005Rs-LE
	for ltp-list@lists.sourceforge.net; Tue, 06 Mar 2012 16:14:17 +0000
Received: from mail-tul01m020-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S4x1k-0002my-Ox
	for ltp-list@lists.sourceforge.net; Tue, 06 Mar 2012 16:14:17 +0000
Received: by obqv19 with SMTP id v19so8401192obq.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 06 Mar 2012 08:14:10 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 6 Mar 2012 21:44:10 +0530
Message-ID: <CAB_zjmWr7tSNwfMrEd_FX6BOtjLhqKCJm7F1vf6kNW5DTfWCLw@mail.gmail.com>
From: pavani pavani <a2zpavani@gmail.com>
Subject: [LTP] cron_allow01 failure on 3.2.6 kernel
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8986346982302397625=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8986346982302397625==
Content-Type: multipart/alternative; boundary=f46d0447f2d64d6a4904ba9555e5

--f46d0447f2d64d6a4904ba9555e5
Content-Type: text/plain; charset=ISO-8859-1

Hi All ,

        On 3.2.6 kernel ,found the "cron_allo01" was failing .


mail_tests::mail01    0  TINFO  :  Test #1: user on local machine.
mail_tests::mail01    1  TPASS  :  Test #1: Mail was sent to root & was
received
mail_tests::mail02    0  TINFO  :  Test #2: mail user@bad-domain will
result in failure
mail_tests::mail02    0  TINFO  :  Test #2: to deliver the mail. Mailer
daemon should
mail_tests::mail02    0  TINFO  :  Test #2: report this failure.
mail_tests::mail02    2  TFAIL  :  Test #2: No new mail for root. Reason:
No mail for root
mail_tests::mail03    0  TINFO  :  Test #3: mail
non_existent_user@localhostwill fail

mail_tests::mail03    0  TINFO  :  Test #3: to deliver the mail. Mailer
daemon should
mail_tests::mail03    0  TINFO  :  Test #3: report this failure.
Heirloom mailx version 12.2 01/07/07.  Type ? for help.
mail_tests::mail03    3  TFAIL  :  Test #3: Mailer-Daemon failed to report
delivery failure. Reason:
Heirloom mailx version 12.2 01/07/07.  Type ? for help.
"/var/mail/root": 1 message 1 new
>N  1 MAILER-DAEMON@linu Wed Mar  7 01:17   72/2352  Undelivered Mail
Returned
mail_tests::mail04    0  TINFO  :  Test #4: Test that mail -c user@domainwill

mail_tests::mail04    0  TINFO  :  Test #4: carbon copy user@domain
mail_tests::mail04    4  TPASS  :  Test #4: Mail was carbon copied to user
mail_test
mail_tests::mail05    0  TINFO  :  Test #5: Test that mail -b user@domainwill

mail_tests::mail05    0  TINFO  :  Test #5: blind carbon copy user@domain
mail_tests::mail05    5  TPASS  :  Test #5: Mail was blind copied to user
mail_test
mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary files
from /tmp
mail_tests::cleanup    0  TINFO  :  Test CLEAN: Removing temporary user
mail_test
<<<execution_status>>>
initiation_status="ok"
duration=30 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=2
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20120104

suggest if anyone is facing the similar error.

Thanks
Pavani

--f46d0447f2d64d6a4904ba9555e5
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi All ,<div><br></div><div>=A0 =A0 =A0 =A0 On 3.2.6 kernel ,found the &quo=
t;cron_allo01&quot; was failing .</div><div><br></div><div><br></div><div><=
font face=3D"sans-serif" style>mail_tests::mail01 =A0 =A00 =A0TINFO =A0: =
=A0Test #1: user on local machine.</font><span style>=A0</span><br style>
<font face=3D"sans-serif" style>mail_tests::mail01 =A0 =A01 =A0TPASS =A0: =
=A0Test #1: Mail was sent to root &amp; was received</font><span style>=A0<=
/span><br style><font face=3D"sans-serif" style>mail_tests::mail02 =A0 =A00=
 =A0TINFO =A0: =A0Test #2: mail user@bad-domain will result in failure</fon=
t><span style>=A0</span><br style>
<font face=3D"sans-serif" style>mail_tests::mail02 =A0 =A00 =A0TINFO =A0: =
=A0Test #2: to deliver the mail. Mailer daemon should</font><span style>=A0=
</span><br style><font face=3D"sans-serif" style>mail_tests::mail02 =A0 =A0=
0 =A0TINFO =A0: =A0Test #2: report this failure.</font><span style>=A0</spa=
n><br style>
<font face=3D"sans-serif" style>mail_tests::mail02 =A0 =A02 =A0TFAIL =A0: =
=A0Test #2: No new mail for root. Reason:</font><span style>=A0</span><br s=
tyle><font face=3D"sans-serif" style>No mail for root</font><span style>=A0=
</span><br style>
<font face=3D"sans-serif" style>mail_tests::mail03 =A0 =A00 =A0TINFO =A0: =
=A0Test #3: mail non_existent_user@localhost will fail</font><span style>=
=A0</span><br style><font face=3D"sans-serif" style>mail_tests::mail03 =A0 =
=A00 =A0TINFO =A0: =A0Test #3: to deliver the mail. Mailer daemon should</f=
ont><span style>=A0</span><br style>
<font face=3D"sans-serif" style>mail_tests::mail03 =A0 =A00 =A0TINFO =A0: =
=A0Test #3: report this failure.</font><span style>=A0</span><br style><fon=
t face=3D"sans-serif" style>Heirloom mailx version 12.2 01/07/07. =A0Type ?=
 for help.</font><span style>=A0</span><br style>
<font face=3D"sans-serif" style>mail_tests::mail03 =A0 =A03 =A0TFAIL =A0: =
=A0Test #3: Mailer-Daemon failed to report delivery failure. Reason:</font>=
<span style>=A0</span><br style><font face=3D"sans-serif" style>Heirloom ma=
ilx version 12.2 01/07/07. =A0Type ? for help.</font><span style>=A0</span>=
<br style>
<font face=3D"sans-serif" style>&quot;/var/mail/root&quot;: 1 message 1 new=
</font><span style>=A0</span><br style><font face=3D"sans-serif" style>&gt;=
N =A01 MAILER-DAEMON@linu Wed Mar =A07 01:17 =A0 72/2352 =A0Undelivered Mai=
l Returned</font><span style>=A0</span><br style>
<font face=3D"sans-serif" style>mail_tests::mail04 =A0 =A00 =A0TINFO =A0: =
=A0Test #4: Test that mail -c user@domain will</font><span style>=A0</span>=
<br style><font face=3D"sans-serif" style>mail_tests::mail04 =A0 =A00 =A0TI=
NFO =A0: =A0Test #4: carbon copy user@domain</font><span style>=A0</span><b=
r style>
<font face=3D"sans-serif" style>mail_tests::mail04 =A0 =A04 =A0TPASS =A0: =
=A0Test #4: Mail was carbon copied to user mail_test</font><span style>=A0<=
/span><br style><font face=3D"sans-serif" style>mail_tests::mail05 =A0 =A00=
 =A0TINFO =A0: =A0Test #5: Test that mail -b user@domain will</font><span s=
tyle>=A0</span><br style>
<font face=3D"sans-serif" style>mail_tests::mail05 =A0 =A00 =A0TINFO =A0: =
=A0Test #5: blind carbon copy user@domain</font><span style>=A0</span><br s=
tyle><font face=3D"sans-serif" style>mail_tests::mail05 =A0 =A05 =A0TPASS =
=A0: =A0Test #5: Mail was blind copied to user mail_test</font><span style>=
=A0</span><br style>
<font face=3D"sans-serif" style>mail_tests::cleanup =A0 =A00 =A0TINFO =A0: =
=A0Test CLEAN: Removing temporary files from /tmp</font><span style>=A0</sp=
an><br style><font face=3D"sans-serif" style>mail_tests::cleanup =A0 =A00 =
=A0TINFO =A0: =A0Test CLEAN: Removing temporary user mail_test</font><span =
style>=A0</span><br style>
<font face=3D"sans-serif" style>&lt;&lt;&lt;execution_status&gt;&gt;&gt;</f=
ont><span style>=A0</span><br style><font face=3D"sans-serif" style>initiat=
ion_status=3D&quot;ok&quot;</font><span style>=A0</span><br style><font fac=
e=3D"sans-serif" style>duration=3D30 termination_type=3Dexited termination_=
id=3D2 corefile=3Dno</font><span style>=A0</span><br style>
<font face=3D"sans-serif" style>cutime=3D0 cstime=3D2</font><span style>=A0=
</span><br style><font face=3D"sans-serif" style>&lt;&lt;&lt;test_end&gt;&g=
t;&gt;</font><span style>=A0</span><br style><font face=3D"sans-serif" styl=
e>INFO: ltp-pan reported some tests FAIL</font><span style>=A0</span><br st=
yle>
<font face=3D"sans-serif" style>LTP Version: LTP-20120104</font>
</div><div><font face=3D"sans-serif" style><br></font></div><div><font face=
=3D"sans-serif" style>suggest if anyone is facing the similar error.</font>=
</div><div><font face=3D"sans-serif" style><br></font></div><div><font face=
=3D"sans-serif" style>Thanks</font></div>
<div><font color=3D"#222222" face=3D"sans-serif" size=3D"3">Pavani</font></=
div><div><font color=3D"#222222" face=3D"sans-serif" size=3D"3"><br></font>=
</div>

--f46d0447f2d64d6a4904ba9555e5--


--===============8986346982302397625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--===============8986346982302397625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8986346982302397625==--

