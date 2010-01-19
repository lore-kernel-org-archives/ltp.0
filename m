Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Kiran.Girmaji@emerson.com>) id 1NX6wn-0004Op-LQ
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 05:48:13 +0000
Received: from usstlz-psecap04.emerson.com ([144.191.128.16]
	helo=USSTLZ-PSECAP05.EMERSON.COM)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NX6wm-0001cl-H3
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 05:48:13 +0000
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Date: Tue, 19 Jan 2010 13:46:53 +0800
Message-ID: <89D32649C0790143AB985A5BF77A104F02BFAA2B@etsmsg-hkexm05.etsmsg.org>
From: <Kiran.Girmaji@Emerson.com>
Subject: [LTP] LTP math testsuite - float_power test fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1074223821891890162=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1074223821891890162==
Content-Class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CA98CA.CE9E347A"

------_=_NextPart_001_01CA98CA.CE9E347A
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am running LTP math testsuite and float_power test fails with the
following output.
Could anyone please guide me.
=20
My machine details -
64bit Intel Xeon based with windriver linux.
Linux megatron 2.6.21.7-WR2.0ap_cgl #1 SMP PREEMPT Fri Jan 8 01:49:51
IST 2010 x86_64 x86_64 x86_64 GNU/Linux

=20
 Running tests.......
<<<test_start>>>
tag=3Dfloat_power stime=3D1034389477
cmdline=3D"cd $LTPROOT/testcases/bin; float_power -v"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
incrementing stop
float_power    0  TINFO  :  float_power: will run for 500 loops
float_power    0  TINFO  :  float_power: using . as data directory
float_power    0  TINFO  :  float_power: will run 6 functions, 20
threads per function
float_power    0  TINFO  :  signal handler 1082132800 started
float_power    0  TINFO  :  Signal handler starts waiting...
float_power    0  TINFO  :  Initial thread: Waiting for 120 threads to
finish
float_power    0  TINFO  :  thread 0 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 1 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 2 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 3 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 4 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 5 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 6 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 7 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 8 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 9 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 10 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 11 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 12 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 13 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 14 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 15 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 16 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 17 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 18 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 19 (ceil) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 20 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 21 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 22 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 23 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 24 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 25 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 26 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 27 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 28 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 29 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 30 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 31 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 32 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 33 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 34 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 35 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 36 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 37 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 38 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 39 (fabs) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 40 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 41 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 42 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 43 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 44 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 45 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 46 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 47 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 48 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 49 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 50 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 51 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 52 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 53 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 54 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 55 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 56 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 57 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 58 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 59 (floor) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 60 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 61 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 62 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 63 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 64 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 65 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 66 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 67 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 68 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 69 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 70 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 71 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 72 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 73 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 74 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 75 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 76 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 77 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 78 (fmod) terminated successfully 500
loops.
float_power    0  TINFO  :  thread 79 (fmod) terminated successfully 500
loops.
float_power    1  TFAIL  :  thread 80 (pow) terminated unsuccessfully
439878 errors/501 loops
float_power    2  TFAIL  :  pow failed at index 20: OLD: inf NEW: inf
DIFF: nan
=20
float_power    3  TFAIL  :  thread 81 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power    4  TFAIL  :  pow failed at index 1: OLD: inf NEW: inf
DIFF: nan
=20
float_power    5  TFAIL  :  thread 82 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power    6  TFAIL  :  pow failed at index 2: OLD: inf NEW: inf
DIFF: nan
=20
float_power    7  TFAIL  :  thread 83 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power    8  TFAIL  :  pow failed at index 3: OLD: inf NEW: inf
DIFF: nan
=20
float_power    9  TFAIL  :  thread 84 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   10  TFAIL  :  pow failed at index 4: OLD: inf NEW: inf
DIFF: nan
=20
float_power   11  TFAIL  :  thread 85 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   12  TFAIL  :  pow failed at index 5: OLD: inf NEW: inf
DIFF: nan
=20
float_power   13  TFAIL  :  thread 86 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   14  TFAIL  :  pow failed at index 6: OLD: inf NEW: inf
DIFF: nan
=20
float_power   15  TFAIL  :  thread 87 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   16  TFAIL  :  pow failed at index 7: OLD: inf NEW: inf
DIFF: nan
=20
float_power   17  TFAIL  :  thread 88 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   18  TFAIL  :  pow failed at index 8: OLD: inf NEW: inf
DIFF: nan
=20
float_power   19  TFAIL  :  thread 89 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   20  TFAIL  :  pow failed at index 9: OLD: inf NEW: inf
DIFF: nan
=20
float_power   21  TFAIL  :  thread 90 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   22  TFAIL  :  pow failed at index 10: OLD: inf NEW: inf
DIFF: nan
=20
float_power   23  TFAIL  :  thread 91 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   24  TFAIL  :  pow failed at index 11: OLD: inf NEW: inf
DIFF: nan
=20
float_power   25  TFAIL  :  thread 92 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   26  TFAIL  :  pow failed at index 12: OLD: inf NEW: inf
DIFF: nan
=20
float_power   27  TFAIL  :  thread 93 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   28  TFAIL  :  pow failed at index 13: OLD: inf NEW: inf
DIFF: nan
=20
float_power   29  TFAIL  :  thread 94 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   30  TFAIL  :  pow failed at index 14: OLD: inf NEW: inf
DIFF: nan
=20
float_power   31  TFAIL  :  thread 95 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   32  TFAIL  :  pow failed at index 15: OLD: inf NEW: inf
DIFF: nan
=20
float_power   33  TFAIL  :  thread 96 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   34  TFAIL  :  pow failed at index 16: OLD: inf NEW: inf
DIFF: nan
=20
float_power   35  TFAIL  :  thread 97 (pow) terminated unsuccessfully
440379 errors/501 loops
float_power   36  TFAIL  :  pow failed at index 17: OLD: inf NEW: inf
DIFF: nan
=20
float_power   37  TFAIL  :  thread 98 (pow) terminated unsuccessfully
439878 errors/501 loops
float_power   38  TFAIL  :  pow failed at index 18: OLD: inf NEW: inf
DIFF: nan
=20
float_power   39  TFAIL  :  thread 99 (pow) terminated unsuccessfully
439878 errors/501 loops
float_power   40  TFAIL  :  pow failed at index 19: OLD: inf NEW: inf
DIFF: nan
=20
float_power    0  TINFO  :  thread 100 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 101 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 102 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 103 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 104 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 105 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 106 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 107 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 108 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 109 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 110 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 111 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 112 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 113 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 114 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 115 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 116 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 117 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 118 (sqrt) terminated successfully
500 loops.
float_power    0  TINFO  :  thread 119 (sqrt) terminated successfully
500 loops.
float_power   41  TFAIL  :  Test failed
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D14 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D348 cstime=3D68
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: LTP-20091031
=20
       ###############################################################"
=20
            Done executing testcases."
            LTP Version:  LTP-20091031
       ###############################################################"

=20

------_=_NextPart_001_01CA98CA.CE9E347A
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16939" name=3DGENERATOR></HEAD>
<BODY>
<DIV dir=3Dltr align=3Dleft><FONT face=3DArial size=3D2><SPAN=20
class=3D234213412-18012010>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D234213412-18012010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D234213412-18012010>I am =
running LTP=20
math testsuite and float_power test fails with the following=20
output.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D234213412-18012010>Could =
anyone please=20
guide me.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D234213412-18012010></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D234213412-18012010>My =
machine details=20
-</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D234213412-18012010>64bit =
Intel Xeon=20
based with windriver linux.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D234213412-18012010>Linux&nbsp;megatron=20
2.6.21.7-WR2.0ap_cgl #1 SMP PREEMPT Fri Jan 8 01:49:51 IST 2010 x86_64 =
x86_64=20
x86_64 GNU/Linux<BR></DIV></SPAN></FONT>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN =
class=3D656194605-19012010><FONT=20
color=3D#0000ff>&nbsp;</FONT></SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DArial><FONT size=3D2><SPAN=20
class=3D656194605-19012010>&nbsp;</SPAN>Running=20
tests.......<BR>&lt;&lt;&lt;test_start&gt;&gt;&gt;<BR>tag=3Dfloat_power=20
stime=3D1034389477<BR>cmdline=3D"cd $LTPROOT/testcases/bin; float_power=20
-v"<BR>contacts=3D""<BR>analysis=3Dexit<BR>&lt;&lt;&lt;test_output&gt;&gt=
;&gt;<BR>incrementing=20
stop<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
float_power:=20
will run for 500 loops<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; =
TINFO&nbsp;=20
:&nbsp; float_power: using . as data =
directory<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; float_power: will run 6 functions, 20 =
threads per=20
function<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
signal=20
handler 1082132800 started<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; =
TINFO&nbsp;=20
:&nbsp; Signal handler starts =
waiting...<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; Initial thread: Waiting for 120 threads to=20
finish<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 0=20
(ceil) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 1 (ceil) terminated successfully 500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 2=20
(ceil) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 3 (ceil) terminated successfully 500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 4=20
(ceil) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 5 (ceil) terminated successfully 500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 6=20
(ceil) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 7 (ceil) terminated successfully 500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 8=20
(ceil) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 9 (ceil) terminated successfully 500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 10=20
(ceil) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 11 (ceil) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 12=20
(ceil) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 13 (ceil) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 14=20
(ceil) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 15 (ceil) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 16=20
(ceil) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 17 (ceil) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 18=20
(ceil) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 19 (ceil) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 20=20
(fabs) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 21 (fabs) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 22=20
(fabs) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 23 (fabs) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 24=20
(fabs) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 25 (fabs) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 26=20
(fabs) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 27 (fabs) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 28=20
(fabs) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 29 (fabs) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 30=20
(fabs) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 31 (fabs) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 32=20
(fabs) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 33 (fabs) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 34=20
(fabs) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 35 (fabs) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 36=20
(fabs) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 37 (fabs) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 38=20
(fabs) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 39 (fabs) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 40=20
(floor) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 41 (floor) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 42=20
(floor) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 43 (floor) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 44=20
(floor) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 45 (floor) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 46=20
(floor) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 47 (floor) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 48=20
(floor) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 49 (floor) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 50=20
(floor) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 51 (floor) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 52=20
(floor) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 53 (floor) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 54=20
(floor) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 55 (floor) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 56=20
(floor) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 57 (floor) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 58=20
(floor) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 59 (floor) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 60=20
(fmod) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 61 (fmod) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 62=20
(fmod) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 63 (fmod) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 64=20
(fmod) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 65 (fmod) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 66=20
(fmod) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 67 (fmod) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 68=20
(fmod) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 69 (fmod) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 70=20
(fmod) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 71 (fmod) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 72=20
(fmod) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 73 (fmod) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 74=20
(fmod) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 75 (fmod) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 76=20
(fmod) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 77 (fmod) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 78=20
(fmod) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 79 (fmod) terminated successfully 500 =

loops.<BR>float_power&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp; :&nbsp; =
thread 80=20
(pow) terminated unsuccessfully 439878 errors/501=20
loops<BR>float_power&nbsp;&nbsp;&nbsp; 2&nbsp; TFAIL&nbsp; :&nbsp; pow =
failed at=20
index 20: OLD: inf NEW: inf DIFF: nan</FONT></FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp;&nbsp; 3&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 81 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp;&nbsp; 4&nbsp; TFAIL&nbsp; :&nbsp; pow =
failed at=20
index 1: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp;&nbsp; 5&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 82 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp;&nbsp; 6&nbsp; TFAIL&nbsp; :&nbsp; pow =
failed at=20
index 2: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp;&nbsp; 7&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 83 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp;&nbsp; 8&nbsp; TFAIL&nbsp; :&nbsp; pow =
failed at=20
index 3: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp;&nbsp; 9&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 84 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 10&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 4: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 11&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 85 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 12&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 5: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 13&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 86 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 14&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 6: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 15&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 87 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 16&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 7: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 17&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 88 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 18&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 8: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 19&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 89 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 20&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 9: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 21&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 90 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 22&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 10: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 23&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 91 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 24&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 11: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 25&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 92 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 26&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 12: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 27&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 93 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 28&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 13: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 29&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 94 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 30&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 14: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 31&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 95 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 32&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 15: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 33&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 96 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 34&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 16: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 35&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 97 (pow) terminated unsuccessfully 440379 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 36&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 17: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 37&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 98 (pow) terminated unsuccessfully 439878 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 38&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 18: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp; 39&nbsp; =
TFAIL&nbsp;=20
:&nbsp; thread 99 (pow) terminated unsuccessfully 439878 errors/501=20
loops<BR>float_power&nbsp;&nbsp; 40&nbsp; TFAIL&nbsp; :&nbsp; pow failed =
at=20
index 19: OLD: inf NEW: inf DIFF: nan</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; =
TINFO&nbsp;=20
:&nbsp; thread 100 (sqrt) terminated successfully 500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 101=20
(sqrt) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 102 (sqrt) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 103=20
(sqrt) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 104 (sqrt) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 105=20
(sqrt) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 106 (sqrt) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 107=20
(sqrt) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 108 (sqrt) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 109=20
(sqrt) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 110 (sqrt) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 111=20
(sqrt) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 112 (sqrt) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 113=20
(sqrt) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 114 (sqrt) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 115=20
(sqrt) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 116 (sqrt) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 117=20
(sqrt) terminated successfully 500 =
loops.<BR>float_power&nbsp;&nbsp;&nbsp;=20
0&nbsp; TINFO&nbsp; :&nbsp; thread 118 (sqrt) terminated successfully =
500=20
loops.<BR>float_power&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; =
thread 119=20
(sqrt) terminated successfully 500 loops.<BR>float_power&nbsp;&nbsp; =
41&nbsp;=20
TFAIL&nbsp; :&nbsp; Test=20
failed<BR>&lt;&lt;&lt;execution_status&gt;&gt;&gt;<BR>initiation_status=3D=
"ok"<BR>duration=3D14=20
termination_type=3Dexited termination_id=3D1 =
corefile=3Dno<BR>cutime=3D348=20
cstime=3D68<BR>&lt;&lt;&lt;test_end&gt;&gt;&gt;<BR>INFO: ltp-pan =
reported some=20
tests FAIL<BR>LTP Version: LTP-20091031</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
###############################################################"</FONT></=
DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; Done=20
executing=20
testcases."<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;=20
LTP Version:&nbsp; LTP-20091031<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
###############################################################"</FONT></=
DIV>
<DIV><FONT face=3DArial size=3D2><BR></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01CA98CA.CE9E347A--


--===============1074223821891890162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============1074223821891890162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1074223821891890162==--

