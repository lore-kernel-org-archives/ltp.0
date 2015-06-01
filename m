Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rinkusaini32@gmail.com>) id 1YzPRg-0006DU-0J
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 13:08:00 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YzPRf-0002P4-7G
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2015 13:07:59 +0000
Received: by obbnx5 with SMTP id nx5so102386225obb.0
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Jun 2015 06:07:53 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 1 Jun 2015 18:37:53 +0530
Message-ID: <CAAJEG239+Hb2NAzaLh_9Q15m9mCj=wSBxHC5D3VhYy=1Ery31g@mail.gmail.com>
From: Jatinder Kumar <rinkusaini32@gmail.com>
Subject: [LTP] Getting segmentation fault
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7076462019471818613=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7076462019471818613==
Content-Type: multipart/alternative; boundary=001a1134fb448694ac05177483f8

--001a1134fb448694ac05177483f8
Content-Type: text/plain; charset=UTF-8

Hi All,
I am new to this mailing list.

I am running ltp-test version is 20140422. ltp-test. The result is fine.
But when I run the open_posix test. I am getting Segmentation fault in
pthread_cond_signal_4-2.run-test.

Test environment.
Target Board: Panda version a4
Kernel version 3.10.67.
gcc version 4.8.2.

The same test case is passed for other target board on same kernel. Can you
please help me or give me some hint in this regards.

am I missing any target specific kernel configuration.


Thanks & Regards,
Jatinder Kumar
E-mail : rinkusaini32@gmail.com

--001a1134fb448694ac05177483f8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Hi All,<br></div>I am new to=
 this mailing list. <br></div><br>I am running ltp-test version is 20140422=
. ltp-test. The result is fine. But when I run the open_posix test. I am ge=
tting Segmentation fault in  pthread_cond_signal_4-2.run-test. <br></div><b=
r>Test environment.<br></div>Target Board: Panda version a4<br></div>Kernel=
 version 3.10.67.<br></div>gcc version 4.8.2.=C2=A0 <br><div><div><div><div=
><div><div><div><div><div><div class=3D"gmail_signature"><div dir=3D"ltr"><=
div><div dir=3D"ltr"><div style=3D"text-align:left"><br>The same test case =
is passed for other target board on same kernel. Can you please help me or =
give me some hint in this regards.<br></div><div style=3D"text-align:left">=
<br></div><div style=3D"text-align:left">am I missing any target specific k=
ernel configuration.<br></div><div style=3D"text-align:left">=C2=A0<br></di=
v><div style=3D"text-align:left"><br>Thanks &amp; Regards,<br>Jatinder Kuma=
r<br>E-mail : <span style=3D"text-decoration:underline"></span><a href=3D"m=
ailto:rinkusaini32@gmail.com" target=3D"_blank">rinkusaini32@gmail.com</a><=
span><font color=3D"#888888"><br></font></span></div></div></div></div></di=
v></div>
</div></div></div></div></div></div></div></div></div>

--001a1134fb448694ac05177483f8--


--===============7076462019471818613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============7076462019471818613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7076462019471818613==--

