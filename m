Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <violetleigh@gmail.com>) id 1PXsRX-0003ui-Uy
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:39 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXsRW-0007ny-SH
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:39 +0000
Received: by gyh20 with SMTP id 20so4154961gyh.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 01:35:33 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 29 Dec 2010 17:35:33 +0800
Message-ID: <AANLkTimKGoNfnr0s5PgBxzx+hZOW_8j-k8Dewbw=2e8M@mail.gmail.com>
From: Vivi <violetleigh@gmail.com>
Subject: [LTP]  [Bug Fix] fcntl15 is not completely ported to uClinux
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8018155581182537661=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP mailing list <ltp-list@lists.sourceforge.net>

--===============8018155581182537661==
Content-Type: multipart/alternative; boundary=0016368e1c0e6ef4f00498894a17

--0016368e1c0e6ef4f00498894a17
Content-Type: text/plain; charset=ISO-8859-1

The code of fcntl15 is not completely ported to uClinux.
So it will fail on uclinux platform.

Bellow is the patch:
--
Index: testcases/kernel/syscalls/fcntl/fcntl15.c
===================================================================
--- testcases/kernel/syscalls/fcntl/fcntl15.c
+++ testcases/kernel/syscalls/fcntl/fcntl15.c
@@ -185,12 +185,17 @@
 }

 #ifdef UCLINUX
-int uc_file_flag, uc_file_mode;
+int uc_file_flag, uc_file_mode, uc_dup_flag;

 void dochild1_uc()
 {
        dochild1(uc_file_flag, uc_file_mode);
 }
+
+void dochild2_uc()
+{
+       dochild2(uc_file_flag, uc_file_mode, uc_dup_flag);
+}
 #endif

 int dofork(int file_flag, int file_mode)
@@ -462,7 +467,15 @@
                tst_rmdir();
                return 1;
        } else if (child2 == 0) {       /* child */
+#ifdef UCLINUX
+               if (self_exec(argv0, "ndddds", 2, file_flag, file_mode,
dup_flag,
+                             parent, tmpname) < 0) {
+                       perror("self_exec failure");
+                       return(1);
+               }
+#else
                dochild2(file_flag, file_mode, dup_flag);
+#endif
        }

        /* parent */
@@ -546,6 +559,10 @@
 #ifdef UCLINUX
        maybe_run_child(&dochild1_uc, "nddds", 1, &uc_file_flag,
                        &uc_file_mode, &parent, tmpname);
+
+       maybe_run_child(&dochild2_uc, "ndddds", 2, &uc_file_flag,
+                       &uc_file_mode, &uc_dup_flag, &parent, tmpname);
+
        argv0 = av[0];
 #endif

--



Best regards,
Vivi Li

--0016368e1c0e6ef4f00498894a17
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The code of fcntl15 is not completely ported to uClinux.<br>So it will fail=
 on uclinux platform.<br><br>Bellow is the patch:<br>--<br>Index: testcases=
/kernel/syscalls/fcntl/fcntl15.c<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>




--- testcases/kernel/syscalls/fcntl/fcntl15.c<br>+++ testcases/kernel/sysca=
lls/fcntl/fcntl15.c<br>@@ -185,12 +185,17 @@<br>=A0}<br><br>=A0#ifdef UCLIN=
UX<br>-int uc_file_flag, uc_file_mode;<br>

+int uc_file_flag, uc_file_mode, uc_dup_flag;<br><br>=A0void dochild1_uc()<=
br>=A0{<br>=A0=A0=A0=A0=A0=A0=A0 dochild1(uc_file_flag, uc_file_mode);<br>=
=A0}<br>+<br>+void dochild2_uc()<br>+{<br>+=A0=A0=A0=A0=A0=A0 dochild2(uc_f=
ile_flag, uc_file_mode, uc_dup_flag);<br>




+}<br>=A0#endif<br><br>=A0int dofork(int file_flag, int file_mode)<br>@@ -4=
62,7 +467,15 @@<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_rmdir(=
);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 1;<br>=A0=A0=A0=
=A0=A0=A0=A0 } else if (child2 =3D=3D 0) {=A0=A0=A0=A0=A0=A0 /* child */<br=
>+#ifdef UCLINUX<br>




+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (self_exec(argv0, &quot;nddd=
ds&quot;, 2, file_flag, file_mode, dup_flag,<br>+=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 parent, tmpnam=
e) &lt; 0) {<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 perror(&quot;self_exec failure&quot;);<br>




+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return(=
1);<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }<br>+#else<br>=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dochild2(file_flag, file_mode, dup_fla=
g);<br>+#endif<br>=A0=A0=A0=A0=A0=A0=A0 }<br><br>=A0=A0=A0=A0=A0=A0=A0 /* p=
arent */<br>@@ -546,6 +559,10 @@<br>=A0#ifdef UCLINUX<br>




=A0=A0=A0=A0=A0=A0=A0 maybe_run_child(&amp;dochild1_uc, &quot;nddds&quot;, =
1, &amp;uc_file_flag,<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 &amp;uc_file_mode, &amp;parent, tmpname);<br>+<br>+=
=A0=A0=A0=A0=A0=A0 maybe_run_child(&amp;dochild2_uc, &quot;ndddds&quot;, 2,=
 &amp;uc_file_flag,<br>




+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &amp;uc=
_file_mode, &amp;uc_dup_flag, &amp;parent, tmpname);<br>+<br>=A0=A0=A0=A0=
=A0=A0=A0 argv0 =3D av[0];<br>=A0#endif<br><br>--<br><br><br><br>Best regar=
ds,<br>Vivi Li<br>

--0016368e1c0e6ef4f00498894a17--


--===============8018155581182537661==
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
--===============8018155581182537661==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8018155581182537661==--

