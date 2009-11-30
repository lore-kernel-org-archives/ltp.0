Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NEynQ-0002dp-1s
	for ltp-list@lists.sourceforge.net; Mon, 30 Nov 2009 05:27:36 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-4.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NEynI-0006NE-Jr
	for ltp-list@lists.sourceforge.net; Mon, 30 Nov 2009 05:27:35 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001ca6f43$3ec6ac20$bc540460$@co.jp>
	<364299f40911271455h792a91dudcedb1d29401b209@mail.gmail.com> 
In-Reply-To: 
Date: Mon, 30 Nov 2009 14:27:20 +0900
Message-ID: <000001ca717d$ca151370$5e3f3a50$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] build failure in ia64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Sorry, my recent information mistaked.



Right information as follows:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
When I ran "make" with ltp-2009-11-30.tar.gz in kernel 2.6.18-164.el5
in x86_64, I got same failure as x86.

For reference, I ran "make" with ltp-2009-11-30.tar.gz in kernel
2.6.9-89.ELsmp in x86_64 (and x86), and I got another failure message
unlike kernel 2.6.18-164.el5.
But, in these systems, the compilation of "pidns03.c" succeeded by giving
a warning message.

After that, compilation of "libcpuset.c" failed.
But I decide not to mention this "libcpuset.c" failure in this topic.
This seems to be the problem that should be mentioned in something =

other thread, I think.


<"make" result in kernel version 2.6.9-89 (x86)>
------------
[...]

make[4]: Entering directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns01.c  -lpthread -lrt -lclone -lltp -o pidns01
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns02.c  -lpthread -lrt -lclone -lltp -o pidns02
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns03.c  -lpthread -lrt -lclone -lltp -o pidns03
pidns03.c:65: warning: static declaration of 'cleanup' follows non-static
declaration
/home/LTP/ltp-2009-11-30/testcases/kernel/include/linux_syscall_numbers.h:24
: warning: previous declaration of 'cleanup' was here
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns04.c  -lpthread -lrt -lclone -lltp -o pidns04
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns05.c  -lpthread -lrt -lclone -lltp -o pidns05
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns06.c  -lpthread -lrt -lclone -lltp -o pidns06
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns10.c  -lpthread -lrt -lclone -lltp -o pidns10
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns12.c  -lpthread -lrt -lclone -lltp -o pidns12
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns13.c  -lpthread -lrt -lclone -lltp -o pidns13
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns16.c  -lpthread -lrt -lclone -lltp -o pidns16
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns17.c  -lpthread -lrt -lclone -lltp -o pidns17
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns20.c  -lpthread -lrt -lclone -lltp -o pidns20
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns30.c  -lpthread -lrt -lclone -lltp -o pidns30
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns31.c  -lpthread -lrt -lclone -lltp -o pidns31
make[4]: Leaving directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns'

[...]

make[5]: Entering directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_ba
lance_test'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include -I../../../../../include
-I../../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_b
alance_test/../cpuset_lib -L../../../../../lib  cpuset_cpu_hog.c   -lltp
-lcpu_set -lm -o cpuset_cpu_hog
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_bal
ance_test/../cpuset_lib/libcpu_set.a(libcpuset.o)(.text+0x384a): In function
`sched_setaffinity':
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_lib/libc
puset.c:3088: undefined reference to `tst_brkm'
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_bal
ance_test/../cpuset_lib/libcpu_set.a(libcpuset.o)(.text+0x389e): In function
`set_mempolicy':
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_lib/libc
puset.c:3099: undefined reference to `tst_brkm'
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_bal
ance_test/../cpuset_lib/libcpu_set.a(libcpuset.o)(.text+0x44aa): In function
`cpuset_addr2node':
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_lib/libc
puset.c:3094: undefined reference to `tst_brkm'
collect2: ld returned 1 exit status
make[5]: *** [cpuset_cpu_hog] Error 1
make[5]: Leaving directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_ba
lance_test'
make[4]: *** [all] Error 2
make[4]: Leaving directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset'
make[3]: *** [all] Error 2
make[3]: Leaving directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/controllers'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/LTP/ltp-2009-11-30/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/LTP/ltp-2009-11-30/testcases'
make: *** [testcases-all] Error 2
------------



I put these informations in order.

------------
(1) kernel version 2.6.18-164
  x86, x86_64 and ia64 failed in same message in compilation of
  "${LTPROOT}/testcases/kernel/containers/pidns/pidns03.c"

(2) kernel version 2.6.9-89
  x86 and x86_64 failed in same message in compilation of =

  "${LTPROOT}/testcases/kernel/controllers/cpuset/cpuset_lib/libcpuset.c"
  The compilation of
"${LTPROOT}/testcases/kernel/containers/pidns/pidns03.c"
  succeeded with warning message.
------------



Regars--

-Tomonori Mitani



-----Original Message-----
From: Mitani [mailto:mitani@ryobi.co.jp] =

Sent: Monday, November 30, 2009 1:33 PM
To: 'Garrett Cooper'
Cc: 'ltp-list@lists.sourceforge.net'
Subject: RE: [LTP] build failure in ia64

For reference, I ran "make" with ltp-2009-11-30.tar.gz in x86_64 =

Architecture, too.

Then, I got another failure message unlike x86 and ia64.
But the compilation of "pidns03.c" succeeded by giving a warning message.

After that, compilation of "libcpuset.c" failed.
But I decide not to mention this "libcpuset.c" failure in this topic.
This seems to be the problem that should be mentioned in something =

other thread, I think.


------------
[...]

make[4]: Entering directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns01.c  -lpthread -lrt -lclone -lltp -o pidns01
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns02.c  -lpthread -lrt -lclone -lltp -o pidns02
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns03.c  -lpthread -lrt -lclone -lltp -o pidns03
pidns03.c:65: warning: static declaration of 'cleanup' follows non-static
declaration
/home/LTP/ltp-2009-11-30/testcases/kernel/include/linux_syscall_numbers.h:24
: warning: previous declaration of 'cleanup' was here
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns04.c  -lpthread -lrt -lclone -lltp -o pidns04
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns05.c  -lpthread -lrt -lclone -lltp -o pidns05
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns06.c  -lpthread -lrt -lclone -lltp -o pidns06
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns10.c  -lpthread -lrt -lclone -lltp -o pidns10
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns12.c  -lpthread -lrt -lclone -lltp -o pidns12
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns13.c  -lpthread -lrt -lclone -lltp -o pidns13
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns16.c  -lpthread -lrt -lclone -lltp -o pidns16
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns17.c  -lpthread -lrt -lclone -lltp -o pidns17
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns20.c  -lpthread -lrt -lclone -lltp -o pidns20
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns30.c  -lpthread -lrt -lclone -lltp -o pidns30
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include
-I/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-I../../../../include -I../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns/../libclone
-L../../../../lib  pidns31.c  -lpthread -lrt -lclone -lltp -o pidns31
make[4]: Leaving directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/containers/pidns'

[...]

make[5]: Entering directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_ba
lance_test'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/LTP/ltp-2009-11-30/testcases/kernel/include -I../../../../../include
-I../../../../../include
-L/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_b
alance_test/../cpuset_lib -L../../../../../lib  cpuset_cpu_hog.c   -lltp
-lcpu_set -lm -o cpuset_cpu_hog
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_bal
ance_test/../cpuset_lib/libcpu_set.a(libcpuset.o)(.text+0x384a): In function
`sched_setaffinity':
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_lib/libc
puset.c:3088: undefined reference to `tst_brkm'
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_bal
ance_test/../cpuset_lib/libcpu_set.a(libcpuset.o)(.text+0x389e): In function
`set_mempolicy':
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_lib/libc
puset.c:3099: undefined reference to `tst_brkm'
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_bal
ance_test/../cpuset_lib/libcpu_set.a(libcpuset.o)(.text+0x44aa): In function
`cpuset_addr2node':
/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_lib/libc
puset.c:3094: undefined reference to `tst_brkm'
collect2: ld returned 1 exit status
make[5]: *** [cpuset_cpu_hog] Error 1
make[5]: Leaving directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset/cpuset_load_ba
lance_test'
make[4]: *** [all] Error 2
make[4]: Leaving directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/controllers/cpuset'
make[3]: *** [all] Error 2
make[3]: Leaving directory
`/home/LTP/ltp-2009-11-30/testcases/kernel/controllers'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/LTP/ltp-2009-11-30/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/LTP/ltp-2009-11-30/testcases'
make: *** [testcases-all] Error 2
------------


Thank you--

-Tomonori Mitani

-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com] =

Sent: Saturday, November 28, 2009 7:56 AM
To: Mitani
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] build failure in ia64

On Fri, Nov 27, 2009 at 1:23 AM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I ran "make" with ltp-2009-11-26.tar.gz.
> Kernel release is 2.6.18-164.el5.
> Architecture is ia64.
>
> But it failed with following error message.
> "make autotools" and "./configure" has been done before make.
> I use "make 3.81", "autoconf 2.61", "automake 1.10.2", and "m4 1.4.7".
>
> ------------
> make[4]: Entering directory
> `/home/mitani/LTP/ltp-2009-11-26/testcases/kernel/controllers/
> freezer'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/mitani/LTP/ltp-2009-11-26/test
> cases/kernel/include -I../../../../include -I../../../../include
> -L../../../../lib =A0vfor
> k.c =A0 -lltp -o vfork
> In file included from ../../syscalls/ptrace/ptrace.h:14,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from vfork.c:44:
> /usr/include/sys/ptrace.h:127: error: array type has incomplete element
type
> In file included from ../../syscalls/ptrace/ptrace.h:22,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 from vfork.c:44:
> /usr/include/asm/ptrace.h:208: error: redefinition of 'struct
> FU_pt_all_user_regs'
> make[4]: *** [vfork] Error 1
> make[4]: Leaving directory
> `/home/mitani/LTP/ltp-2009-11-26/testcases/kernel/controllers/f
> reezer'
> ------------
>
> Similar failure continues from ltp-2009-11-17.tar.gz at the latest.
> "ltp-2009-11-27.tar.gz" (today's version) seems to fail by another
> new failure before these problems.
> Perhaps, "ltp-2009-11-27.tar.gz" will fail by similar failure after
> this "another new failure" solved, I think.
>
> So I will report about "ltp-2009-11-26.tar.gz".
>
>
> The problems are following two.
> (1) Line 127 of "/usr/include/sys/ptrace.h" declares "array type has
> =A0 =A0incomplete element type"
>
> (2) Line 208 of "/usr/include/asm/ptrace.h" declares same structure as
> =A0 =A0"/usr/include/sys/ptrace.h".
>
>
> The files related to these problems are as follows:
>
> =A0- ${LTPROOT}/testcases/kernel/controllers/freezer/vfork.c
> =A0- ${LTPROOT}/testcases/kernel/syscalls/ptrace/ptrace.h
> =A0 =A0It's added from ltp-2009-11-17.tar.gz at the latest.
> =A0 =A0I call this file ".../ptrace/ptrace.h" afterward.
> =A0- /usr/include/sys/ptrace.h
> =A0 =A0I call this file ".../sys/ptrace.h" afterward.
> =A0- /usr/include/asm/ptrace.h
> =A0 =A0I call this file ".../asm/ptrace.h" afterward.
>
>
> Follows show ".../ptrace/ptrace.h", ".../sys/ptrace.h" and
> ".../asm/ptrace.h".
>
> ".../ptrace/ptrace.h":
> ------------
> /* Ordering matters. Do not move this code block below the #include's */
> #ifdef __ia64__ /* what a pos */
> # define ia64_fpreg FU_ia64_fpreg
> # define pt_all_user_regs FU_pt_all_user_regs
> #endif
> #ifdef HAVE_SYS_PTRACE_H
> # include <sys/ptrace.h>
> #elif defined(HAVE_LINUX_PTRACE_H)
> # include <linux/ptrace.h>
> #endif
> #ifdef HAVE_SYS_REG_H
> # include <sys/reg.h>
> #endif
> #ifdef HAVE_ASM_PTRACE_H
> # include <asm/ptrace.h>
> #endif
> #undef FU_ia64_fpreg
> #undef FU_pt_all_user_regs
> ------------
>
> ".../sys/ptrace.h":
> ------------
> struct pt_all_user_regs
> =A0{
> =A0 =A0unsigned long nat;
> =A0 =A0unsigned long cr_iip;
> =A0 =A0unsigned long cfm;
> =A0 =A0unsigned long cr_ipsr;
> =A0 =A0unsigned long pr;
>
> =A0 =A0unsigned long gr[32];
> =A0 =A0unsigned long br[8];
> =A0 =A0unsigned long ar[128];
> =A0 =A0struct ia64_fpreg fr[128]; =A0 =A0 =A0 =A0 =A0 =A0 =A0............=
 L.127
> =A0};
> ------------
>
> ".../asm/ptrace.h":
> ------------
> struct pt_all_user_regs { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...........=
. L.208
> =A0 =A0 =A0 =A0unsigned long nat;
> =A0 =A0 =A0 =A0unsigned long cr_iip;
> =A0 =A0 =A0 =A0unsigned long cfm;
> =A0 =A0 =A0 =A0unsigned long cr_ipsr;
> =A0 =A0 =A0 =A0unsigned long pr;
>
> =A0 =A0 =A0 =A0unsigned long gr[32];
> =A0 =A0 =A0 =A0unsigned long br[8];
> =A0 =A0 =A0 =A0unsigned long ar[128];
> =A0 =A0 =A0 =A0struct ia64_fpreg fr[128];
> };
> ------------
>
>
>
> I tried to avoid above "make" failure as follows:
>
> Avoiding of (1) problem:
>
> "# define ia64_fpreg FU_ia64_fpreg" definition of ".../ptrace/ptrace.h"
> influences "struct ia64_fpreg fr[128];" of ".../sys/ptrace.h", I thought.
> I searched "ia64_fpreg" for all LTP sources, but this structure name was
> not found. I have no ideas why "FU_ia64_fpreg" was defined.
>
> So I commented out "# define ia64_fpreg FU_ia64_fpreg". After that,
> this problem did not occur.
>
>
> Avoiding of (2) problem:
>
> If ".../sys/ptrace.h" and ".../asm/ptrace.h" are included at the same
> time in ".../ptrace/ptrace.h", this probrem occures.
> Probably, "HAVE_SYS_PTRACE_H" and "HAVE_ASM_PTRACE_H" become effective
> at the same time.
> I referred to "${LTPROOT}/include/config.h" and "${LTPROOT}/config.log",
> and found both defined "1".
> In "ltp-full-20090930.tgz", "vfork.c" didn't include ".../asm/ptrace.h"
> but ".../sys/ptrace.h".
>
> So I commented out "# include <asm/ptrace.h>" from ".../ptrace/ptrace.h".
> After that, this problem did not occur in "vfork.c".
>
> But after this, "${LTPROOT}/testcases/kernel/syscalls/ptrace/ptrace04.c"
> failed. In "ptrace04.c", struct "pt_regs" is used, and it's declared in
> ".../asm/ptrace.h".
>
> After examination, I understood that "vfork.c" and six source files
> from "${LTPROOT}/testcases/kernel/syscalls/ptrace01.c" to ".../ptrace06.c"
> include "../ptrace/ptrace.h", and they occur "redefinition" compile
> failure without (2) revision of "../ptrace/ptrace.h".
>
>
>
>
> May I have some questions?
>
> (1) Why was "FU_ia64_fpreg" defined?
> =A0 =A0I deleted this definition to let "make" succeed.
> =A0 =A0But I'm worried whether this revision has a problem.
>
>
> (2) I refer "${LTPROOT}/include/config.h" in my system. It was as follows:
>
> ------------
> [...]
> /* Define to 1 if you have the <asm/ptrace.h> header file. */
> #define HAVE_ASM_PTRACE_H 1
> [...]
> /* Define to 1 if you have the <sys/ptrace.h> header file. */
> #define HAVE_SYS_PTRACE_H 1
> [...]
> ------------
>
> =A0 =A0In this state, "redefinition" failure such as this time will
> =A0 =A0happen, I think. But I don't know what kind of revision should I d=
o.

Mitani-san,
    Would you please try downloading the sources from CVS again and
let me know whether or not it functions for you?
Thanks!
-Garrett



---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
