Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <a22017@motorola.com>) id 1WIqaw-0006bG-LJ
	for ltp-list@lists.sourceforge.net; Thu, 27 Feb 2014 02:21:06 +0000
Received: from exprod5og104.obsmtp.com ([64.18.0.178])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WIqav-0003P8-DK
	for ltp-list@lists.sourceforge.net; Thu, 27 Feb 2014 02:21:06 +0000
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id
	s1R1mvcc020297 for <ltp-list@lists.sourceforge.net>;
	Wed, 26 Feb 2014 20:48:57 -0500 (EST)
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
	[209.85.192.45])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id
	s1R1mk7g020244
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 26 Feb 2014 20:48:57 -0500 (EST)
Received: by mail-qg0-f45.google.com with SMTP id j5so3780730qga.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 26 Feb 2014 17:48:56 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 26 Feb 2014 17:48:56 -0800
Message-ID: <CACwVHNonCpBcvNSwVCt=2Sdm_nOROszqpOF-h+L_9z29EQTsnw@mail.gmail.com>
From: Sandy Sun <a22017@motorola.com>
Subject: [LTP] About msgsnd05 Test Case Return Value Check
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8294750927090705433=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8294750927090705433==
Content-Type: multipart/alternative; boundary=001a11c239943b526f04f3598662

--001a11c239943b526f04f3598662
Content-Type: text/plain; charset=UTF-8

Hi All,

We found msgsnd05 doesn't check the test result from child thread in parent
thread, otherwise parent thread will always return 0 even when the result
of the child thread is failed.


Here is a patch to fix this problem, is it better to check child
thread result in parent thread? Thank you!


diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
index 523b13e..2df1c2d 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
@@ -94,6 +94,7 @@ int main(int ac, char **av)
        int lc;                 /* loop counter */
        char *msg;              /* message returned from parse_opts */
        pid_t c_pid;
+       int status;

        /* parse standard options */
        if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
@@ -166,7 +167,12 @@ int main(int ac, char **av)
                                tst_brkm(TBROK, cleanup, "kill failed");
                        }

-                       waitpid(c_pid, NULL, 0);
+                       /* wait for the child to finish */
+                       wait(&status);
+                       /* make sure the child returned a good exit status*/
+                       if (WIFEXITED(status) == 0) {
+                               tst_resm(TFAIL, "Failures reported above");
+                       }
                }
        }

@@ -180,6 +186,7 @@ int main(int ac, char **av)
  */
 void do_child()
 {
+       int retval = 0;
        if (sync_pipe_notify(sync_pipes) == -1)
                tst_brkm(TBROK, cleanup, "sync_pipe_notify failed");

@@ -201,13 +208,14 @@ void do_child()
                         TEST_ERRNO, strerror(TEST_ERRNO));
                break;
        default:
+               retval = 1;
                tst_resm(TFAIL,
                         "call failed with an unexpected error - %d : %s",
                         TEST_ERRNO, strerror(TEST_ERRNO));
                break;        }
 -       exit(0);

+       exit(retval);
 }

 void

BRs,
Sandy

--001a11c239943b526f04f3598662
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"courier new, monospace">Hi All,</font><div><=
font face=3D"courier new, monospace"><br></font></div><div><font face=3D"co=
urier new, monospace">We found msgsnd05=C2=A0<span style=3D"color:rgb(53,53=
,53);font-size:9pt">doesn&#39;t check the test result=C2=A0</span></font><s=
pan style=3D"font-family:&#39;courier new&#39;,monospace;color:rgb(53,53,53=
);font-size:9pt">from child thread in parent thread, otherwise parent=C2=A0=
</span><span style=3D"font-family:&#39;courier new&#39;,monospace;color:rgb=
(53,53,53);font-size:9pt">thread will always return 0 even when the result =
of=C2=A0</span><font face=3D"courier new, monospace" style=3D"color:rgb(53,=
53,53);font-size:9pt">the child thread is failed</font><span style=3D"color=
:rgb(53,53,53);font-size:9pt">.</span></div>
<pre class=3D"" style=3D"font-size:9pt;margin-top:0px;margin-bottom:0px;col=
or:rgb(53,53,53)"><br></pre><pre class=3D"" style=3D"font-size:9pt;margin-t=
op:0px;margin-bottom:0px;color:rgb(53,53,53)">Here is a patch to fix this p=
roblem, is it better to check child thread result in parent thread? Thank y=
ou!</pre>
<pre class=3D"" style=3D"font-size:9pt;margin-top:0px;margin-bottom:0px;col=
or:rgb(53,53,53)"><br></pre><pre class=3D"" style=3D"margin-top:0px;margin-=
bottom:0px"><font color=3D"#353535">diff --git a/testcases/kernel/syscalls/=
ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
index 523b13e..2df1c2d 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
@@ -94,6 +94,7 @@ int main(int ac, char **av)
        int lc;                 /* loop counter */
        char *msg;              /* message returned from parse_opts */
        pid_t c_pid;
+       int status;
=20
        /* parse standard options */
        if ((msg =3D parse_opts(ac, av, NULL, NULL)) !=3D NULL) {
@@ -166,7 +167,12 @@ int main(int ac, char **av)
                                tst_brkm(TBROK, cleanup, &quot;kill failed&=
quot;);
                        }
=20
-                       waitpid(c_pid, NULL, 0);
+                       /* wait for the child to finish */
+                       wait(&amp;status);
+                       /* make sure the child returned a good exit status*=
/
+                       if (WIFEXITED(status) =3D=3D 0) {
+                               tst_resm(TFAIL, &quot;Failures reported abo=
ve&quot;);
+                       }
                }
        }
=20
@@ -180,6 +186,7 @@ int main(int ac, char **av)
  */
 void do_child()
 {
+       int retval =3D 0;
        if (sync_pipe_notify(sync_pipes) =3D=3D -1)
                tst_brkm(TBROK, cleanup, &quot;sync_pipe_notify failed&quot=
;);
=20
@@ -201,13 +208,14 @@ void do_child()
                         TEST_ERRNO, strerror(TEST_ERRNO));
                break;
        default:
+               retval =3D 1;
                tst_resm(TFAIL,
                         &quot;call failed with an unexpected error - %d : =
%s&quot;,
                         TEST_ERRNO, strerror(TEST_ERRNO));
                break;
<font face=3D"times new roman, serif">        }
=20
</font><font face=3D"courier new, monospace">-       exit(0);</font></font>=
<span style=3D"color:rgb(53,53,53);font-size:9pt"><font face=3D"courier new=
, monospace">
</font></span></pre><div><div><font face=3D"courier new, monospace">+ =C2=
=A0 =C2=A0 =C2=A0 exit(retval);</font></div><div><font face=3D"courier new,=
 monospace">=C2=A0}</font></div><div><font face=3D"times new roman, serif">=
=C2=A0</font></div><div><font face=3D"courier new, monospace">=C2=A0void</f=
ont></div>
</div><div><font face=3D"courier new, monospace"><br></font></div><div><spa=
n style=3D"font-family:&#39;courier new&#39;,monospace">BRs,</span><br></di=
v><div><font face=3D"courier new, monospace">Sandy</font></div></div>

--001a11c239943b526f04f3598662--


--===============8294750927090705433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
--===============8294750927090705433==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8294750927090705433==--

