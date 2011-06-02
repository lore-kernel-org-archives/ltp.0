Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <krwhitney@gmail.com>) id 1QSA8D-0000Qj-Tp
	for ltp-list@lists.sourceforge.net; Thu, 02 Jun 2011 15:48:21 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QSA8D-00028y-9H
	for ltp-list@lists.sourceforge.net; Thu, 02 Jun 2011 15:48:21 +0000
Received: by wye20 with SMTP id 20so1082335wye.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jun 2011 08:48:15 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jun 2011 11:48:15 -0400
Message-ID: <BANLkTinjK1N+jzhSOJrECj3O95k16+6Fkg@mail.gmail.com>
From: "Kevin R. Whitney" <krwhitney@gmail.com>
Subject: [LTP] open posix "sigpause" test defect
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3398458072775634923=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3398458072775634923==
Content-Type: multipart/alternative; boundary=002215b03f62b0532404a4bc90e6

--002215b03f62b0532404a4bc90e6
Content-Type: text/plain; charset=UTF-8

Hello,

This is my first post, so if I'm in the wrong place, please direct me to the
correct place!

I found that
test testcases/open_posix_testsuite/conformance/interfaces/sigpause/3-1.c is
unstable because of a defect in the code.  Of course I can provide the logic
and diffs, but where/who should I send it to?

Thanks all,

Kevin W

--002215b03f62b0532404a4bc90e6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,<div><br></div><div>This is my first post, so if I&#39;m in the wrong=
 place, please direct me to the correct place!</div><div><br></div><div>I f=
ound that test=C2=A0testcases/open_posix_testsuite/conformance/interfaces/s=
igpause/3-1.c is unstable because of a defect in the code. =C2=A0Of course =
I can provide the logic and diffs, but where/who should I send it to?</div>
<div><br></div><div>Thanks all,</div><div><br></div><div>Kevin W<br clear=
=3D"all"><br>
</div>

--002215b03f62b0532404a4bc90e6--


--===============3398458072775634923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Simplify data backup and recovery for your virtual environment with vRanger.
Installation's a snap, and flexible recovery options mean your data is safe,
secure and there when you need it. Discover what all the cheering's about.
Get your free trial download today. 
http://p.sf.net/sfu/quest-dev2dev2 
--===============3398458072775634923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3398458072775634923==--

