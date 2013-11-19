Return-Path: <ltp-list-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Tue, 19 Nov 2013 23:37:12 +0530
Message-ID: <CAO=8iAV97QG4YfcwtGpQopDbszJkt9gDp53vG3F4qnoX6XJkgA@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: [LTP] How to build/install and run with gcov enabled LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2127403740328175990=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>, ltp-coverage@lists.sourceforge.net
Cc: "yaneurabeya ." <yanegomi@gmail.com>, naresh.kamboju@linaro.org

--===============2127403740328175990==
Content-Type: multipart/alternative; boundary=001a1134890aade42a04eb8b88ef

--001a1134890aade42a04eb8b88ef
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I would like to generate gcov/lcov report by using LTP test source.

1. ./configure CFLAGS="-Wall -fprofile-arcs -ftest-coverage -g"
LDFLAGS="-lgcov -fprofile-arcs"
2. make all
3. make install (easy and serve the purpose)
4. ./runltp -f syscalls (obvious nothing happens, because i am running it
from ltp dir)

gcov need source and binary should be present in the same location to
generate final  gcov output file sourcefile.c.gcov

I am looking for (three years) old style of running tests in ltp ( like as
runltp do not look for /ltp/bin or testcase/bin or /opt/bin for test
binaries, just go to each testcase/kernel/syscall/each-dir-and-run). Not
ready to go back and use old ltp version, instead i am looking a way to run
test from its source directory which will benefits gcov/lcov to generate
coverage report.

Manual execution of gcov:
--------------------------------------
naresh@linaro:/mnt/home/naresh/ltp-git/ltp/testcases/kernel/syscalls/accept$
ls
accept01  accept01.c  accept01.gcno  Makefile
naresh@linaro:/mnt/home/naresh/ltp-git/ltp/testcases/kernel/syscalls/accept$
./accept01
accept01    1  TPASS  :  bad file descriptor successful
accept01    2  TPASS  :  bad file descriptor successful
accept01    3  TPASS  :  invalid socket buffer successful
accept01    4  TPASS  :  invalid salen successful
accept01    5  TPASS  :  invalid salen successful
accept01    6  TPASS  :  no queued connections successful
accept01    7  TPASS  :  UDP accept successful
naresh@linaro:/mnt/home/naresh/ltp-git/ltp/testcases/kernel/syscalls/accept$
ls
accept01  accept01.c  accept01.gcda  accept01.gcno  Makefile
naresh@linaro:/mnt/home/naresh/ltp-git/ltp/testcases/kernel/syscalls/accept$
gcov accept01.c
File 'accept01.c'
Lines executed:83.87% of 62
accept01.c:creating 'accept01.c.gcov'

File '/usr/include/x86_64-linux-gnu/bits/fcntl2.h'
Lines executed:100.00% of 1
/usr/include/x86_64-linux-gnu/bits/fcntl2.h:creating 'fcntl2.h.gcov'

naresh@linaro:/mnt/home/naresh/ltp-git/ltp/testcases/kernel/syscalls/accept$
ls
accept01  accept01.c  accept01.c.gcov  accept01.gcda  accept01.gcno
fcntl2.h.gcov  Makefile

Best regards
Naresh Kamboju

--001a1134890aade42a04eb8b88ef
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>I would like to generate gcov/l=
cov report by using LTP test source.<br><br></div><div>1. ./configure CFLAG=
S=3D&quot;-Wall -fprofile-arcs -ftest-coverage -g&quot; LDFLAGS=3D&quot;-lg=
cov -fprofile-arcs&quot;<br>
</div><div>2. make all<br></div><div>3. make install (easy and serve the pu=
rpose)<br></div><div>4. ./runltp -f syscalls (obvious nothing happens, beca=
use i am running it from ltp dir)<br><br></div><div>gcov need source and bi=
nary should be present in the same location to generate final=A0 gcov outpu=
t file sourcefile.c.gcov<br>
<br>I am looking for (three years) old style of running tests in ltp ( like=
 as runltp do not look for /ltp/bin or testcase/bin or /opt/bin for test bi=
naries, just go to each testcase/kernel/syscall/each-dir-and-run). Not read=
y to go back and use old ltp version, instead i am looking a way to run tes=
t from its source directory which will benefits gcov/lcov to generate cover=
age report.<br>
</div><div><br></div><div>Manual execution of gcov:<br></div><div>---------=
-----------------------------<br>naresh@linaro:/mnt/home/naresh/ltp-git/ltp=
/testcases/kernel/syscalls/accept$ ls<br>accept01=A0 accept01.c=A0 accept01=
.gcno=A0 Makefile<br>
naresh@linaro:/mnt/home/naresh/ltp-git/ltp/testcases/kernel/syscalls/accept=
$ ./accept01 <br>accept01=A0=A0=A0 1=A0 TPASS=A0 :=A0 bad file descriptor s=
uccessful<br>accept01=A0=A0=A0 2=A0 TPASS=A0 :=A0 bad file descriptor succe=
ssful<br>accept01=A0=A0=A0 3=A0 TPASS=A0 :=A0 invalid socket buffer success=
ful<br>
accept01=A0=A0=A0 4=A0 TPASS=A0 :=A0 invalid salen successful<br>accept01=
=A0=A0=A0 5=A0 TPASS=A0 :=A0 invalid salen successful<br>accept01=A0=A0=A0 =
6=A0 TPASS=A0 :=A0 no queued connections successful<br>accept01=A0=A0=A0 7=
=A0 TPASS=A0 :=A0 UDP accept successful<br>naresh@linaro:/mnt/home/naresh/l=
tp-git/ltp/testcases/kernel/syscalls/accept$ ls<br>
accept01=A0 accept01.c=A0 accept01.gcda=A0 accept01.gcno=A0 Makefile<br>nar=
esh@linaro:/mnt/home/naresh/ltp-git/ltp/testcases/kernel/syscalls/accept$ g=
cov accept01.c <br>File &#39;accept01.c&#39;<br>Lines executed:83.87% of 62=
<br>
accept01.c:creating &#39;accept01.c.gcov&#39;<br><br>File &#39;/usr/include=
/x86_64-linux-gnu/bits/fcntl2.h&#39;<br>Lines executed:100.00% of 1<br>/usr=
/include/x86_64-linux-gnu/bits/fcntl2.h:creating &#39;fcntl2.h.gcov&#39;<br=
>
<br>naresh@linaro:/mnt/home/naresh/ltp-git/ltp/testcases/kernel/syscalls/ac=
cept$ ls<br>accept01=A0 accept01.c=A0 accept01.c.gcov=A0 accept01.gcda=A0 a=
ccept01.gcno=A0 fcntl2.h.gcov=A0 Makefile<br><br></div><div>Best regards<br=
>Naresh Kamboju<br>
</div><div><br></div></div>

--001a1134890aade42a04eb8b88ef--


--===============2127403740328175990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
--===============2127403740328175990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2127403740328175990==--

