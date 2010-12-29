Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <violetleigh@gmail.com>) id 1PXsRl-0003vx-MS
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:53 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXsRk-00013F-PN
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:53 +0000
Received: by mail-gx0-f175.google.com with SMTP id 20so4618986gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 01:35:52 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 29 Dec 2010 17:35:52 +0800
Message-ID: <AANLkTi=gsOkRM0NQNsKp5-L37hTDwd4+5euqXD9E5gXe@mail.gmail.com>
From: Vivi <violetleigh@gmail.com>
Subject: [LTP]  [Bug Fix] utimes01.c can't build in uclinux
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2627014185127518310=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP mailing list <ltp-list@lists.sourceforge.net>

--===============2627014185127518310==
Content-Type: multipart/alternative; boundary=0016368e1c0e91df200498894b19

--0016368e1c0e91df200498894b19
Content-Type: text/plain; charset=ISO-8859-1

LTP test case utimes01.c can't build in uclinux as it failed in file
common_j_h.c.
Fix this by diable fork related part in uclinux platform.

--
Index: testcases/kernel/syscalls/utils/common_j_h.c
===================================================================
--- testcases/kernel/syscalls/utils/common_j_h.c
+++ testcases/kernel/syscalls/utils/common_j_h.c
@@ -115,6 +115,7 @@
 /*
  * Generate a child process which will send a signal
  */
+#ifndef UCLINUX
 pid_t create_sig_proc(unsigned long usec, int sig, unsigned count)
 {
        pid_t pid, cpid;
@@ -142,6 +143,7 @@
                return cpid;
        }
 }
+#endif


 /*
@@ -351,6 +353,7 @@
 /*
  * Get unexist pid
  */
+#ifndef UCLINUX
 pid_t get_unexist_pid(void)
 {
        pid_t pid;
@@ -368,4 +371,4 @@
                return pid;
        }
 }
-
+#endif
--



Best regards,
Vivi Li

--0016368e1c0e91df200498894b19
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

LTP test case utimes01.c can&#39;t build in uclinux as it failed in file co=
mmon_j_h.c.<br>Fix this by diable fork related part in uclinux platform.<br=
><br>--<br>Index: testcases/kernel/syscalls/utils/common_j_h.c<br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>


--- testcases/kernel/syscalls/utils/common_j_h.c<br>+++ testcases/kernel/sy=
scalls/utils/common_j_h.c<br>@@ -115,6 +115,7 @@<br>=A0/*<br>=A0 * Generate=
 a child process which will send a signal<br>
=A0 */<br>+#ifndef UCLINUX<br>=A0pid_t create_sig_proc(unsigned long usec, =
int sig, unsigned count)<br>=A0{<br>=A0=A0=A0=A0=A0=A0=A0 pid_t pid, cpid;<=
br>@@ -142,6 +143,7 @@<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret=
urn cpid;<br>=A0=A0=A0=A0=A0=A0=A0 }<br>=A0}<br>+#endif<br><br>


<br>=A0/*<br>@@ -351,6 +353,7 @@<br>=A0/*<br>=A0 * Get unexist pid<br>=A0 *=
/<br>+#ifndef UCLINUX<br>=A0pid_t get_unexist_pid(void)<br>=A0{<br>=A0=A0=
=A0=A0=A0=A0=A0 pid_t pid;<br>@@ -368,4 +371,4 @@<br>=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 return pid;<br>=A0=A0=A0=A0=A0=A0=A0 }<br>=A0}<br>


-<br>+#endif<br>--<br><br><br><br>Best regards,<br>Vivi Li

--0016368e1c0e91df200498894b19--


--===============2627014185127518310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============2627014185127518310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2627014185127518310==--

