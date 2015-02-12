Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Diwakar.Sharma@in.bosch.com>) id 1YLlNv-0004OT-Qh
	for ltp-list@lists.sourceforge.net; Thu, 12 Feb 2015 04:28:15 +0000
Received: from imta22.fe.bosch.de ([139.15.243.26])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YLlNq-0001cN-9X
	for ltp-list@lists.sourceforge.net; Thu, 12 Feb 2015 04:28:15 +0000
Received: from smtp6-v.fe.bosch.de (imta23.fe.bosch.de [139.15.243.227])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 17C0184028A
	for <ltp-list@lists.sourceforge.net>;
	Thu, 12 Feb 2015 05:08:26 +0100 (CET)
Received: from vsmta12.fe.internet.bosch.com (unknown [10.4.98.52])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 5E5771580159
	for <ltp-list@lists.sourceforge.net>;
	Thu, 12 Feb 2015 05:08:19 +0100 (CET)
Received: from FE-MBX1003.de.bosch.com (vsgw21.fe.internet.bosch.com
	[10.4.98.19])
	by vsmta12.fe.internet.bosch.com (Postfix) with ESMTP id 34F361B80C39
	for <ltp-list@lists.sourceforge.net>;
	Thu, 12 Feb 2015 05:08:19 +0100 (CET)
From: "Diwakar Sharma (RBEI/ECF3)" <Diwakar.Sharma@in.bosch.com>
Date: Thu, 12 Feb 2015 04:08:14 +0000
Message-ID: <fa5f4e375e5c464d94ee43b94193054f@SGPMBX1009.APAC.bosch.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP]  fs tests causing extensive SD card r/w?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5796998398375582647=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============5796998398375582647==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_fa5f4e375e5c464d94ee43b94193054fSGPMBX1009APACboschcom_"

--_000_fa5f4e375e5c464d94ee43b94193054fSGPMBX1009APACboschcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello all,

I would like some clarity on which of the file system tests are doing most =
extensive r/w operations. I run these LTP fs tests on an SD card. For past =
sometime I face issue where the card gets disconnected with below errors at=
 times and doesn't get detected again. This mostly happens on ftest* where =
sync/fsync is happening:

I/O error , DID_NO_CONNECT

[ 3277.237974] EXT4-fs error (device sdc1): ext4_put_super:861: Couldn't cl=
ean up the journal

I am suspecting that these tests over a period of time have caused the card=
's flash memory life to near end, because when I used a newer card yesterda=
y the results improved and these errors didn't come.
Is above understanding correct?

Best regards
Diwakar Sharma




--_000_fa5f4e375e5c464d94ee43b94193054fSGPMBX1009APACboschcom_
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
<font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">
<div>Hello all,</div>
<div>&nbsp;</div>
<div>I would like some clarity on which of the file system tests are doing =
most extensive r/w operations. I run these LTP fs tests on an SD card. For =
past sometime I face issue where the card gets disconnected with below erro=
rs at times and doesn&#8217;t get detected
again. This mostly happens on <b>ftest</b><b>*</b><b> </b>where <i>sync/fsy=
nc</i> is happening:</div>
<div>&nbsp;</div>
<div><font size=3D"2" color=3D"red"><span style=3D"font-size:10pt;">I/O err=
or , DID_NO_CONNECT </span></font></div>
<div><font size=3D"2" color=3D"red"><span style=3D"font-size:10pt;">&nbsp;<=
/span></font></div>
<div><font size=3D"2" color=3D"red"><span style=3D"font-size:10pt;">[ 3277.=
237974] EXT4-fs error (device sdc1): ext4_put_super:861: Couldn't clean up =
the journal</span></font></div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
<div>I am suspecting that these tests over a period of time have caused the=
 card&#8217;s flash memory life to near end, because when I used a newer ca=
rd yesterday the results improved and these errors didn&#8217;t come.</div>
<div>Is above understanding correct?</div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
<div><font face=3D"Aparajita" size=3D"4" color=3D"#002060"><span style=3D"f=
ont-size:14pt;">Best regards</span></font></div>
<div><font face=3D"Aparajita" size=3D"4" color=3D"#002060"><span style=3D"f=
ont-size:14pt;"><b>Diwakar Sharma</b></span></font></div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
<div><font face=3D"Times New Roman">&nbsp;</font></div>
</span></font>
</body>
</html>

--_000_fa5f4e375e5c464d94ee43b94193054fSGPMBX1009APACboschcom_--



--===============5796998398375582647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
--===============5796998398375582647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5796998398375582647==--


