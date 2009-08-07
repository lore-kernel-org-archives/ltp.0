Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <skrishnakar@gmail.com>) id 1MZRLZ-0000HY-4k
	for Ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 15:27:09 +0000
Received: from wf-out-1314.google.com ([209.85.200.175])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZRLR-0003bt-QN
	for Ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 15:27:09 +0000
Received: by wf-out-1314.google.com with SMTP id 26so654852wfd.4
	for <Ltp-list@lists.sourceforge.net>;
	Fri, 07 Aug 2009 08:26:55 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 7 Aug 2009 20:56:55 +0530
Message-ID: <6213bc560908070826u6c2b321ay446997891f2cc21f@mail.gmail.com>
From: srikanth krishnakar <skrishnakar@gmail.com>
Subject: [LTP] add_key01 & add_key02 test cases fails and shown as PASS in
	log file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8494325790755215376=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Ltp-list@lists.sourceforge.net

--===============8494325790755215376==
Content-Type: multipart/alternative; boundary=000e0cd242b2ce6bdb04708edd8b

--000e0cd242b2ce6bdb04708edd8b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I see these two test cases are failing on PowerPC target (ppc440) as shown
in output file, but they are listed as PASS in log file of the LTP :

Target : PowerPC (ppc440)
Kernel: Linux-2.6.29
LTP Version : ltp-full-20090731

LTP output file :
#############


1. add_key01
--------------------

<<<test_start>>>
tag=add_key01 stime=1248549741
cmdline="add_key01"
contacts=""
analysis=exit
<<<test_output>>>
add_key01    1  TFAIL  :  add_key01 failed - errno = 38 : Function not
implemented
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>

2. add_key02
----------------------

<<<test_start>>>
tag=add_key02 stime=1248549741
cmdline="add_key02"
contacts=""
analysis=exit
<<<test_output>>>
add_key02    0  TINFO  :  call add_key() with wrong args got UNEXPECTED
errno:38
add_key02    1  TFAIL  :  add_key02 failed - errno = 38 : Function not
implemented
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=1
<<<test_end>>>

--------------------------------------------------------

BUT the Log file shows as PASS to the above test cases :

###########################

add_key01                      PASS       0
add_key02                      PASS       0

###########################


May anyone explain, why it is so ? Is it a known behaviour ?


Regards
Srikanth Krishnakar
**********************

--000e0cd242b2ce6bdb04708edd8b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I see these two test cases are failing on PowerPC target (ppc440) as shown =
in output file, but they are listed as PASS in log file of the LTP :<br><br=
>Target : PowerPC (ppc440)<br>Kernel: Linux-2.6.29<br>LTP Version : ltp-ful=
l-20090731<br>
<br>LTP output file :<br>#############<br><br><br>1. add_key01<br>---------=
-----------<br><br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dadd_key01 st=
ime=3D1248549741<br>cmdline=3D&quot;add_key01&quot;<br>contacts=3D&quot;&qu=
ot;<br>
analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>add_key01=A0=A0=
=A0 1=A0 TFAIL=A0 :=A0 add_key01 failed - errno =3D 38 : Function not imple=
mented<br>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&=
quot;ok&quot;<br>
duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dno<br>=
cutime=3D0 cstime=3D0<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br><br>2. add_key=
02<br>----------------------<br><br>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>t=
ag=3Dadd_key02 stime=3D1248549741<br>
cmdline=3D&quot;add_key02&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dex=
it<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>add_key02=A0=A0=A0 0=A0 TINFO=
=A0 :=A0 call add_key() with wrong args got UNEXPECTED errno:38<br>add_key0=
2=A0=A0=A0 1=A0 TFAIL=A0 :=A0 add_key02 failed - errno =3D 38 : Function no=
t implemented<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=
=3Dno<br>cutime=3D0 cstime=3D1<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br><br>-=
-------------------------------------------------------<br>
<br>BUT the Log file shows as PASS to the above test cases :<br><br>#######=
####################<br><br>add_key01=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 PASS=A0=A0=A0=A0=A0=A0 0<br>add_key02=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PASS=A0=A0=A0=A0=A0=
=A0 0<br><br>###########################<br>
<br><br clear=3D"all">May anyone explain, why it is so ? Is it a known beha=
viour ?<br>=A0<br><br>Regards<br>Srikanth Krishnakar<br>*******************=
***<br>

--000e0cd242b2ce6bdb04708edd8b--


--===============8494325790755215376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============8494325790755215376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8494325790755215376==--

