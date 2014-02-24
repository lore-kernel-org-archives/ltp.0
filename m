Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jessica.foest@gmail.com>) id 1WHj9X-0007O6-Tq
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 00:12:11 +0000
Received: from mail-ob0-f196.google.com ([209.85.214.196])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WHj9X-00031H-5B
	for ltp-list@lists.sourceforge.net; Mon, 24 Feb 2014 00:12:11 +0000
Received: by mail-ob0-f196.google.com with SMTP id wo20so351554obc.3
	for <ltp-list@lists.sourceforge.net>;
	Sun, 23 Feb 2014 16:12:05 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 23 Feb 2014 19:12:05 -0500
Message-ID: <CAPxN80CzjoOyhTwsPii42+u2qxO=u5oe0B_jok7TozzX-=nNow@mail.gmail.com>
From: Jessica Foest <jessica.foest@gmail.com>
Subject: [LTP] LTP syscall question
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2329487599807129859=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2329487599807129859==
Content-Type: multipart/alternative; boundary=001a11c1d7e05bfd2604f31bd253

--001a11c1d7e05bfd2604f31bd253
Content-Type: text/plain; charset=ISO-8859-1

Hi all

I'm a new user of LTP tool , my goal is to execute some system calls using
LTP and to intercept them using a kernel tracer .

i do this example :

/opt/ltp/runltp -q -p -l result.03.log -f
/home/jessica/LTP-test/test-syscall.txt

the content of the test-syscall.txt file is :
#Tag       Test case
#---------------------------------------
fork01      fork01
chdir01     symlink01 -T chdir01
#----------------------------------------

the problem is that i didn't intercept the syscall fork and the syscall
chdir using my tracer in the kernel space.

So i wanna ask :
Which processes are responsible of the execution of these system calls ?
Does this tool, i mean LTP, really execute these system calls ( fork and
chdir ) in the kernel space?

Regards.

--001a11c1d7e05bfd2604f31bd253
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all<div><br></div><div>I&#39;m a new user of LTP tool ,=
 my goal is to execute some system calls using LTP and to intercept them us=
ing a kernel tracer .</div><div><br></div><div>i do this example :</div><di=
v>
<br></div><div><div>/opt/ltp/runltp -q -p -l result.03.log -f /home/jessica=
/LTP-test/test-syscall.txt</div><div><br></div><div>the content of the test=
-syscall.txt file is=A0:<br></div><div>#Tag =A0 =A0 =A0 Test case</div><div=
>#---------------------------------------</div>
<div>fork01 =A0 =A0 =A0fork01</div><div>chdir01 =A0 =A0 symlink01 -T chdir0=
1</div><div>#----------------------------------------</div></div><div><br><=
/div><div>the problem is that i didn&#39;t intercept the syscall fork and t=
he syscall chdir using my tracer in the kernel space.</div>
<div><br></div><div>So i wanna ask :=A0</div><div>Which processes are respo=
nsible of the execution of these system calls ?</div><div>Does this tool, i=
 mean LTP, really execute these system calls ( fork and chdir ) in the kern=
el space?</div>
<div><br></div><div>Regards.</div></div>

--001a11c1d7e05bfd2604f31bd253--


--===============2329487599807129859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
--===============2329487599807129859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2329487599807129859==--

