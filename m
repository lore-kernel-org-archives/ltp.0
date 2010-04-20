Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <raahul4321@gmail.com>) id 1O47Qc-0006xD-Tr
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 06:59:26 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O47QZ-0007Ie-4r
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 06:59:26 +0000
Received: by gwb17 with SMTP id 17so2214018gwb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 19 Apr 2010 23:59:17 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 20 Apr 2010 12:29:11 +0530
Message-ID: <y2j72fb0a5c1004192359ifea04178l1ced518757facae7@mail.gmail.com>
From: rahul agarwal <raahul4321@gmail.com>
Subject: [LTP] testcase mm-shmt09 failing on arm . please help
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6784801757939266839=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6784801757939266839==
Content-Type: multipart/alternative; boundary=001636c5c1866ec2dc0484a59d7e

--001636c5c1866ec2dc0484a59d7e
Content-Type: text/plain; charset=ISO-8859-1

i am getting the following error while executing the mm test :-

<<<test_start>>>
tag=shmt09 stime=1271762065
cmdline="shmt09"
contacts=""
analysis=exit

<<<test_output>>>
shmat1: Invalid argument
shmt09      1  TPASS  :  sbrk, sbrk, shmget, shmat
shmt09      2  TPASS  :  sbrk, shmat
shmt09      3  *TFAIL  :  Error: shmat Failed, shmid = 262144, errno = 22*
**
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=2
<<<test_end>>>


With Regards
Rahul Agarwal

--001636c5c1866ec2dc0484a59d7e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>i am getting the following error while executing the mm test :-</div>
<div>=A0</div>
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dshmt09 stime=3D1271762065<=
br>cmdline=3D&quot;shmt09&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dex=
it</div>
<div><br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>shmat1: Invalid argument<br=
>shmt09=A0=A0=A0=A0=A0 1=A0 TPASS=A0 :=A0 sbrk, sbrk, shmget, shmat<br>shmt=
09=A0=A0=A0=A0=A0 2=A0 TPASS=A0 :=A0 sbrk, shmat<br>shmt09=A0=A0=A0=A0=A0 3=
=A0 <strong>TFAIL=A0 :=A0 Error: shmat Failed, shmid =3D 262144, errno =3D =
22</strong></div>

<div><strong></strong>=A0</div>
<div>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;=
ok&quot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 coref=
ile=3Dno<br>cutime=3D0 cstime=3D2<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;</div>
<div>=A0</div>
<div>=A0</div>
<div>With Regards</div>
<div>Rahul Agarwal</div>
<div>=A0</div>

--001636c5c1866ec2dc0484a59d7e--


--===============6784801757939266839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============6784801757939266839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6784801757939266839==--

