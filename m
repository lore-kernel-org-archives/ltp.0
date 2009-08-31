Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <markver@us.ibm.com>) id 1MiF9b-0004QP-PN
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2009 22:15:11 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MiF9Q-0001iL-5L
	for ltp-list@lists.sourceforge.net; Mon, 31 Aug 2009 22:15:06 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7VMESnv026820
	for <ltp-list@lists.sourceforge.net>; Mon, 31 Aug 2009 18:14:28 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7VMEsA1239966
	for <ltp-list@lists.sourceforge.net>; Mon, 31 Aug 2009 18:14:54 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7VMEsgr022441
	for <ltp-list@lists.sourceforge.net>; Mon, 31 Aug 2009 18:14:54 -0400
Received: from d01ml096.pok.ibm.com (d01ml096.pok.ibm.com [9.63.10.19])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n7VMEsiN022433
	for <ltp-list@lists.sourceforge.net>; Mon, 31 Aug 2009 18:14:54 -0400
Message-ID: <OF78939903.9E28133E-ON85257623.00782F9F-85257623.007A366B@us.ibm.com>
From: Mark Ver <markver@us.ibm.com>
Date: Mon, 31 Aug 2009 18:14:52 -0400
MIME-Version: 1.0
Subject: [LTP] older distribution levels
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2909682017682878774=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2909682017682878774==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBFCB0DFEBA90F8f9e8a93df938690918c0ABBFCB0DFEBA90F"
Content-Disposition: inline

--0__=0ABBFCB0DFEBA90F8f9e8a93df938690918c0ABBFCB0DFEBA90F
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



We've used LTP to run general verification on supported distribution
levels.  But sometimes supported distributions (even with the latest
updates) still run old stuff.

This usually leads to 2 kinds of issues as the LTP version marches on:
1)  new testcases expect new features and don't properly address compil=
ing
and/or running on the kernel and subsystems provided on the older
distribution.
2)  the LTP build itself requires new software (mostly new versions of
autoconf) which are not yet provided on the older distribution.

Any thoughts on the general policy to use with these distributions?  Fr=
om a
verification stand point, we'd like to use only software that comes as =
part
of the distribution.  Ideally we'd like to build as little as possible =
and
run things straight out of the box.

Does it make sense to just stick to older LTP versions?  Or does it mak=
e
more sense to bug developers and such to update levels and patch code u=
ntil
LTP runs/builds out of the box on target x?  In the meanwhile of course=

building software and patching LTP manually to get around problems.


Thanks,
- Mark Ver

office:  Building 710 / Room 2-RF-10
phone: (845) 435-7794  [tie 8 295-7794]=

--0__=0ABBFCB0DFEBA90F8f9e8a93df938690918c0ABBFCB0DFEBA90F
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>We've used LTP to run general verification on supported distribution=
 levels.  But sometimes supported distributions (even with the latest u=
pdates) still run old stuff.<br>
<br>
This usually leads to 2 kinds of issues as the LTP version marches on:<=
br>
1)  new testcases expect new features and don't properly address compil=
ing and/or running on the kernel and subsystems provided on the older d=
istribution.<br>
2)  the LTP build itself requires new software (mostly new versions of =
autoconf) which are not yet provided on the older distribution.<br>
<br>
Any thoughts on the general policy to use with these distributions?  Fr=
om a verification stand point, we'd like to use only software that come=
s as part of the distribution.  Ideally we'd like to build as little as=
 possible and run things straight out of the box.<br>
<br>
Does it make sense to just stick to older LTP versions?  Or does it mak=
e more sense to bug developers and such to update levels and patch code=
 until LTP runs/builds out of the box on target x?  In the meanwhile of=
 course building software and patching LTP manually to get around probl=
ems.   <br>
<br>
<br>
Thanks,<br>
- Mark Ver<br>
<br>
office:  Building 710 / Room 2-RF-10<br>
phone: (845) 435-7794  [tie 8 295-7794]<br>
</body></html>=

--0__=0ABBFCB0DFEBA90F8f9e8a93df938690918c0ABBFCB0DFEBA90F--



--===============2909682017682878774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============2909682017682878774==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2909682017682878774==--


