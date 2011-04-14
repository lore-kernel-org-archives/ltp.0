Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <romansc@us.ibm.com>) id 1QANPp-00039v-15
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 14:21:01 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1QANPl-00022e-4T
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 14:21:00 +0000
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3EDsptM023903
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Apr 2011 09:54:51 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 334F938C803B
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Apr 2011 10:20:39 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3EEKmGX2637922
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Apr 2011 10:20:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p3EEKmBG001110
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Apr 2011 11:20:48 -0300
Received: from d01ml605.pok.ibm.com (d01ml605.pok.ibm.com [9.56.227.91])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p3EEKmNH001098
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Apr 2011 11:20:48 -0300
In-Reply-To: <OFCEFD64D0.BC49FB71-ON8525785E.0065EB2E-8525785E.0066D6A1@LocalDomain>
References: <OFCEFD64D0.BC49FB71-ON8525785E.0065EB2E-8525785E.0066D6A1@LocalDomain>
Message-ID: <OF7FE76060.EAACC2A8-ON85257872.004D62BE-85257872.004ECF6E@us.ibm.com>
From: Scott Romanowski <romansc@us.ibm.com>
Date: Thu, 14 Apr 2011 10:20:47 -0400
MIME-Version: 1.0
Subject: [LTP] ioctl01.c bug in error message
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4176843925637638924=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4176843925637638924==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBF2E1DFDEE42E8f9e8a93df938690918c0ABBF2E1DFDEE42E"
Content-Disposition: inline

--0__=0ABBF2E1DFDEE42E8f9e8a93df938690918c0ABBF2E1DFDEE42E
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


testcases/kernel/syscalls/ioctl/ioctl01.c has a bug where, if the open(=
)
fails, the error message it prints uses an uninitialized char * variabl=
e
instead of the one that holds the device.  This only affects the error
message.  The solution is to use 'devname' instead of 'tty' in the tst_=
brkm
(), and you can also delete the unused variable, 'char *tty;'.

diff -r a58e88d4c024 testcases/kernel/syscalls/ioctl/ioctl01.c
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c	Fri Mar 25 17:21:49 201=
1
-0400
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c	Thu Apr 14 10:08:39 201=
1
-0400
@@ -71,7 +71,6 @@
 int fd, fd1;
 int bfd =3D -1;

-char *tty;
 struct termio termio;

 struct test_case_t {
@@ -125,7 +124,7 @@

 	if ((fd =3D open(devname, O_RDWR, 0777)) < 0) {
 		tst_brkm(TBROK, cleanup, "Couldn't open %s, errno =3D %d",
-			 tty, errno);
+			 devname, errno);
 	}

 	TEST_EXP_ENOS(exp_enos);

Signed-off-by: Scott Romanowski <romansc@us.ibm.com>,

--
Scott Romanowski
978-899-5384
IBM
Cubicle BG125C
550 King St.
Littleton, MA 01460=

--0__=0ABBF2E1DFDEE42E8f9e8a93df938690918c0ABBF2E1DFDEE42E
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font size=3D"2" face=3D"sans-serif">testcases/kernel/syscalls/ioctl=
/ioctl01.c has a bug where, if the open() fails, the error message it p=
rints uses an uninitialized char * variable instead of the one that hol=
ds the device.  This only affects the error message.  The solution is t=
o use 'devname' instead of 'tty' in the tst_brkm(), and you can also de=
lete the unused variable, 'char *tty;'.</font><br>
<br>
<tt><font size=3D"2">diff -r a58e88d4c024 testcases/kernel/syscalls/ioc=
tl/ioctl01.c</font></tt><br>
<tt><font size=3D"2">--- a/testcases/kernel/syscalls/ioctl/ioctl01.c	Fr=
i Mar 25 17:21:49 2011 -0400</font></tt><br>
<tt><font size=3D"2">+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c	Th=
u Apr 14 10:08:39 2011 -0400</font></tt><br>
<tt><font size=3D"2">@@ -71,7 +71,6 @@</font></tt><br>
<tt><font size=3D"2"> int fd, fd1;</font></tt><br>
<tt><font size=3D"2"> int bfd =3D -1;</font></tt><br>
<tt><font size=3D"2"> </font></tt><br>
<tt><font size=3D"2">-char *tty;</font></tt><br>
<tt><font size=3D"2"> struct termio termio;</font></tt><br>
<tt><font size=3D"2"> </font></tt><br>
<tt><font size=3D"2"> struct test_case_t {</font></tt><br>
<tt><font size=3D"2">@@ -125,7 +124,7 @@</font></tt><br>
<tt><font size=3D"2"> </font></tt><br>
<tt><font size=3D"2"> 	if ((fd =3D open(devname, O_RDWR, 0777)) &lt; 0)=
 {</font></tt><br>
<tt><font size=3D"2"> 		tst_brkm(TBROK, cleanup, &quot;Couldn't open %s=
, errno =3D %d&quot;,</font></tt><br>
<tt><font size=3D"2">-			 tty, errno);</font></tt><br>
<tt><font size=3D"2">+			 devname, errno);</font></tt><br>
<tt><font size=3D"2"> 	}</font></tt><br>
<tt><font size=3D"2"> </font></tt><br>
<tt><font size=3D"2"> 	TEST_EXP_ENOS(exp_enos);</font></tt><br>
<br>
<font size=3D"2" face=3D"sans-serif">Signed-off-by: Scott Romanowski &l=
t;romansc@us.ibm.com&gt;,</font><br>
<br>
<font size=3D"2" face=3D"sans-serif">--<br>
Scott Romanowski<br>
978-899-5384<br>
IBM<br>
Cubicle BG125C<br>
550 King St.<br>
Littleton, MA 01460</font></body></html>=

--0__=0ABBF2E1DFDEE42E8f9e8a93df938690918c0ABBF2E1DFDEE42E--



--===============4176843925637638924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
--===============4176843925637638924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4176843925637638924==--


