Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <imagezhang.au@gmail.com>) id 1QRbcp-0007eP-0U
	for ltp-list@lists.sourceforge.net; Wed, 01 Jun 2011 02:57:39 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1QRbco-0004Xh-Bj
	for ltp-list@lists.sourceforge.net; Wed, 01 Jun 2011 02:57:38 +0000
Received: by ywg8 with SMTP id 8so2692851ywg.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 31 May 2011 19:57:33 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 1 Jun 2011 12:57:32 +1000
Message-ID: <BANLkTikiOmV3zKs6ayFk52GwxAUzqe6O-A@mail.gmail.com>
From: jian zhang <imagezhang.tech@gmail.com>
Subject: [LTP] LTP uClibc support.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6111764948226659754=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6111764948226659754==
Content-Type: multipart/alternative; boundary=20cf3040ec049834a704a49daea0

--20cf3040ec049834a704a49daea0
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

Currently I am trying to cross compile LTP to a mips linux platform which
using uClibc-0.9.31.

The problem is, by default the uClibc do not support obsoleted BSD signal
handling and Large File Support, which actually are not needed in the real
system.

Except rebuild the uClibc with those support, is there any easy way, to
configure the LTP to make it work? Or, if not currently, is there any work
in progress to make LTP more friendly to the embedded system?

If there is any other test suite more fit for embedded linux design, please
let me know.

Thanks and Best Regards,
Jian

--20cf3040ec049834a704a49daea0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span style=3D"border-collapse:collapse;font-family:arial, sans-serif;font-=
size:13px">Hi All,<div><br></div><div>Currently I am trying to cross compil=
e LTP to a mips linux platform which using uClibc-0.9.31.</div>
<div><br></div><div>The problem is, by default the uClibc do not support ob=
soleted BSD signal handling and Large File Support, which actually are not =
needed in the real system.=A0</div><div><br></div><div>Except rebuild the u=
Clibc with those support, is there any easy way, to configure the LTP to ma=
ke it work? Or, if not currently, is there any work in progress to make LTP=
 more friendly to the embedded system?</div>

<div><br></div><div>If there is any other test suite more fit for embedded =
linux design, please let me know.</div><div><br></div><div>Thanks and Best =
Regards,</div><div>Jian</div></span>

--20cf3040ec049834a704a49daea0--


--===============6111764948226659754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Simplify data backup and recovery for your virtual environment with vRanger. 
Installation's a snap, and flexible recovery options mean your data is safe,
secure and there when you need it. Data protection magic?
Nope - It's vRanger. Get your free trial download today. 
http://p.sf.net/sfu/quest-sfdev2dev
--===============6111764948226659754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6111764948226659754==--

