Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <raahul4321@gmail.com>) id 1O2jdX-0000jO-KZ
	for ltp-list@lists.sourceforge.net; Fri, 16 Apr 2010 11:23:03 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O2jdW-0003Qo-KZ
	for ltp-list@lists.sourceforge.net; Fri, 16 Apr 2010 11:23:03 +0000
Received: by gya1 with SMTP id 1so1115806gya.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Apr 2010 04:22:57 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 16 Apr 2010 16:52:56 +0530
Message-ID: <h2v72fb0a5c1004160422iaadc7f8p53f73a00d5af088e@mail.gmail.com>
From: rahul agarwal <raahul4321@gmail.com>
Subject: [LTP] problem : please help !!!
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7299220453535460196=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7299220453535460196==
Content-Type: multipart/alternative; boundary=001636c5c0563e8e97048458d5ef

--001636c5c0563e8e97048458d5ef
Content-Type: text/plain; charset=ISO-8859-1

I am running the ltp suite on my embedded system and the following two tests
are failing :-


falloc01 , falloc02 , falloac03   ->   TFAIL : TEST_ERRNO=EFBIG(27): File
too large

clone02, clone03, clone05, clone06  ->  TBROK : Unexpected signal 11
received


I have tried everything to figure out the cause of these test failure but I
still couldn't get the problem solved .


With Regards
Rahul Agarwal
+91-9999721591

--001636c5c0563e8e97048458d5ef
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I=A0am running the ltp suite on my embedded system and the following t=
wo tests are failing :-</div>
<div>=A0</div>
<div>=A0</div>
<div>falloc01 , falloc02 , falloac03=A0=A0 -&gt;=A0 =A0TFAIL : TEST_ERRNO=
=3DEFBIG(27): File too large</div>
<div>=A0</div>
<div>clone02, clone03, clone05, clone06=A0 -&gt;=A0 TBROK : Unexpected sign=
al 11 received</div>
<div>=A0</div>
<div>=A0</div>
<div>I have tried everything to figure out the cause of these test failure =
but=A0I still couldn&#39;t get the problem solved .=A0</div>
<div>=A0</div>
<div>=A0</div>
<div>With Regards</div>
<div>Rahul Agarwal</div>
<div>+91-9999721591=A0</div>

--001636c5c0563e8e97048458d5ef--


--===============7299220453535460196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============7299220453535460196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7299220453535460196==--

