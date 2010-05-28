Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ahmad92hassan@gmail.com>) id 1OHwGS-0002J7-BZ
	for ltp-list@lists.sourceforge.net; Fri, 28 May 2010 09:54:04 +0000
Received: from mail-px0-f175.google.com ([209.85.212.175])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OHwGR-0003nH-Hv
	for ltp-list@lists.sourceforge.net; Fri, 28 May 2010 09:54:04 +0000
Received: by pxi14 with SMTP id 14so435092pxi.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 28 May 2010 02:53:57 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 28 May 2010 15:23:57 +0530
Message-ID: <AANLkTikP6C5la4P4S6TZe0HZvjLzGZJdEA0Iys4Z5rDH@mail.gmail.com>
From: ahmad hassan <ahmad92hassan@gmail.com>
Subject: [LTP] Help me out (LTP)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4665517938376368954=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4665517938376368954==
Content-Type: multipart/alternative; boundary=000e0cd13b7a534f5f0487a47cbd

--000e0cd13b7a534f5f0487a47cbd
Content-Type: text/plain; charset=ISO-8859-1

 Hi Sir

 i have one question regarding utimensat.
 debian amd64 lenny running on my macine.i used LTP(Linux Test Project)
 to test the performance of the system.
 every thing is fine except some test Fail.

 These out are from log file.

 lchown02                       FAIL       2
 lchown02_16                    FAIL       2
 proc01                         FAIL       1
 mtest06_2                      FAIL       255
 hackbench01                    FAIL       1
 ++++++++++++++++++++++++++++++++++++++++++++++++++++===
 Total Tests: 1227
 Total Failures: 6
 Kernel Version: 2.6.26-2-amd64
 Machine Architecture: x86_64
 Hostname: debian


 and these out put are from .failed file
 ++++++++++++++++++++++++++++++++++++++


 lchown02 prep_create_link; lchown02
 lchown02_16 prep_create_link; lchown02_16
 utimensat01 utimensat_tests.sh
 proc01 proc01
 lchown02 prep_create_link; lchown02
 lchown02_16 prep_create_link; lchown02_16
 utimensat01 utimensat_tests.sh
 proc01 proc01
 lchown02 prep_create_link; lchown02
 lchown02_16 prep_create_link; lchown02_16
 utimensat01 utimensat_tests.sh
 proc01 proc01
 mtest06_2 mmap2 -x 0.002 -a -p
 hackbench01 hackbench 50 process 1000
 ++++++++++++++++++++++++++++++++++++




 Please help me out whats problem.


 Thanks a lot
 Ahmad

--000e0cd13b7a534f5f0487a47cbd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

=A0Hi Sir<br><br>=A0i have one question regarding utimensat.<br>=A0debian a=
md64 lenny running on my macine.i used LTP(Linux Test Project)<br>=A0to tes=
t the performance of the system.<br>=A0every thing is fine except some test=
 Fail.<br>
<br>=A0These out are from log file.<br><br>=A0lchown02=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FAIL=A0=A0=A0=A0=A0=A0 2<br>=
=A0lchown02_16=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FAI=
L=A0=A0=A0=A0=A0=A0 2<br>=A0proc01=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FAIL=A0=A0=A0=A0=A0=A0 1<br>=A0mtest06_2=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FAIL=A0=A0=
=A0=A0=A0=A0 255<br>
=A0hackbench01=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 FAI=
L=A0=A0=A0=A0=A0=A0 1<br>=A0+++++++++++++++++++++++++++++++++++++++++++++++=
+++++=3D=3D=3D<br>=A0Total Tests: 1227<br>=A0Total Failures: 6<br>=A0Kernel=
 Version: 2.6.26-2-amd64<br>=A0Machine Architecture: x86_64<br>=A0Hostname:=
 debian<br>
<br><br>=A0and these out put are from .failed file<br>=A0++++++++++++++++++=
++++++++++++++++++++<br><br><br>=A0lchown02 prep_create_link; lchown02<br>=
=A0lchown02_16 prep_create_link; lchown02_16<br>=A0utimensat01 utimensat_te=
sts.sh<br>
=A0proc01 proc01<br>=A0lchown02 prep_create_link; lchown02<br>=A0lchown02_1=
6 prep_create_link; lchown02_16<br>=A0utimensat01 utimensat_tests.sh<br>=A0=
proc01 proc01<br>=A0lchown02 prep_create_link; lchown02<br>=A0lchown02_16 p=
rep_create_link; lchown02_16<br>
=A0utimensat01 utimensat_tests.sh<br>=A0proc01 proc01<br>=A0mtest06_2 mmap2=
 -x 0.002 -a -p<br>=A0hackbench01 hackbench 50 process 1000<br>=A0+++++++++=
+++++++++++++++++++++++++++<br><br><br><br><br>=A0Please help me out whats =
problem.<br>
<br><br>=A0Thanks a lot<br>=A0Ahmad<br><br><br><br>

--000e0cd13b7a534f5f0487a47cbd--


--===============4665517938376368954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
--===============4665517938376368954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4665517938376368954==--

