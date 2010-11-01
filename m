Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PCoVS-0003Pq-Gx
	for ltp-list@lists.sourceforge.net; Mon, 01 Nov 2010 07:08:38 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PCoVR-0006dB-63
	for ltp-list@lists.sourceforge.net; Mon, 01 Nov 2010 07:08:38 +0000
Received: by wwb31 with SMTP id 31so5134326wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Nov 2010 00:08:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001cb798d$1aaa0210$4ffe0630$@co.jp>
References: <000001cb798d$1aaa0210$4ffe0630$@co.jp>
Date: Mon, 1 Nov 2010 00:08:30 -0700
Message-ID: <AANLkTiktyyfpSX+ZkOucGCNg2vSajcVPQ8Q60z4Uj8kh@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "sigaction" tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net, =?Big5?B?t+2ueSCwt6Wr?= <toza@ryobi.co.jp>

2010/10/31 Mitani <mitani@ryobi.co.jp>:
> Hi,
>
>
> POSIX "conformance/interfaces/sigaction/16-1" and other 25 tests failed
> with following message:
> ------------
> conformance/interfaces/sigaction/16-1: execution: FAILED: Output:
> Caught signal 6
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-1.c FAILED: T=
he
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-10: execution: FAILED: Output:
> Caught signal 13
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-10.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-11: execution: FAILED: Output:
> Caught signal 3
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-11.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-12: execution: FAILED: Output:
> Caught signal 11
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-12.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-13: execution: FAILED: Output:
> Caught signal 15
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-13.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-14: execution: FAILED: Output:
> Caught signal 20
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-14.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-15: execution: FAILED: Output:
> Caught signal 21
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-15.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-16: execution: FAILED: Output:
> Caught signal 22
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-16.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-17: execution: FAILED: Output:
> Caught signal 10
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-17.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-18: execution: FAILED: Output:
> Caught signal 12
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-18.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-19: execution: FAILED: Output:
> Caught signal 29
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-19.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-2: execution: FAILED: Output:
> Caught signal 14
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-2.c FAILED: T=
he
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-20: execution: FAILED: Output:
> Caught signal 27
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-20.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-21: execution: FAILED: Output:
> Caught signal 31
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-21.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-22: execution: FAILED: Output:
> Caught signal 5
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-22.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-23: execution: FAILED: Output:
> Caught signal 23
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-23.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-24: execution: FAILED: Output:
> Caught signal 26
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-24.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-25: execution: FAILED: Output:
> Caught signal 24
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-25.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-26: execution: FAILED: Output:
> Caught signal 25
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-26.c FAILED: =
The
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-3: execution: FAILED: Output:
> Caught signal 7
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-3.c FAILED: T=
he
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-4: execution: FAILED: Output:
> Caught signal 17
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-4.c FAILED: T=
he
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-5: execution: FAILED: Output:
> Caught signal 18
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-5.c FAILED: T=
he
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-6: execution: FAILED: Output:
> Caught signal 8
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-6.c FAILED: T=
he
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-7: execution: FAILED: Output:
> Caught signal 1
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-7.c FAILED: T=
he
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-8: execution: FAILED: Output:
> Caught signal 4
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-8.c FAILED: T=
he
> function returned EINTR while SA_RESTART is set
> conformance/interfaces/sigaction/16-9: execution: FAILED: Output:
> Caught signal 2
> [16:42:34]Test ../../../conformance/interfaces/sigaction/16-9.c FAILED: T=
he
> function returned EINTR while SA_RESTART is set
> ------------
>
> Environment is as follows:
> =A0- RHEL4.8 (kernel version 2.6.9-89) =A0 --- (x86, x86_64, ia64)
> =A0- RHEL5.5 (kernel version 2.6.18-194) --- (x86, x86_64, ia64)
>
>
> The cause of above error is that sem_wait() of the testing kernel version
> always returns with EINTR.
>
> "man sem_wait" says:
> ------------
> [...]
>
> =A0 =A0 =A0 EINTR =A0The call was interrupted by a signal handler.
>
> [...]
>
> NOTES
> =A0 =A0 =A0 A =A0signal handler always interrupts a blocked call to one o=
f these
> functions, regardless
> =A0 =A0 =A0 of the use of the sigaction(2) SA_RESTART flag.
>
> POSIX.1-2001.
> ------------
>
>
> And "man 7 signal" of "RHEL6.0 Beta"(*) says:
> ------------
> =A0 =A0 =A0 If a blocked call to one of the following interfaces is inter=
rupted
> by
> =A0 =A0 =A0 a =A0signal handler, then the call will be automatically rest=
arted
> after
> =A0 =A0 =A0 the signal handler returns if the SA_RESTART flag was used;
> otherwise
> =A0 =A0 =A0 the call will fail with the error EINTR:
>
> [...]
>
> =A0 =A0 =A0 =A0 =A0 * POSIX =A0semaphore =A0interfaces: =A0sem_wait(3) =
=A0and
> sem_timedwait(3)
> =A0 =A0 =A0 =A0 =A0 =A0 (since Linux 2.6.22; beforehand, always failed wi=
th EINTR).
>
> [...]
>
> =A0 Interruption of System Calls and Library Functions by Stop Signals
> =A0 =A0 =A0 On Linux, even in the absence of =A0signal =A0handlers, =A0ce=
rtain
> blocking
> =A0 =A0 =A0 interfaces =A0can fail with the error EINTR after the process=
 is
> stopped
> =A0 =A0 =A0 by one of the =A0stop =A0signals =A0and =A0then =A0resumed =
=A0via =A0SIGCONT.
> This
> =A0 =A0 =A0 behavior is not sanctioned by POSIX.1, and doesn=92t occur on=
 other
> sys-
> =A0 =A0 =A0 tems.
>
> [...]
>
> =A0 =A0 =A0 =A0 =A0 * Linux 2.6.21 and earlier: futex(2) FUTEX_WAIT,
> sem_timedwait(3),
> =A0 =A0 =A0 =A0 =A0 =A0 sem_wait(3).
>
> ------------
> (*) -- Above description didn't exist in "man" of RHEL4.8/5.5.
> =A0 =A0 =A0 But "man" of RHEL6.0 Beta says that "sem_wait()" failed in the
> =A0 =A0 =A0 version earlier than Linux 2.6.22.
>
>
> Therefore, These 26 tests are useful after 2.6.22 version, I think.
>
> I tried to revised "testcases/open_posix_testsuite/conformance/interfaces/
> sigaction/templates/template_16-1.in"
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ---
> a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/templat=
es/
> template_16-1.in =A0 =A0 =A0 =A02010-10-14 03:58:31.000000000 +0900
> +++
> b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/templat=
es/
> template_16-1.new =A0 =A0 =A0 2010-10-18 17:47:40.000000000 +0900
> @@ -55,6 +55,8 @@
> =A0#include <signal.h>
> =A0#include <errno.h>
>
> +#include <sys/utsname.h>
> +
>
> /************************************************************************=
***
> ***/
> =A0/*************************** =A0 Test framework
> *******************************/
>
> /************************************************************************=
***
> ***/
> @@ -124,6 +126,23 @@
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +/* Checking for Kernel Version function */
> +int kernel_ver_cmp(int k1, int k2, int k3)
> +{
> + =A0 =A0 =A0 struct utsname buf;
> + =A0 =A0 =A0 int r1, r2, r3;
> +
> + =A0 =A0 =A0 uname(&buf);
> + =A0 =A0 =A0 sscanf(buf.release, "%d.%d.%d", &r1, &r2, &r3);
> + =A0 =A0 =A0 if (r1 > k1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (r2 > k2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 if (r3 > k3)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 return 1;
> +}
> +
> =A0/* main function */
> =A0int main()
> =A0{
> @@ -133,6 +152,12 @@
>
> =A0 =A0 =A0 =A0struct sigaction sa;
>
> + =A0 =A0 =A0 /* Checking for Kernel Version */
> + =A0 =A0 =A0 if ( kernel_ver_cmp(2, 6, 21) !=3D 0 )
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 UNTESTED( "sem_wait() returned EINTR on ker=
nel versions
> lower than 2.6.22" );
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* Initialize output */
> =A0 =A0 =A0 =A0output_init();
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Above patch is revision only for templates.
> The following procedure is necessary after applying patch:
> ------------
> #cd testcases/open_posix_testsuite/conformance/interfaces/sigaction/
> #./gentests.pl
> ------------
>
> Similar revisions are necessary for other 25 "sigaction" tests.

    Sorry, but Linux-isms can't leak into the open_posix_testsuite.
Same with BSDisms (at least they shouldn't... if they do, then slap me
or whoever did the commit).
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
