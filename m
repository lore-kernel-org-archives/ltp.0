Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <romansc@us.ibm.com>) id 1OvDFb-0003X5-O1
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 17:55:31 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvDFa-0001yU-RK
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 17:55:31 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8DHaqek020251
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 13:36:52 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8DHt8qL1290478
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 13:55:09 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8DHt88b032183
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 13:55:08 -0400
Received: from d01ml605.pok.ibm.com (d01ml605.pok.ibm.com [9.56.227.91])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o8DHt73A032153
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 13:55:07 -0400
Message-ID: <OF2051634D.461B535C-ON8525779D.0061808E-8525779D.00626E02@us.ibm.com>
From: Scott Romanowski <romansc@us.ibm.com>
Date: Mon, 13 Sep 2010 13:55:06 -0400
MIME-Version: 1.0
Subject: Re: [LTP] hugeshmat
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6396821030928879119=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6396821030928879119==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBFD0EDFF2061E8f9e8a93df938690918c0ABBFD0EDFF2061E"
Content-Disposition: inline

--0__=0ABBFD0EDFF2061E8f9e8a93df938690918c0ABBFD0EDFF2061E
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



>hi,
>    I am getting error in hugetlb testcase, most of the tests are fail=
ing
>because of the following error:-
>
>"could not read hugepages from /proc/meminfo"
>hugeshmat tests are having this error.
>please help me as how to resolve this error.
>
>--
>Regards,
>Arjit Sharma.

I could not find that specific error in either the 20100228 or 20100831=

releases.  There are similar ones in lib/system_specific_hugepages_info=
.c
though, in get_no_of_hugepages() and hugepages_size().  If you
cat /proc/meminfo, do you see any lines for hugepages?  For example:

HugePages_Total:    10
HugePages_Free:     10
HugePages_Rsvd:      0
Hugepagesize:     2048 kB

If the first and last lines are not there, you would get an error messa=
ge
like what you see.

--
Scott Romanowski
978-899-5384
BG125C=

--0__=0ABBFD0EDFF2061E8f9e8a93df938690918c0ABBFD0EDFF2061E
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>&gt;hi,<br>
&gt;    I am getting error in hugetlb testcase, most of the tests are f=
ailing<br>
&gt;because of the following error:-<br>
&gt;<br>
&gt;&quot;could not read hugepages from /proc/meminfo&quot;<br>
&gt;hugeshmat tests are having this error.<br>
&gt;please help me as how to resolve this error.<br>
&gt;<br>
&gt;-- <br>
&gt;Regards,<br>
&gt;Arjit Sharma.<br>
<br>
I could not find that specific error in either the 20100228 or 20100831=
 releases.  There are similar ones in lib/system_specific_hugepages_inf=
o.c though, in get_no_of_hugepages() and hugepages_size().  If you cat =
/proc/meminfo, do you see any lines for hugepages?  For example:<br>
<br>
HugePages_Total:    10<br>
HugePages_Free:     10<br>
HugePages_Rsvd:      0<br>
Hugepagesize:     2048 kB<br>
<br>
If the first and last lines are not there, you would get an error messa=
ge like what you see.<br>
<br>
--<br>
Scott Romanowski<br>
978-899-5384<br>
BG125C</body></html>=

--0__=0ABBFD0EDFF2061E8f9e8a93df938690918c0ABBFD0EDFF2061E--



--===============6396821030928879119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev

--===============6396821030928879119==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6396821030928879119==--


