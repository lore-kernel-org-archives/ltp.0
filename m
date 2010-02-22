Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NjT9x-0001f0-OY
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:56:53 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjT9w-0006Ta-NE
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 07:56:53 +0000
Received: by pwi5 with SMTP id 5so2088929pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 21 Feb 2010 23:56:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B82143D.5050006@cn.fujitsu.com>
References: <4B82143D.5050006@cn.fujitsu.com>
Date: Sun, 21 Feb 2010 23:56:46 -0800
Message-ID: <364299f41002212356g2a4ceb09o3d271e31b388fe51@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] syscalls: fix some failure on arch X86_64
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

By and large this diff looks really good. My comments...

On Sun, Feb 21, 2010 at 9:21 PM, liubo <liubo2009@cn.fujitsu.com> wrote:
> - rt_sigaction01
> On arch x86_64, if we directly get to call syscall
> rt_sigaction, there will be "segment fault".
> 1) One reason is that we must supply the flag of
> "SA_RESTORER" and the correct pointer to the fuction
> "restorer", according to the kernel code.
> 2) The other reason is that default syscall rt_sigaction
> use kernel "sigaction" structure, which is different
> with normal "sigaction" structure.
>
> So,
> 1) We manage to find the address of the function
> "restorer" by using glibc function "sigaction",
> which might be something tricky. Then we add these
> arguments to make test run correctly.
> 2) We also use kernel "sigaction" structure to fit
> realtime syscall __NR_rt_sigaction.
>
> - rt_sigprocmask01
> First, there exsits the same problem as rt_sigaction01.
> Second, this testcase uses a unchanged signal number 33,
> which may diff among different archs and lead to error
> "unknown signal".
>
> So, we use a macro TEST_SIG which refers to SIGRTMIN
> to replace 33.

The problem is that SIGRTMIN is actually signal 32, not signal 33, and
here's a problematic comment to ponder over (from bits/signum.h):

/* These are the hard limits of the kernel.  These values should not be
   used directly at user level.  */
#define __SIGRTMIN      32
#define __SIGRTMAX      (_NSIG - 1)

I think the proper resolution would be to make the value SIGRTMIN+1.

> - rt_sigsuspend01
> There exists the same problem as rt_sigaction01.
>
> This patch fixed these failure.
>
> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
>
> ---
> =A0include/rt_signal.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0| =A0 60 ++++++++++++++++++
> =A0.../kernel/syscalls/rt_sigaction/rt_sigaction01.c =A0| =A0 64 ++++++++=
+++--------
> =A0.../syscalls/rt_sigprocmask/rt_sigprocmask01.c =A0 =A0 | =A0 32 ++++++=
+---
> =A0.../syscalls/rt_sigsuspend/rt_sigsuspend01.c =A0 =A0 =A0 | =A0 13 ++++-
> =A04 files changed, 132 insertions(+), 37 deletions(-)
> =A0create mode 100644 include/rt_signal.h
>
> diff --git a/include/rt_signal.h b/include/rt_signal.h
> new file mode 100644
> index 0000000..ea1e7e3
> --- /dev/null
> +++ b/include/rt_signal.h
> @@ -0,0 +1,60 @@
> +/***********************************************************************=
*******/
> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0*/
> +/* Copyright (c) 2009 FUJITSU LIMITED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0*/
> +/* This program is free software; =A0you can redistribute it and/or modi=
fy =A0 =A0 =A0*/
> +/* it under the terms of the GNU General Public License as published by =
=A0 =A0 =A0 */
> +/* the Free Software Foundation; either version 2 of the License, or =A0=
 =A0 =A0 =A0 =A0*/
> +/* (at your option) any later version. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0*/
> +/* This program is distributed in the hope that it will be useful, =A0 =
=A0 =A0 =A0 =A0 =A0*/
> +/* but WITHOUT ANY WARRANTY; =A0without even the implied warranty of =A0=
 =A0 =A0 =A0 =A0 =A0*/
> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +/* the GNU General Public License for more details. =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0*/
> +/* You should have received a copy of the GNU General Public License =A0=
 =A0 =A0 =A0 =A0*/
> +/* along with this program; =A0if not, write to the Free Software =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 */
> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 U=
SA =A0 =A0*/
> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0*/
> +/* Author: Liu Bo <liubo2009@cn.fujitsu.com> =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0*/
> +/***********************************************************************=
*******/
> +
> +#ifndef __LTP_SIGNAL_H
> +#define __LTP_SIGNAL_H
> +
> +/* We do not globally define the SA_RESTORER flag so do it here. =A0*/
> +#define HAVE_SA_RESTORER
> +#define SA_RESTORER 0x04000000
> +
> +struct kernel_sigaction {
> + =A0 =A0 =A0 __sighandler_t k_sa_handler;
> + =A0 =A0 =A0 unsigned long sa_flags;
> + =A0 =A0 =A0 void (*sa_restorer) (void);
> + =A0 =A0 =A0 sigset_t sa_mask;
> +};
> +
> +void (*restore_rt) (void);
> +
> +void
> +handler_h(void)
> +{
> + =A0 =A0 =A0 return;
> +}
> +
> +/* initial restore_rt for x86_64 */
> +void
> +sig_initial(int sig)
> +{
> + =A0 =A0 =A0 struct sigaction act, oact;
> +
> + =A0 =A0 =A0 act.sa_handler =3D (void *)handler_h;
> + =A0 =A0 =A0 sigemptyset(&act.sa_mask);
> + =A0 =A0 =A0 sigaddset(&act.sa_mask, sig);
> + =A0 =A0 =A0 /* copy act.sa_restorer to kernel */
> + =A0 =A0 =A0 sigaction(sig, &act, &oact);
> + =A0 =A0 =A0 /* copy oact.sa_restorer from kernel */
> + =A0 =A0 =A0 sigaction(sig, &act, &oact);
> + =A0 =A0 =A0 restore_rt =3D oact.sa_restorer;
> +}
> +#endif
> diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/te=
stcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> index ffc5fa2..d30f204 100644
> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> @@ -55,6 +55,10 @@
> =A0#include "usctest.h"
> =A0#include "linux_syscall_numbers.h"
>
> +#ifdef __x86_64__
> +#include "rt_signal.h"
> +#endif
> +
> =A0/*
> =A0* For all but __mips__:
> =A0*
> @@ -101,13 +105,14 @@ int =A0TST_TOTAL =3D 1; =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 /* total number of tests in this file. =A0 *
> =A0/* =A0 =A0 =A0 =A0 =A0 =A0 =A0On success - Exits calling tst_exit(). W=
ith '0' return code. =A0*/
> =A0/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0*/
> =A0/*********************************************************************=
*********/
> -extern void cleanup() {
> - =A0 =A0 =A0 =A0/* Remove tmp dir and all files in it */
> - =A0 =A0 =A0 =A0TEST_CLEANUP;
> - =A0 =A0 =A0 =A0tst_rmdir();
> +extern void cleanup()
> +{
> + =A0 =A0 =A0 /* Remove tmp dir and all files in it */
> + =A0 =A0 =A0 TEST_CLEANUP;
> + =A0 =A0 =A0 tst_rmdir();
>
> - =A0 =A0 =A0 =A0/* Exit with appropriate return code. */
> - =A0 =A0 =A0 =A0tst_exit();
> + =A0 =A0 =A0 /* Exit with appropriate return code. */
> + =A0 =A0 =A0 tst_exit();
> =A0}
>
> =A0/* Local =A0Functions */
> @@ -128,11 +133,12 @@ extern void cleanup() {
> =A0/* =A0 =A0 =A0 =A0 =A0 =A0 =A0On success - returns 0. =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0*/
> =A0/*********************************************************************=
*********/
> -void setup() {
> - =A0 =A0 =A0 =A0/* Capture signals if any */
> - =A0 =A0 =A0 =A0/* Create temporary directories */
> - =A0 =A0 =A0 =A0TEST_PAUSE;
> - =A0 =A0 =A0 =A0tst_tmpdir();
> +void setup()
> +{
> + =A0 =A0 =A0 /* Capture signals if any */
> + =A0 =A0 =A0 /* Create temporary directories */
> + =A0 =A0 =A0 TEST_PAUSE;
> + =A0 =A0 =A0 tst_tmpdir();
> =A0}
>
> =A0int test_flags[] =3D {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND, SA_RESETH=
AND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
> @@ -144,22 +150,23 @@ handler(int sig)
> =A0 =A0 =A0 =A0 tst_resm(TINFO,"Signal Handler Called with signal number =
%d\n",sig);
> =A0 =A0 =A0 =A0 return;
> =A0}
> -
> =A0int
> -set_handler(int sig, int sig_to_mask, int mask_flags)
> +set_handler(int sig, int mask_flags)
> =A0{
> - =A0 =A0 =A0 =A0struct sigaction sa, oldaction;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sa.sa_sigaction =3D (void *)handler;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sa.sa_flags =3D mask_flags;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sigemptyset(&sa.sa_mask);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sigaddset(&sa.sa_mask, sig_to_mask);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(syscall(__NR_rt_sigaction,sig, &sa,=
 &oldaction,SIGSETSIZE));
> - =A0 =A0 =A0 =A0if (TEST_RETURN =3D=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> - =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return TEST_RETURN;
> - =A0 =A0 =A0 =A0}
> +#ifdef __x86_64__
> + =A0 =A0 =A0 struct kernel_sigaction sa, oldaction;
> + =A0 =A0 =A0 mask_flags |=3D SA_RESTORER;
> + =A0 =A0 =A0 sa.sa_restorer =3D restore_rt;
> + =A0 =A0 =A0 sa.k_sa_handler =3D (void *)handler;
> +#else
> + =A0 =A0 =A0 struct sigaction sa, oldaction;
> + =A0 =A0 =A0 sa.sa_handler =3D (void *)handler;
> +#endif
> + =A0 =A0 =A0 sa.sa_flags =3D mask_flags;
> + =A0 =A0 =A0 sigemptyset(&sa.sa_mask);
> + =A0 =A0 =A0 sigaddset(&sa.sa_mask, sig);
> + =A0 =A0 =A0 TEST(syscall(__NR_rt_sigaction,sig, &sa, &oldaction,SIGSETS=
IZE));
> + =A0 =A0 =A0 return TEST_RETURN;
> =A0}
>
>
> @@ -182,8 +189,11 @@ int main(int ac, char **av) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (testno =3D 0; testno < TST_TOTAL; ++=
testno) {
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (signal =3D SIGRTMIN; =
signal <=3D (SIGRTMAX ); signal++){//signal for 34 to 65
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for(flag=3D=
0; flag<5;flag++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0TEST(set_handler(signal, 0, test_flags[flag]));
> +#ifdef __x86_64__
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_initial=
(signal);
> +#endif
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for(flag=3D=
0; flag<5;flag++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0TEST(set_handler(signal, test_flags[flag]));

I know this isn't your code change, but since you're here.. a better
way to do this would be:

sizeof (test_flags) / sizeof (test_flags[0])

as this is a fixed array buffer.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 if (TEST_RETURN =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO,"signal: %d ", signal);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0tst_resm(TPASS, "rt_sigaction call succeeded: result=
 =3D %ld ",TEST_RETURN );
> diff --git a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c =
b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> index 6398a28..8bcdc78 100644
> --- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> +++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
> @@ -62,6 +62,12 @@
> =A0#include "usctest.h"
> =A0#include "linux_syscall_numbers.h"
>
> +#ifdef __x86_64__
> +#include "rt_signal.h"
> +#endif
> +
> +#define TEST_SIG SIGRTMIN
> +
> =A0/* Extern Global Variables */
> =A0extern int Tst_count; =A0 =A0 =A0 =A0 =A0 /* counter for tst_xxx routi=
nes. =A0 =A0 =A0 =A0 */
> =A0extern char *TESTDIR; =A0 =A0 =A0 =A0 =A0 /* temporary dir created by =
tst_tmpdir() */
> @@ -131,7 +137,16 @@ void sig_handler(int sig)
> =A0}
>
> =A0int main(int ac, char **av) {
> - =A0 =A0 =A0 struct sigaction act, oact;
> +#ifdef __x86_64__
> + =A0 =A0 =A0 struct kernel_sigaction act, oact;
> + =A0 =A0 =A0 sig_initial(TEST_SIG);
> + =A0 =A0 =A0 act.sa_flags |=3D SA_RESTORER;
> + =A0 =A0 =A0 =A0act.sa_restorer =3D restore_rt;
> + =A0 =A0 =A0 =A0act.k_sa_handler =3D sig_handler;
> +#else
> + =A0 =A0 =A0 =A0struct sigaction act, oact;
> + =A0 =A0 =A0 =A0act.sa_handler =3D sig_handler;
> +#endif
> =A0 =A0 =A0 =A0 sigset_t set, oset;
> =A0 =A0 =A0 =A0 int lc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* loop counter */
> =A0 =A0 =A0 =A0 char *msg; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* message returned=
 from parse_opts */
> @@ -154,22 +169,21 @@ int main(int ac, char **av) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(sigaddset(&set, 33));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(sigaddset(&set, TEST_S=
IG));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(T=
FAIL,"Call to sigaddset() Failed, errno=3D%d : %s",TEST_ERRNO, strerror(TES=
T_ERRNO));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> -
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* call rt_sigaction() */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 act.sa_handler =3D sig_hand=
ler;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(syscall(__NR_rt_sig=
action, 33, &act, &oact, 8));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(syscall(__NR_rt_sig=
action, TEST_SIG, &act, &oact, 8));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN !=3D 0){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(T=
FAIL,"Call to rt_sigaction() Failed, errno=3D%d : %s",TEST_ERRNO, strerror(=
TEST_ERRNO));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* call rt_sigprocmask() to=
 block signal#33 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* call rt_sigprocmask() to=
 block signal#SIGRTMIN */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(syscall(__NR_rt_sigp=
rocmask, SIG_BLOCK, &set, &oset, 8));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(T=
FAIL,"Call to rt_sigprocmask()**** Failed, errno=3D%d : %s",TEST_ERRNO, str=
error(TEST_ERRNO));
> @@ -178,7 +192,7 @@ int main(int ac, char **av) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(kill(g=
etpid(), 33));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TEST(kill(g=
etpid(), TEST_SIG));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RE=
TURN !=3D 0){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0tst_resm(TFAIL,"Call to kill() Failed, errno=3D%d : %s",TEST_ERRNO, =
strerror(TEST_ERRNO));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0cleanup();
> @@ -198,13 +212,13 @@ int main(int ac, char **av) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0cleanup();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 TEST(sigismember(&oset, 33));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 TEST(sigismember(&oset, TEST_SIG));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0if(TEST_RETURN =3D=3D 0 ){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL,"call sigismember() Failed, errno=3D%=
d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0cleanup();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* call rt_sigprocmask() to unblock signal#33 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* call rt_sigprocmask() to unblock signal#SIGRTMIN */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, &set, &oset, 8));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0if(TEST_RETURN =3D=3D -1){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0tst_resm(TFAIL,"Call to rt_sigprocmask() Failed, err=
no=3D%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
> diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/=
testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> index 416a7c9..84f2967 100644
> --- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> +++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> @@ -47,6 +47,10 @@
> =A0#include "usctest.h"
> =A0#include "linux_syscall_numbers.h"
>
> +#ifdef __x86_64__
> +#include "rt_signal.h"
> +#endif
> +
> =A0/* Extern Global Variables */
> =A0extern int Tst_count; =A0 =A0 =A0 =A0 =A0 /* counter for tst_xxx routi=
nes. =A0 =A0 =A0 =A0 */
> =A0extern char *TESTDIR; =A0 =A0 =A0 =A0 =A0 /* temporary dir created by =
tst_tmpdir() */
> @@ -139,9 +143,16 @@ int main(int ac, char **av) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> +#ifdef __x86_64__
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct kernel_sigaction act=
, oact;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sig_initial(SIGALRM);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 act.sa_flags |=3D SA_RESTOR=
ER;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 act.sa_restorer =3D restore=
_rt;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 act.k_sa_handler =3D sig_ha=
ndler;
> +#else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sigaction act, oact;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0act.sa_handler =3D sig_han=
dler;
> -
> +#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(syscall(__NR_rt_sigac=
tion, SIGALRM, &act, &oact, 8));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if(TEST_RETURN =3D=3D -1){
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(T=
FAIL,"rt_sigaction() Failed, errno=3D%d : %s",TEST_ERRNO, strerror(TEST_ERR=
NO));
> --
> 1.6.2.2

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
