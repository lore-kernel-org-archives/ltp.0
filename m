Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <purushtm1@gmail.com>) id 1MlNft-0003He-Hp
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 13:57:29 +0000
Received: from mail-px0-f194.google.com ([209.85.216.194])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MlNfh-0007tq-7X
	for ltp-list@lists.sourceforge.net; Wed, 09 Sep 2009 13:57:24 +0000
Received: by pxi32 with SMTP id 32so979047pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 09 Sep 2009 06:57:11 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 9 Sep 2009 19:19:45 +0530
Message-ID: <8730448c0909090649n6af394e1jceec7dd2cbd28fb1@mail.gmail.com>
From: purushothama s <purushtm1@gmail.com>
Subject: [LTP] signal_test_04 is failing on arm processor(arm-versatile-1176)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7994759779464327453=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7994759779464327453==
Content-Type: multipart/alternative; boundary=001636e908080dd17f0473255ba7

--001636e908080dd17f0473255ba7
Content-Type: text/plain; charset=ISO-8859-1

Hi  All,

During ltp testing on Arm--versatile-1176 signal_test_04 test fails.

Please find the following error output:

/ltp-full-20090531/testcases/bin# ./signal_test_04
./signal_test_04: IPC TestSuite program

        Wait for SIGUSR1 signal from child process
        Received SIGUSR1 (30)

        Stop the child process

        Wait for SIGCHLD signal from stopped child process
        Received SIGCHLD (20)

        Resume child process & wait for it to send SIGUSR1 signal
ERROR [line: 271] Timed out waiting for SIGCHLD signal from child,
defect #124551

Please let me know your valuable suggestions.

Regards
Purushotham

--001636e908080dd17f0473255ba7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<pre id=3D"comment_text_0">Hi  All,<br><br>During ltp testing on Arm--versa=
tile-1176 signal_test_04 test fails.<br><br>Please find the following error=
 output:<br><br>/ltp-full-20090531/testcases/bin# ./signal_test_04 <br>./si=
gnal_test_04: IPC TestSuite program<br>
<br>        Wait for SIGUSR1 signal from child process<br>        Received =
SIGUSR1 (30)<br><br>        Stop the child process<br><br>        Wait for =
SIGCHLD signal from stopped child process<br>        Received SIGCHLD (20)<=
br>
<br>        Resume child process &amp; wait for it to send SIGUSR1 signal<b=
r>ERROR [line: 271] Timed out waiting for SIGCHLD signal from child, defect=
 #124551<br><br>Please let me know your valuable suggestions.<br><br>Regard=
s<br>
Purushotham<br></pre>

--001636e908080dd17f0473255ba7--


--===============7994759779464327453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7994759779464327453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7994759779464327453==--

