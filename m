Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <anthony.ton@ericsson.com>) id 1NwoGF-00028w-Kc
	for ltp-list@lists.sourceforge.net; Wed, 31 Mar 2010 03:06:31 +0000
Received: from imr2.ericy.com ([198.24.6.3])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NwoGE-00012F-HP
	for ltp-list@lists.sourceforge.net; Wed, 31 Mar 2010 03:06:31 +0000
Received: from eusaamw0707.eamcs.ericsson.se ([147.117.20.32])
	by imr2.ericy.com (8.13.1/8.13.1) with ESMTP id o2V3A3AV014383
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Mar 2010 22:10:03 -0500
From: Anthony Ton <anthony.ton@ericsson.com>
Date: Tue, 30 Mar 2010 23:06:22 -0400
Message-ID: <E0B6230F32558E43951AF1B0DEBF98102119DC54EF@EUSAACMS0714.eamcs.ericsson.se>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Fcntl16 test case 2 failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5072415091529063821=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============5072415091529063821==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_E0B6230F32558E43951AF1B0DEBF98102119DC54EFEUSAACMS0714e_"

--_000_E0B6230F32558E43951AF1B0DEBF98102119DC54EFEUSAACMS0714e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi LTP Team,
I run test case fcntl16 and get a failure on test case 2 with messages belo=
w

fcntl16     0  TINFO  :  Entering block 2
fcntl16     1  TFAIL  :  First parent lock failed
fcntl16     2  TFAIL  :  Test case 1, errno =3D 37
fcntl16     0  TINFO  :  Test case 2: with mandatory record locking FAILED

I look into the code and think that it is trying to do a lock on the entire=
 file with write lock using option F_WRLCK, 0, 0L, 0L, IGNORED.  Is it corr=
ect?  Can someone elaborate a little more?  What does the errno =3D 37 mean=
?

Thanks,
Anthony


--_000_E0B6230F32558E43951AF1B0DEBF98102119DC54EFEUSAACMS0714e_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>Hi LTP Team,</div>
<div>I run test case fcntl16 and get a failure on test case 2 with messages=
 below</div>
<div>&nbsp;</div>
<div>fcntl16&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; Entering b=
lock 2</div>
<div>fcntl16&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp; :&nbsp; First pare=
nt lock failed</div>
<div>fcntl16&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp; TFAIL&nbsp; :&nbsp; Test case =
1, errno =3D 37</div>
<div>fcntl16&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; Test case =
2: with mandatory record locking FAILED</div>
<div>&nbsp;</div>
<div>I look into the code and think that it is trying to do a lock on the e=
ntire file with write lock using option F_WRLCK, 0, 0L, 0L, IGNORED.&nbsp; =
Is it correct?&nbsp; Can someone elaborate a little more?&nbsp; What does t=
he errno =3D 37 mean?</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Anthony</div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_E0B6230F32558E43951AF1B0DEBF98102119DC54EFEUSAACMS0714e_--


--===============5072415091529063821==
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
--===============5072415091529063821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5072415091529063821==--

