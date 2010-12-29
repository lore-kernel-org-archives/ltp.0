Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <violetleigh@gmail.com>) id 1PXsRf-0003vE-DE
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:47 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PXsRe-0003mK-Gc
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:47 +0000
Received: by ywi6 with SMTP id 6so4270910ywi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 01:35:41 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 29 Dec 2010 17:35:41 +0800
Message-ID: <AANLkTimUOfMRp5eTABnr5i04FssPQoFHY7MheNe_SBLm@mail.gmail.com>
From: Vivi <violetleigh@gmail.com>
Subject: [LTP] [Bug Fix] LTP test cases kill05 is broken on uclinux platform
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7077634257888318422=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP mailing list <ltp-list@lists.sourceforge.net>

--===============7077634257888318422==
Content-Type: multipart/alternative; boundary=0016e645b89ee2c47b0498894ae6

--0016e645b89ee2c47b0498894ae6
Content-Type: text/plain; charset=ISO-8859-1

LTP test cases kill05 is broken on uclinux platform.

--
root:/bin> kill05
kill05      1  BROK  :  self_exec of child failed
kill05      0  INFO  :  WARNING: shared memory deletion failed.
kill05      0  INFO  :  This could lead to IPC resource problems.
kill05      0  INFO  :  id = 0
kill05      2  PASS  :  errno set to 1 : Operation not permitted, as
expected
kill05      0  WARN  :  tst_rmdir(): rmobj(/tmp/kilhsxPSp) failed:
lstat(/tmp/kilhsxPSp) failed; errno=2: No such file or directory
root:/bin>
--

Bellow is the fix for uclinux platform. And the permission of kill05 should
be set to be executable by every user.
--
Index: testcases/kernel/syscalls/kill/kill05.c
===================================================================
--- testcases/kernel/syscalls/kill/kill05.c
+++ testcases/kernel/syscalls/kill/kill05.c
@@ -84,12 +84,19 @@
 void cleanup(void);
 void setup(void);
 void do_child(void);
+#ifdef UCLINUX
+void uclinux_child(void);
+#endif
 void do_master_child(char **av);

 char *TCID = "kill05";
 int TST_TOTAL = 1;
 int shmid1 = -1;
+#ifdef UCLINUX
+static key_t semkey = 1234;
+#else
 extern key_t semkey;
+#endif
 int *flag;

 int exp_enos[] = { EPERM, 0 };
@@ -110,7 +117,7 @@
                tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
        }
 #ifdef UCLINUX
-       maybe_run_child(&do_child, "");
+       maybe_run_child(&uclinux_child, "");
 #endif

        setup();                /* global setup */
@@ -239,6 +246,29 @@
        }
 }

+#ifdef UCLINUX
+void
+uclinux_child()
+{
+       if ((shmid1 = shmget(semkey, (int)getpagesize(),
+             0666|IPC_CREAT)) == -1) {
+               tst_brkm(TBROK, cleanup, "uclinux_child: Failed to setup
shared memory");
+       }
+
+       if ((flag = (int *)shmat(shmid1, 0, 0)) == (int *)-1) {
+               tst_brkm(TBROK, cleanup,
+                       "uclinux_child: Failed to attatch shared memory:%d",
flag);
+       }
+       while(1) {
+               if (*flag == 1) {
+                       shmdt(flag);
+                       exit(0);
+               } else
+                       sleep (1);
+       }
+}
+#endif
+
 /*
  * setup() - performs all ONE TIME setup for this test
  */
@@ -257,8 +287,10 @@
         */
        tst_tmpdir();

+#ifndef UCLINUX
        /* get an IPC resource key */
        semkey = getipckey();
+#endif

        if ((shmid1 = shmget(semkey, (int)getpagesize(),
                             0666 | IPC_CREAT)) == -1) {
--



Best regards,
Vivi Li

--0016e645b89ee2c47b0498894ae6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

LTP test cases kill05 is broken on uclinux platform.<br><br>--<br>root:/bin=
&gt; kill05<br>kill05=A0=A0=A0=A0=A0 1=A0 BROK=A0 :=A0 self_exec of child f=
ailed<br>kill05=A0=A0=A0=A0=A0 0=A0 INFO=A0 :=A0 WARNING: shared memory del=
etion failed.<br>kill05=A0=A0=A0=A0=A0 0=A0 INFO=A0 :=A0 This could lead to=
 IPC resource problems.<br>

kill05=A0=A0=A0=A0=A0 0=A0 INFO=A0 :=A0 id =3D 0<br>kill05=A0=A0=A0=A0=A0 2=
=A0 PASS=A0 :=A0 errno set to 1 : Operation not permitted, as expected<br>k=
ill05=A0=A0=A0=A0=A0 0=A0 WARN=A0 :=A0 tst_rmdir(): rmobj(/tmp/kilhsxPSp) f=
ailed: lstat(/tmp/kilhsxPSp) failed; errno=3D2: No such file or directory<b=
r>

root:/bin&gt;<br>--<br><br>Bellow is the fix for uclinux platform. And the =
permission of kill05 should be set to be executable by every user.<br>--<br=
>Index: testcases/kernel/syscalls/kill/kill05.c<br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>

--- testcases/kernel/syscalls/kill/kill05.c<br>+++ testcases/kernel/syscall=
s/kill/kill05.c<br>@@ -84,12 +84,19 @@<br>=A0void cleanup(void);<br>=A0void=
 setup(void);<br>=A0void do_child(void);<br>+#ifdef UCLINUX<br>+void uclinu=
x_child(void);<br>

+#endif<br>=A0void do_master_child(char **av);<br><br>=A0char *TCID =3D &qu=
ot;kill05&quot;;<br>=A0int TST_TOTAL =3D 1;<br>=A0int shmid1 =3D -1;<br>+#i=
fdef UCLINUX<br>+static key_t semkey =3D 1234;<br>+#else<br>=A0extern key_t=
 semkey;<br>+#endif<br>

=A0int *flag;<br><br>=A0int exp_enos[] =3D { EPERM, 0 };<br>@@ -110,7 +117,=
7 @@<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_brkm(TBROK, clean=
up, &quot;OPTION PARSING ERROR - %s&quot;, msg);<br>=A0=A0=A0=A0=A0=A0=A0 }=
<br>=A0#ifdef UCLINUX<br>-=A0=A0=A0=A0=A0=A0 maybe_run_child(&amp;do_child,=
 &quot;&quot;);<br>

+=A0=A0=A0=A0=A0=A0 maybe_run_child(&amp;uclinux_child, &quot;&quot;);<br>=
=A0#endif<br><br>=A0=A0=A0=A0=A0=A0=A0 setup();=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 /* global setup */<br>@@ -239,6 +246,29 @@<br>=A0=A0=A0=
=A0=A0=A0=A0 }<br>=A0}<br><br>+#ifdef UCLINUX<br>+void<br>+uclinux_child()<=
br>

+{<br>+=A0=A0=A0=A0=A0=A0 if ((shmid1 =3D shmget(semkey, (int)getpagesize()=
,<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0666|IPC_CREAT)) =3D=3D -1) {<br=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_brkm(TBROK, cleanup, &quot=
;uclinux_child: Failed to setup shared memory&quot;);<br>+=A0=A0=A0=A0=A0=
=A0 }<br>

+<br>+=A0=A0=A0=A0=A0=A0 if ((flag =3D (int *)shmat(shmid1, 0, 0)) =3D=3D (=
int *)-1) {<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst_brkm(TBROK, =
cleanup,<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 &quot;uclinux_child: Failed to attatch shared memory:%d&quot;, flag)=
;<br>+=A0=A0=A0=A0=A0=A0 }<br>

+=A0=A0=A0=A0=A0=A0 while(1) {<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 if (*flag =3D=3D 1) {<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 shmdt(flag);<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 exit(0);<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 } else<br>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 sleep (1);<br>+=A0=A0=A0=A0=A0=A0 }<br>+}<br>+#endif<br>

+<br>=A0/*<br>=A0 * setup() - performs all ONE TIME setup for this test<br>=
=A0 */<br>@@ -257,8 +287,10 @@<br>=A0=A0=A0=A0=A0=A0=A0=A0 */<br>=A0=A0=A0=
=A0=A0=A0=A0 tst_tmpdir();<br><br>+#ifndef UCLINUX<br>=A0=A0=A0=A0=A0=A0=A0=
 /* get an IPC resource key */<br>=A0=A0=A0=A0=A0=A0=A0 semkey =3D getipcke=
y();<br>

+#endif<br><br>=A0=A0=A0=A0=A0=A0=A0 if ((shmid1 =3D shmget(semkey, (int)ge=
tpagesize(),<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 0666 | IPC_CREAT)) =3D=3D -1) {<br>--<br><br><b=
r><br>Best regards,<br>Vivi Li

--0016e645b89ee2c47b0498894ae6--


--===============7077634257888318422==
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
--===============7077634257888318422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7077634257888318422==--

