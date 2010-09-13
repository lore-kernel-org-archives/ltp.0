Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <romansc@us.ibm.com>) id 1OvAkW-0007t4-5B
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 15:15:16 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvAkT-00028B-VH
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 15:15:16 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8DEua8a000893
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 10:56:36 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8DFF8jN111546
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 11:15:08 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8DFF7HE025057
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 12:15:08 -0300
Received: from d01ml605.pok.ibm.com (d01ml605.pok.ibm.com [9.56.227.91])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o8DFF6QB024999
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Sep 2010 12:15:06 -0300
Message-ID: <OF5A6A8369.7F81ED8A-ON8525779D.0052192C-8525779D.0053C7E9@us.ibm.com>
From: Scott Romanowski <romansc@us.ibm.com>
Date: Mon, 13 Sep 2010 11:15:06 -0400
MIME-Version: 1.0
Subject: [LTP] 20100831 release msgctl10.c bug and patch
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2329679222839443987=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2329679222839443987==
Content-type: multipart/alternative; 
	Boundary="0__=0ABBFD0EDFC19FBC8f9e8a93df938690918c0ABBFD0EDFC19FBC"
Content-Disposition: inline

--0__=0ABBFD0EDFC19FBC8f9e8a93df938690918c0ABBFD0EDFC19FBC
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable



Hi,
MSGMNI should be limited to MAXNPROCS, since keyarray[] only has MAXNPR=
OCS
entries.  Without this, the loop at lines 177-181
	for (i =3D 0; i < nprocs; i++) {
		ok =3D 1;
		do {
			/* Get random key */
			keyarray[i] =3D (key_t) rand();

can write past the end of keyarray[] if there are > MAXNPROCS free mess=
age
queues.

The patch:
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
diff -r 15082dabc40b testcases/kernel/syscalls/ipc/msgctl/msgctl10.c
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c	Mon Sep 13 10:38:=
06
2010 -0400
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c	Mon Sep 13 10:53:=
32
2010 -0400
@@ -452,6 +452,8 @@
 		cleanup();

 	MSGMNI =3D nr_msgqs - get_used_msgqueues();
+	if( MSGMNI > MAXNPROCS	)
+		MSGMNI =3D MAXNPROCS;
 	if (MSGMNI <=3D 0) {
 		tst_resm(TBROK,
 			 "Max number of message queues already used, cannot
create more.");
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~

--
Scott Romanowski=

--0__=0ABBFD0EDFC19FBC8f9e8a93df938690918c0ABBFD0EDFC19FBC
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p>Hi,<br>
MSGMNI should be limited to MAXNPROCS, since keyarray[] only has MAXNPR=
OCS entries.  Without this, the loop at lines 177-181<br>
<font face=3D"Courier New">	</font><b><font color=3D"#000080" face=3D"C=
ourier New">for</font></b><font face=3D"Courier New"> (i </font><b><fon=
t color=3D"#0000FF" face=3D"Courier New">=3D</font></b><font face=3D"Co=
urier New"> </font><font color=3D"#808000" face=3D"Courier New">0</font=
><font face=3D"Courier New">; i </font><b><font color=3D"#0000FF" face=3D=
"Courier New">&lt;</font></b><font face=3D"Courier New"> nprocs; i</fon=
t><b><font color=3D"#0000FF" face=3D"Courier New">++</font></b><font fa=
ce=3D"Courier New">) </font><font color=3D"#008080" face=3D"Courier New=
">{</font><font face=3D"Courier New"><br>
		ok </font><b><font color=3D"#0000FF" face=3D"Courier New">=3D</font><=
/b><font face=3D"Courier New"> </font><font color=3D"#808000" face=3D"C=
ourier New">1</font><font face=3D"Courier New">;<br>
		</font><b><font color=3D"#000080" face=3D"Courier New">do</font></b><=
font face=3D"Courier New"> </font><font color=3D"#008080" face=3D"Couri=
er New">{</font><font face=3D"Courier New"><br>
			</font><i><font color=3D"#008000" face=3D"Courier New">/* Get random=
 key */</font></i><font face=3D"Courier New"><br>
			keyarray[i] </font><b><font color=3D"#0000FF" face=3D"Courier New">=3D=
</font></b><font face=3D"Courier New"> (key_t) </font><b><font face=3D"=
Courier New">rand</font></b><font face=3D"Courier New">();</font><br>
<br>
can write past the end of keyarray[] if there are &gt; MAXNPROCS free m=
essage queues.<br>
<br>
The patch:<br>
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~<br>
<font face=3D"Courier New">diff -r 15082dabc40b testcases/kernel/syscal=
ls/ipc/msgctl/msgctl10.c<br>
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c	Mon Sep 13 10:38:=
06 2010 -0400<br>
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl10.c	Mon Sep 13 10:53:=
32 2010 -0400<br>
@@ -452,6 +452,8 @@<br>
 		cleanup();<br>
 <br>
 	MSGMNI =3D nr_msgqs - get_used_msgqueues();<br>
+	if( MSGMNI &gt; MAXNPROCS	)<br>
+		MSGMNI =3D MAXNPROCS;<br>
 	if (MSGMNI &lt;=3D 0) {<br>
 		tst_resm(TBROK,<br>
 			 &quot;Max number of message queues already used, cannot create mor=
e.&quot;);<br>
</font>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~<br>
<br>
--<br>
Scott Romanowski<br>
</body></html>=

--0__=0ABBFD0EDFC19FBC8f9e8a93df938690918c0ABBFD0EDFC19FBC--



--===============2329679222839443987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev

--===============2329679222839443987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2329679222839443987==--


