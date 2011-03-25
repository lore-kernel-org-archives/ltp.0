Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <romansc@us.ibm.com>) id 1Q3Bym-0004pX-Fo
	for ltp-list@lists.sourceforge.net; Fri, 25 Mar 2011 18:43:24 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1Q3Byl-00069H-Ko
	for ltp-list@lists.sourceforge.net; Fri, 25 Mar 2011 18:43:24 +0000
Received: from d01dlp01.pok.ibm.com (d01dlp01.pok.ibm.com [9.56.224.56])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2PIGCfu000947
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Mar 2011 14:16:12 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0148B38C8039
	for <ltp-list@lists.sourceforge.net>;
	Fri, 25 Mar 2011 14:43:12 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p2PIhHOZ382604
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Mar 2011 14:43:17 -0400
Received: from d01av05.pok.ibm.com (loopback [127.0.0.1])
	by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p2PIhHuC014852
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Mar 2011 14:43:17 -0400
Received: from d01ml605.pok.ibm.com (d01ml605.pok.ibm.com [9.56.227.91])
	by d01av05.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p2PIhHke014848
	for <ltp-list@lists.sourceforge.net>; Fri, 25 Mar 2011 14:43:17 -0400
Message-ID: <OFCEFD64D0.BC49FB71-ON8525785E.0065EB2E-8525785E.0066D6A1@us.ibm.com>
From: Scott Romanowski <romansc@us.ibm.com>
Date: Fri, 25 Mar 2011 14:43:15 -0400
MIME-Version: 1.0
Subject: [LTP] clone06.c getenv("TERM") bug
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7157061170281351797=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7157061170281351797==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBF2CDDFF66DBE8f9e8a93df938690918c0ABBF2CDDFF66DBE"
Content-Disposition: inline

--0__=0ABBF2CDDFF66DBE8f9e8a93df938690918c0ABBF2CDDFF66DBE
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



Hi,
While testing with LTP across ssh, i.e. "ssh someone@somewhere './runlt=
p'",
I ran across a problem with clone06.c.  In those circumstances, there i=
s no
TERM enviromnent variable, so getenv("TERM") will return NULL.    clone=
06.c
doesn't test for that before using the returned pointer in strcmp, whic=
h
will cause a segv error.
  parent_env =3D getenv("TERM");
  if ((strcmp(buff, parent_env)) =3D=3D 0) {

A solution is to do the same check as in the child_environ() function,
which will also result in the test passing if TERM is undefined.  The
trivial patch is below.


--- a/testcases/kernel/syscalls/clone/clone06.c Thu Mar 03 16:17:40 201=
1
-0500
+++ b/testcases/kernel/syscalls/clone/clone06.c Fri Mar 25 14:35:26 201=
1
-0400
@@ -146,7 +146,7 @@
                        tst_resm(TWARN|TERRNO, "close(pfd[0]) failed");=

                }

-               parent_env =3D getenv("TERM");
+               parent_env =3D getenv("TERM") ? : "";

                if ((strcmp(buff, parent_env)) =3D=3D 0) {
                        tst_resm(TPASS, "Test Passed");



Signed-off-by: Scott Romanowski <romansc@us.ibm.com>,
--
Scott Romanowski
978-899-5384
IBM
Cubicle BG125C
550 King St.
Littleton, MA 01460=

--0__=0ABBF2CDDFF66DBE8f9e8a93df938690918c0ABBF2CDDFF66DBE
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font size=3D"2" face=3D"sans-serif">Hi,</font><br>
<font size=3D"2" face=3D"sans-serif">While testing with LTP across ssh,=
 i.e. &quot;ssh someone@somewhere './runltp'&quot;, I ran across a prob=
lem with clone06.c.  In those circumstances, there is no TERM enviromne=
nt variable, so getenv(&quot;TERM&quot;) will return NULL.    clone06.c=
 doesn't test for that before using the returned pointer in strcmp, whi=
ch will cause a segv error.</font><br>
<font size=3D"2" face=3D"Courier New">  parent_env </font><font size=3D=
"2" color=3D"#0000FF" face=3D"Courier New"><b>=3D</b></font><font size=3D=
"2" face=3D"Courier New"> </font><font size=3D"2" face=3D"Courier New">=
<b>getenv</b></font><font size=3D"2" face=3D"Courier New">(</font><font=
 size=3D"2" color=3D"#800000" face=3D"Courier New">&quot;TERM&quot;</fo=
nt><font size=3D"2" face=3D"Courier New">)</font><font size=3D"2" face=3D=
"Courier New">;<br>
  </font><font size=3D"2" color=3D"#000080" face=3D"Courier New"><b>if<=
/b></font><font size=3D"2" face=3D"Courier New"> ((</font><font size=3D=
"2" face=3D"Courier New"><b>strcmp</b></font><font size=3D"2" face=3D"C=
ourier New">(buff, parent_env)) </font><font size=3D"2" color=3D"#0000F=
F" face=3D"Courier New"><b>=3D=3D</b></font><font size=3D"2" face=3D"Co=
urier New"> </font><font size=3D"2" color=3D"#808000" face=3D"Courier N=
ew">0</font><font size=3D"2" face=3D"Courier New">) </font><font size=3D=
"2" color=3D"#008080" face=3D"Courier New">{</font><font size=3D"2" fac=
e=3D"Courier New"><br>
</font><br>
<font size=3D"2" face=3D"sans-serif">A solution is to do the same check=
 as in the child_environ() function, which will also result in the test=
 passing if TERM is undefined.  The trivial patch is below.</font><br>
<br>
<br>
<font size=3D"2" face=3D"Courier New">--- a/testcases/kernel/syscalls/c=
lone/clone06.c Thu Mar 03 16:17:40 2011 -0500</font><br>
<font size=3D"2" face=3D"Courier New">+++ b/testcases/kernel/syscalls/c=
lone/clone06.c Fri Mar 25 14:35:26 2011 -0400</font><br>
<font size=3D"2" face=3D"Courier New">@@ -146,7 +146,7 @@</font><br>
<font size=3D"2" face=3D"Courier New">                        tst_resm(=
TWARN|TERRNO, &quot;close(pfd[0]) failed&quot;);</font><br>
<font size=3D"2" face=3D"Courier New">                }</font><br>
<br>
<font size=3D"2" face=3D"Courier New">-               parent_env =3D ge=
tenv(&quot;TERM&quot;);</font><br>
<font size=3D"2" face=3D"Courier New">+               parent_env =3D ge=
tenv(&quot;TERM&quot;) ? : &quot;&quot;;</font><br>
<br>
<font size=3D"2" face=3D"Courier New">                if ((strcmp(buff,=
 parent_env)) =3D=3D 0) {</font><br>
<font size=3D"2" face=3D"Courier New">                        tst_resm(=
TPASS, &quot;Test Passed&quot;);</font><br>
<br>
<br>
<br>
<tt><font size=3D"2">Signed-off-by: Scott Romanowski &lt;romansc@us.ibm=
.com&gt;,</font></tt><br>
<font size=3D"2" face=3D"sans-serif">--<br>
Scott Romanowski<br>
978-899-5384<br>
IBM<br>
Cubicle BG125C<br>
550 King St.<br>
Littleton, MA 01460</font></body></html>=

--0__=0ABBF2CDDFF66DBE8f9e8a93df938690918c0ABBF2CDDFF66DBE--



--===============7157061170281351797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
--===============7157061170281351797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7157061170281351797==--


