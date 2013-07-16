Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shashank192@gmail.com>) id 1Uz2xJ-0004QG-DF
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 10:58:05 +0000
Received: from mail-ea0-f181.google.com ([209.85.215.181])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Uz2xH-0003y7-DY
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 10:58:05 +0000
Received: by mail-ea0-f181.google.com with SMTP id a15so289475eae.40
	for <ltp-list@lists.sourceforge.net>;
	Tue, 16 Jul 2013 03:57:57 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 16 Jul 2013 16:27:57 +0530
Message-ID: <CADyrn+t16kR9FAfQSYUB2aYJej1BEFFZcLwUzDi0nKAjHyZ6Rw@mail.gmail.com>
From: SHASHANK BILGI <shashank192@gmail.com>
Subject: [LTP] [mtest01w] mtest01w test hangs
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7087388786882280082=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7087388786882280082==
Content-Type: multipart/alternative; boundary=089e0160d0e282553f04e19ed962

--089e0160d0e282553f04e19ed962
Content-Type: text/plain; charset=ISO-8859-1

Dear all,

           I was running mtest01w test on a target board which has 80 MB or
RAM and 2GB of swap space. And this test keeps waiting forever, please find
the console logs below,

-8<---------------------------------------------------------
<<<test_start>>>
tag=mtest01w stime=2336
cmdline="mtest01 -p80 -w"
contacts=""
analysis=exit
<<<test_output>>>
[ 2351.111281] rmon:L
mtest01     0  TINFO  :  Total memory already used on system = 22796 kbytes
mtest01     0  TINFO  :  Total memory used needed to reach maximum =
1750246 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 1727450 kbytes
mtest01     1  TBROK  :  stopped at 716177408 bytes: errno=ENOMEM(12):
Cannot allocate memory


* When the malloc fails the child process seems to be calling tst_exit().
mtest01.c
.....
.....
        if (pid == 0) {
                bytecount = chunksize;
                while (1) {
                        if ((mem = malloc(chunksize)) == NULL) {
                                tst_resm(TBROK | TERRNO,
                                         "stopped at %lu bytes", bytecount);
                                free(pid_list);
                                tst_exit();
                        }

.....
.....

* but in this case i can see the child process in the process list(ps -ax)
in sleep state.

 333 ttyAM0   S      0:00 mtest01 -p80 -w
 334 ttyAM0   Z      0:14 [mtest01] <defunct>
 335 ttyAM0   S      0:13 mtest01 -p80 -w

Here is my query , why tst_exit() isn't ending the child process?
Somebody pls help!!

Regards ,
Shashank JB

--089e0160d0e282553f04e19ed962
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Dear all,<br><br></div>=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 I was running mtest01w test on a target board which has 80 MB =
or RAM and 2GB of swap space. And this test keeps waiting forever, please f=
ind the console logs below, <br>
<br><pre id=3D"ext-gen36" class=3D"">-8&lt;--------------------------------=
-------------------------
&lt;&lt;&lt;test_start&gt;&gt;&gt;
tag=3Dmtest01w stime=3D2336
cmdline=3D&quot;mtest01 -p80 -w&quot;
contacts=3D&quot;&quot;
analysis=3Dexit
&lt;&lt;&lt;test_output&gt;&gt;&gt;
[ 2351.111281] rmon:L
mtest01     0  TINFO  :  Total memory already used on system =3D 22796 kbyt=
es
mtest01     0  TINFO  :  Total memory used needed to reach maximum =3D 1750=
246 kbytes
mtest01     0  TINFO  :  Filling up 80% of ram which is 1727450 kbytes
mtest01     1  TBROK  :  stopped at 716177408 bytes: errno=3DENOMEM(12): Ca=
nnot allocate memory</pre><br></div></div><div>* When the malloc fails the =
child process seems to be calling tst_exit().<br>mtest01.c<br>.....<br>....=
.<br>
=A0=A0=A0=A0=A0=A0=A0 if (pid =3D=3D 0) {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 bytecount =3D chunksize;<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 while (1) {<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 if ((mem =3D malloc(chunksize)) =3D=3D NULL) {<=
br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 tst_resm(TBROK | TERRNO,<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;stopped at %lu bytes&qu=
ot;, bytecount);<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 free(pid_list);<br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 tst_exit();<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 }<br><br>
.....<br>.....<br><br></div><div>* but in this case i can see the child pro=
cess in the process list(ps -ax) in sleep state.<br><br>=A0333 ttyAM0=A0=A0=
 S=A0=A0=A0=A0=A0 0:00 mtest01 -p80 -w<br>=A0334 ttyAM0=A0=A0 Z=A0=A0=A0=A0=
=A0 0:14 [mtest01] &lt;defunct&gt;<br>
=A0335 ttyAM0=A0=A0 S=A0=A0=A0=A0=A0 0:13 mtest01 -p80 -w<br><br></div><div=
>Here is my query , why tst_exit() isn&#39;t ending the child process?<br><=
/div><div>Somebody pls help!!<br></div><div><br></div><div>Regards ,<br>Sha=
shank JB <br>
</div></div>

--089e0160d0e282553f04e19ed962--


--===============7087388786882280082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
--===============7087388786882280082==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7087388786882280082==--

