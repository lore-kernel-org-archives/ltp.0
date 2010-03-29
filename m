Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <prvs=697c33c7d=sreejithc@tataelxsi.co.in>)
	id 1NwC75-0005Ia-GY
	for ltp-list@lists.sourceforge.net; Mon, 29 Mar 2010 10:22:31 +0000
Received: from smtpin2.mailsecure.in ([121.241.224.3])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NwC71-0005HY-37
	for ltp-list@lists.sourceforge.net; Mon, 29 Mar 2010 10:22:31 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Mon, 29 Mar 2010 15:52:15 +0530
Message-ID: <9D5E1752379A43408015F7FE98466115061B976F@CHNEXVS01.VSNLXCHANGE.COM>
From: "Sreejith C" <sreejithc@tataelxsi.co.in>
Subject: [LTP] mmstress test failing for 9999 NUMPAGES
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1484423631647756745=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1484423631647756745==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CACF29.B3DDBFC5"

This is a multi-part message in MIME format.

------_=_NextPart_001_01CACF29.B3DDBFC5
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

 Currently I am running LTP on a system(arm) with 128 MB of RAM only. When =
I run the tests in sequence I have seen oom killer coming on the 3rd test (=
COW) of mmstess test. As I have reduced the NUMPAGES value to 6000 it was w=
orking fine. I have seen that about 56MB is free before starting with LTP a=
nd it reduces to below 17 MB when it comes to mmstress. Can anyone please t=
ell me what will be the optimum value of NUMPAGES on a system with 128MB of=
 RAM only, I don't want to affect the intention of stress test by just redu=
cing the NUMPAGES to some value.

Regards=20

Sreejith. C=20
Emp No:8103
D& D engineer
TataElxsi Ltd.



------_=_NextPart_001_01CACF29.B3DDBFC5
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Diso-8859-=
1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version 6.5.7653.38">
<TITLE>mmstress test failing for 9999 NUMPAGES</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>Hi,<BR>
<BR>
&nbsp;Currently I am running LTP on a system(arm) with 128 MB of RAM only. =
When I run the tests in sequence I have seen oom killer coming on the 3rd t=
est (COW) of mmstess test. As I have reduced the NUMPAGES value to 6000 it =
was working fine. I have seen that about 56MB is free before starting with =
LTP and it reduces to below 17 MB when it comes to mmstress. Can anyone ple=
ase tell me what will be the optimum value of NUMPAGES on a system with 128=
MB of RAM only, I don't want to affect the intention of stress test by just=
 reducing the NUMPAGES to some value.<BR>
<BR>
Regards<BR>
<BR>
Sreejith. C<BR>
Emp No:8103<BR>
D&amp; D engineer<BR>
TataElxsi Ltd.<BR>
<BR>
</FONT>
</P>

<pre>
</pre></BODY>
</HTML>
------_=_NextPart_001_01CACF29.B3DDBFC5--



--===============1484423631647756745==
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
--===============1484423631647756745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1484423631647756745==--


