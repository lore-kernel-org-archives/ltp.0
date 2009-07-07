Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MO9E0-0003iG-Gb
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 11:52:40 +0000
Received: from mail-qy0-f200.google.com ([209.85.221.200])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MO9Du-0000Wn-Ef
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 11:52:40 +0000
Received: by mail-qy0-f200.google.com with SMTP id 38so4769899qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Jul 2009 04:52:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1246895458.4887.53.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810907030846x35249218u1fe574ba70f796fd@mail.gmail.com>
	<1246895458.4887.53.camel@subratamodak.linux.ibm.com>
Date: Tue, 7 Jul 2009 17:22:32 +0530
Message-ID: <f5a7b3810907070452u62c1c4c6l3f3ed8f1f169f209@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=0015175cf70a02553b046e1c4253
Subject: Re: [LTP] [FIX PATCHE] rt_sigaction
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>

--0015175cf70a02553b046e1c4253
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Garrett Cooper,

Thanks for your info.

>Oops... looks like someone forgot __amd64__ / >__ia64__:

yes.
i forgot to add these ARCH.
Because I am not having this Architecture at my end :-(

>gcc -g -O2 -I../../include -g -Wall -I../../../../include >-Wall -O2 -W
>rt_sigaction01.c -L../../../../lib -lltp -o rt_sigaction01
>rt_sigaction01.c: In function 'set_handler':
>rt_sigaction01.c:147: error: 'SIGSETSIZE' >undeclared .(first use in
>this function)
>rt_sigaction01.c:147: error: (Each undeclared >identifier is reported only=
 once
>rt_sigaction01.c:147: error: for each function it >appears in.)
>make[4]: *** [rt_sigaction01] Error 1

>I tried using sizeof(sigaction_t), but unfortunately the >results for
>the testcase(s) on my system were always EINVAL. >This issue wasn't
>present a few days ago...

>Any ideas?


I have made a patch to fix this issue please review the this temporary fix.

In my previous mail I have stated that sigset size (size_t sigsetsize)
will be different for Different ARCH. It is depending on
_COMPAT_NSIG_WORDS Macro.

We have to conform how its different with respect to ARCH and need to
have a generic solution to fix this issue.

I think its going to be an issue othere than __arm__ || __i386__ ||
__powerpc__ || __amd64__ || __ia64__ and __mips__

There are different ARCH are being used by our LTP developers.

I=92ll investigate this issue and come back with generic Solution to
support most of the ARCH.


please refer this  linux-2.6.30/include/linux/compat.h

http://lxr.linux.no/linux+v2.6.30/include/linux/compat.h#L75

#define _COMPAT_NSIG_WORDS      (_COMPAT_NSIG / _COMPAT_NSIG_BPW)

  typedef struct {
          compat_sigset_word      sig[_COMPAT_NSIG_WORDS];
  } compat_sigset_t;

Your suggestions are welcome ... :)


Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c	2009-07-07
16:58:11.000000000 +0530
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c	2009-07-07
16:59:38.000000000 +0530
@@ -59,7 +59,7 @@
 #define SIGSETSIZE 16
 #endif

-#if defined __arm__ || __i386__ || __powerpc__
+#if defined __arm__ || __i386__ || __powerpc__ || __amd64__ || __ia64__
 #define SIGSETSIZE 8
 #endif

diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
--- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c	2009-07-07
16:58:11.000000000 +0530
+++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c	2009-07-07
16:59:48.000000000 +0530
@@ -55,7 +55,7 @@
 #define SIGSETSIZE 16
 #endif

-#if defined __arm__ || __i386__ || __powerpc__
+#if defined __arm__ || __i386__ || __powerpc__ || __amd64__ || __ia64__
 #define SIGSETSIZE 8
 #endif



On Mon, Jul 6, 2009 at 9:20 PM, Subrata Modak<subrata@linux.vnet.ibm.com> w=
rote:
> On Fri, 2009-07-03 at 21:16 +0530, naresh kamboju wrote:
>> Hi,
>>
>> I have divided rt_sigaction01.c test case in to three test cases
>>
>> 1. rt_sigaction01.c (Functionality)
>> 2. rt_sigaction02.c (EFAULT)
>> 3. rt_sigaction03.c (EINVAL)
>>
>> In these test cases rt_sigaction use signal number from SIGRTMIN (34)
>> to =A0SIGRTMAX (64).The Real Time (RT) signals will start from 34 to 64
>> as per signal.h because sigaction is testing from 1 to 30 signals I
>> hope.
>>
>> If you want to test 1 to 64 signals by rt_sigaction signal number 9
>> and 19 i.e SIGKILL and SIGTERM will FAIL, because as per
>> Specifications we should not use SIGKILL and SIGTERM signals with
>> rt_sigaction/sigaction.
>>
>> long sys_rt_sigaction (int sig, const struct sigaction *act, struct
>> sigaction *oact, size_t sigsetsize)
>>
>> SIGSETSIZE is different for different architectures that is taken care
>> =A0for ARM, PowerPC, X86 and MIPS in this patch.
>>
>> Subrata,
>>
>> Coding style is not as LTP, I did not get much time to fix this.
>> If you are using any indent for LTP, please share I will use those
>> script to fix coding style.
>>
>> If any body is interested to fix coding style issue please welcome... :-=
)
>>
>>
>> I have attached fix patch and below.
>> Please review the same.
>>
>> Best regards
>> Naresh Kamboju
>>
>> /*******************************************************/
>> Test Start Time: Fri Jul =A03 07:52:04 2009
>> -----------------------------------------
>> Testcase =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Result =A0 =A0 Exit=
 Value
>> -------- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ------ =A0 =A0 ----=
------
>> rt_sigaction01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
>> rt_sigaction02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
>> rt_sigaction03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
>>
>> -----------------------------------------------
>> Total Tests: 3
>> Total Failures: 0
>> Kernel Version: 2.6.23.17-alp_nl-pc-g56b4520c-dirty
>> Machine Architecture: i686
>> Hostname: 43.88.101.228
>> ************************************************************/
>>
>> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>
> Thanks Naresh.
>
> Regards--
> Subrata
>
>>
>> diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
>> b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
>> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c 2009-05-21
>> 23:50:58.000000000 +0530
>> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c 2009-07-03
>> 19:38:41.000000000 +0530
>> @@ -55,6 +55,15 @@
>> =A0#include "usctest.h"
>> =A0#include "linux_syscall_numbers.h"
>>
>> +#if defined __mips__
>> +#define SIGSETSIZE 16
>> +#endif
>> +
>> +#if defined __arm__ || __i386__ || __powerpc__
>> +#define SIGSETSIZE 8
>> +#endif
>> +
>> +
>> =A0/* Extern Global Variables */
>> =A0extern int Tst_count; =A0 =A0 =A0 =A0 =A0 /* counter for tst_xxx rout=
ines. =A0 =A0 =A0 =A0 */
>> =A0extern char *TESTDIR; =A0 =A0 =A0 =A0 =A0 /* temporary dir created by=
 tst_tmpdir() */
>> @@ -117,58 +126,35 @@
>> =A0}
>>
>> =A0int test_flags[] =3D {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
>> SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
>> +char *test_flags_list[] =3D {"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND",
>> "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK"};
>>
>> =A0void
>> =A0handler(int sig)
>> =A0{
>> - =A0 =A0 =A0 =A0tst_resm(TINFO,"Here is signal handler. Got signal: %d,=
 do
>> nothing here\n", sig);
>> + =A0 =A0 =A0 =A0tst_resm(TINFO,"Signal Handler Called with signal numbe=
r %d\n",sig);
>> =A0 =A0 =A0 =A0 =A0return;
>> =A0}
>>
>> =A0int
>> -set_handler(int sig, int sig_to_mask, int flag, int mask_flags)
>> +set_handler(int sig, int sig_to_mask, int mask_flags)
>> =A0{
>> =A0 =A0 =A0 =A0 =A0struct sigaction sa, oldaction;
>> - =A0 =A0 =A0 =A0int err =3D 0;
>>
>> - =A0 =A0 =A0 =A0if (flag =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO,"flag0 - ");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sa.sa_sigaction =3D (void *)handler;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sa.sa_flags =3D mask_flags;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(sigemptyset(&sa.sa_mask));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(sigaddset(&sa.sa_mask, sig_to_mask=
));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(err =3D syscall(__NR_rt_sigaction,=
sig, &sa, NULL,8));
>> - =A0 =A0 =A0 =A0} else if (flag =3D=3D 1) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO,"flag1 - ");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(err =3D syscall(__NR_rt_sigaction,=
sig, (void *)-1, NULL,8));
>> - =A0 =A0 =A0 =A0} else if (flag =3D=3D 2) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO,"flag2 - ");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(err =3D syscall(__NR_rt_sigaction,=
sig, NULL, (void *)-1,8));
>> - =A0 =A0 } else if (flag =3D=3D 3) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm(TINFO,"flag3 - ");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sa.sa_sigaction =3D (void *)handler;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sa.sa_flags =3D mask_flags;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(sigemptyset(&sa.sa_mask));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(sigaddset(&sa.sa_mask, sig_to_mask=
));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(err =3D syscall(__NR_rt_sigaction,=
sig, &sa, &oldaction, 8));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (TEST_RETURN =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return TEST_ERRNO;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 =A0} else if (flag =3D=3D 4){
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(err =3D syscall(__=
NR_rt_sigaction,sig,
>> &sa, NULL,9));
>> - =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sigemptyset(&sa.sa_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sigaddset(&sa.sa_mask, sig_to_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(syscall(__NR_rt_sigaction,sig, &sa=
,
>> &oldaction,SIGSETSIZE));
>> =A0 =A0 =A0 =A0 =A0if (TEST_RETURN =3D=3D 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>> =A0 =A0 =A0 =A0 =A0} else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return TEST_ERRNO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return TEST_RETURN;
>> =A0 =A0 =A0 =A0 =A0}
>> =A0}
>>
>>
>> =A0int main(int ac, char **av) {
>> - =A0 =A0 int retnval, i, j;
>> + =A0 =A0 int signal, flag;
>> =A0 =A0 =A0 =A0 =A0int lc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* loop count=
er */
>> =A0 =A0 =A0 =A0 =A0char *msg; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* message retu=
rned from parse_opts */
>>
>> @@ -185,24 +171,26 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tst_count =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (testno =3D 0; testno < TST_TOTAL=
; ++testno) {
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i <=3D (SIGRTMAX=
 + 1); i++){//signal for 0 to 65
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO=
,"Signal : %d",i);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 for (j =3D 0; j < 4; j++){
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0TEST(retnval =3D set_handler(i, 0, j,
>> test_flags[j]));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (signal =3D SIGRTMIN; sign=
al <=3D (SIGRTMAX ); signal++){//signal
>> for 34 to 65
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for(flag=3D0; =
flag<5;flag++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0TEST(set_handler(signal, 0, test_flags[flag]));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0if (TEST_RETURN =3D=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TPASS, "rt_sigaction call succ=
eeded: result =3D
>> %d",TEST_RETURN);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 tst_resm(TINFO,"signal: %d ", signal);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 tst_resm(TPASS, "rt_sigaction call succeeded: result =
=3D
>> %d ",TEST_RETURN );
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "sa.sa_flags =3D %s ",test_flags_list[f=
lag]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 kill(getpid(),signal);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "%s failed - errno =3D =
%d :
>> %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup();
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>>
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 cleanup();
>> =A0 =A0 =A0 =A0 =A0tst_exit();
>> =A0}
>>
>> diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
>> b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
>> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c 1970-01-01
>> 05:30:00.000000000 +0530
>> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c 2009-07-03
>> 19:24:26.000000000 +0530
>> @@ -0,0 +1,183 @@
>> +/**********************************************************************=
********/
>> +/* Copyright (c) Crackerjack Project., 2007
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* This program is free software; =A0you can redistribute it and/or
>> modify =A0 =A0 =A0*/
>> +/* it under the terms of the GNU General Public License as published
>> by =A0 =A0 =A0 */
>> +/* the Free Software Foundation; either version 2 of the License, or
>> =A0 =A0 =A0 =A0 */
>> +/* (at your option) any later version.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* This program is distributed in the hope that it will be useful,
>> =A0 =A0 =A0 =A0 */
>> +/* but WITHOUT ANY WARRANTY; =A0without even the implied warranty of
>> =A0 =A0 =A0 =A0 */
>> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See
>> =A0 =A0 =A0 =A0 */
>> +/* the GNU General Public License for more details.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* You should have received a copy of the GNU General Public License
>> =A0 =A0 =A0 =A0 */
>> +/* along with this program; =A0if not, write to the Free Software
>> =A0 =A0 =A0 =A0 */
>> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
>> 02111-1307 USA =A0 =A0*/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/**********************************************************************=
********/
>> +/**********************************************************************=
********/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* File: =A0 =A0 =A0 =A0rt_sigaction02.c
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Description: This tests the rt_sigaction() syscall
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 rt_sigaction Expected EFAULT error check =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Usage: =A0<for command-line>
>> =A0 =A0 =A0 =A0 */
>> +/* rt_sigaction02 [-c n] [-e][-i n] [-I x] [-p x] [-t]
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0where, =A0-c n : Run n copies concurrently.
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0-e =A0 : Turn on errno logging.
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0-i n : Execute test n times.
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0-I x : Execute test for x seconds.
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0-P x : Pause for x seconds between iterat=
ions.
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0-t =A0 : Turn on syscall timing.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Total Tests: 1
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Test Name: =A0 rt_sigaction02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> +/* History: =A0 =A0 Porting from Crackerjack to LTP is done by
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0Manas Kumar Nayak maknayak@in.ibm.com>
>> =A0 =A0 =A0 =A0 */
>> +/**********************************************************************=
********/
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <signal.h>
>> +#include <errno.h>
>> +#include <sys/syscall.h>
>> +#include <string.h>
>> +
>> +/* Harness Specific Include Files. */
>> +#include "test.h"
>> +#include "usctest.h"
>> +#include "linux_syscall_numbers.h"
>> +
>> +#if defined __mips__
>> +#define SIGSETSIZE 16
>> +#endif
>> +
>> +#if defined __arm__ || __i386__ || __powerpc__
>> +#define SIGSETSIZE 8
>> +#endif
>> +
>> +#define INVAL_STRUCT -1
>> +
>> +/* Extern Global Variables */
>> +extern int Tst_count; =A0 =A0 =A0 =A0 =A0 /* counter for tst_xxx routin=
es. =A0 =A0 =A0 =A0 */
>> +extern char *TESTDIR; =A0 =A0 =A0 =A0 =A0 /* temporary dir created by t=
st_tmpdir() */
>> +
>> +/* Global Variables */
>> +char *TCID =3D "rt_sigaction02"; =A0/* Test program identifier.*/
>> +int =A0testno;
>> +int =A0TST_TOTAL =3D 1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* total nu=
mber of tests in
>> this file. =A0 */
>> +
>> +/* Extern Global Functions */
>> +/**********************************************************************=
********/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Function: =A0 =A0cleanup
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Description: Performs all one time clean up for this test on
>> successful =A0 =A0*/
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0completion, =A0premature exit or =A0failu=
re. Closes all
>> temporary */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0files, removes all temporary directories =
exits the
>> test with =A0*/
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0appropriate return code by calling tst_ex=
it()
>> function. =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Input: =A0 =A0 =A0 None.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Output: =A0 =A0 =A0None.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Return: =A0 =A0 =A0On failure - Exits calling tst_exit(). Non '0' re=
turn
>> code. =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0On success - Exits calling tst_exit(). Wi=
th '0'
>> return code. =A0*/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/**********************************************************************=
********/
>> +extern void cleanup() {
>> + =A0 =A0 =A0 =A0/* Remove tmp dir and all files in it */
>> + =A0 =A0 =A0 =A0TEST_CLEANUP;
>> + =A0 =A0 =A0 =A0tst_rmdir();
>> +
>> + =A0 =A0 =A0 =A0/* Exit with appropriate return code. */
>> + =A0 =A0 =A0 =A0tst_exit();
>> +}
>> +
>> +/* Local =A0Functions */
>> +/**********************************************************************=
********/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Function: =A0 =A0setup
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Description: Performs all one time setup for this test. This
>> function is =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0typically used to capture signals, create=
 temporary
>> dirs =A0 =A0 =A0*/
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0and temporary files that may be used in t=
he course of
>> this =A0 =A0*/
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0test.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Input: =A0 =A0 =A0 None.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Output: =A0 =A0 =A0None.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Return: =A0 =A0 =A0On failure - Exits by calling cleanup().
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0On success - returns 0.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/**********************************************************************=
********/
>> +void setup() {
>> + =A0 =A0 =A0 =A0/* Capture signals if any */
>> + =A0 =A0 =A0 =A0/* Create temporary directories */
>> + =A0 =A0 =A0 =A0TEST_PAUSE;
>> + =A0 =A0 =A0 =A0tst_tmpdir();
>> +}
>> +
>> +int test_flags[] =3D {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
>> SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
>> +char *test_flags_list[] =3D {"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND",
>> "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK"};
>> +
>> +struct test_case_t {
>> + =A0 =A0 =A0 =A0int exp_errno;
>> + =A0 =A0 =A0 =A0char *errdesc;
>> +} test_cases[] =3D {
>> + =A0 =A0 { EFAULT, "EFAULT" }
>> +};
>> +
>> +
>> +int main(int ac, char **av) {
>> + =A0 =A0 int signal, flag;
>> + =A0 =A0 =A0 =A0int lc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* loop counter=
 */
>> + =A0 =A0 =A0 =A0char *msg; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* message return=
ed from parse_opts */
>> +
>> + =A0 =A0 =A0 =A0/* parse standard options */
>> + =A0 =A0 =A0 =A0if ((msg =3D parse_opts(ac, av, (option_t *)NULL, NULL)=
) !=3D
>> (char *)NULL){
>> + =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR=
 - %s", msg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
>> + =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0setup();
>> +
>> + =A0 =A0 =A0 =A0/* Check looping state if -i option given */
>> + =A0 =A0 =A0 =A0for (lc =3D 0; TEST_LOOPING(lc); ++lc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tst_count =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (testno =3D 0; testno < TST_TOTAL; =
++testno) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (signal =3D SIGRTMIN; sign=
al <=3D (SIGRTMAX ); signal++){//signal
>> for 34 to 65
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for(flag=3D0; =
flag<5;flag++) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* long sys_=
rt_sigaction (int sig, const struct sigaction *act, *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* truct sig=
action *oact, size_t sigsetsize); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* EFAULT: =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* An invali=
d act or oact value was specified =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0TEST(syscall(__NR_rt_sigaction,signal, INVAL_STRUCT, NULL,SIGSETSIZE=
));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 if((TEST_RETURN =3D=3D -1) && (TEST_ERRNO =3D=3D test_cases[0].exp_errn=
o)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "sa.sa_flags =3D %s ",t=
est_flags_list[flag]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TPASS, "%s failure with sig: %=
d as
>> expected errno =A0=3D %s : %s", TCID, signal,test_cases[0].errdesc,
>> strerror(TEST_ERRNO));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0} else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "rt_sigaction call succeeded: result =
=3D
>> %d got error %d:but expected =A0%d", TEST_RETURN, TEST_ERRNO,
>> test_cases[0].exp_errno);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "sa.sa_flags =3D %s ",test_flags_list[f=
lag]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> +
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0 cleanup();
>> + =A0 =A0 =A0 =A0tst_exit();
>> +}
>> +
>> diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
>> b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c
>> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c 1970-01-01
>> 05:30:00.000000000 +0530
>> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction03.c 2009-07-03
>> 19:24:12.000000000 +0530
>> @@ -0,0 +1,200 @@
>> +/**********************************************************************=
********/
>> +/* Copyright (c) Crackerjack Project., 2007
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* This program is free software; =A0you can redistribute it and/or
>> modify =A0 =A0 =A0*/
>> +/* it under the terms of the GNU General Public License as published
>> by =A0 =A0 =A0 */
>> +/* the Free Software Foundation; either version 2 of the License, or
>> =A0 =A0 =A0 =A0 */
>> +/* (at your option) any later version.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* This program is distributed in the hope that it will be useful,
>> =A0 =A0 =A0 =A0 */
>> +/* but WITHOUT ANY WARRANTY; =A0without even the implied warranty of
>> =A0 =A0 =A0 =A0 */
>> +/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See
>> =A0 =A0 =A0 =A0 */
>> +/* the GNU General Public License for more details.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* You should have received a copy of the GNU General Public License
>> =A0 =A0 =A0 =A0 */
>> +/* along with this program; =A0if not, write to the Free Software
>> =A0 =A0 =A0 =A0 */
>> +/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
>> 02111-1307 USA =A0 =A0*/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/**********************************************************************=
********/
>> +/**********************************************************************=
********/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* File: =A0 =A0 =A0 =A0rt_sigaction03.c
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Description: This tests the rt_sigaction() syscall
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 rt_sigaction Expected EINVAL error check =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Usage: =A0<for command-line>
>> =A0 =A0 =A0 =A0 */
>> +/* rt_sigaction03 [-c n] [-e][-i n] [-I x] [-p x] [-t]
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0where, =A0-c n : Run n copies concurrently.
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0-e =A0 : Turn on errno logging.
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0-i n : Execute test n times.
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0-I x : Execute test for x seconds.
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0-P x : Pause for x seconds between iterat=
ions.
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0-t =A0 : Turn on syscall timing.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Total Tests: 1
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Test Name: =A0 rt_sigaction03 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> +/* History: =A0 =A0 Porting from Crackerjack to LTP is done by
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0Manas Kumar Nayak maknayak@in.ibm.com>
>> =A0 =A0 =A0 =A0 */
>> +/**********************************************************************=
********/
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <signal.h>
>> +#include <errno.h>
>> +#include <sys/syscall.h>
>> +#include <string.h>
>> +
>> +/* Harness Specific Include Files. */
>> +#include "test.h"
>> +#include "usctest.h"
>> +#include "linux_syscall_numbers.h"
>> +
>> +#define INVAL_SIGSETSIZE -1
>> +
>> +/* Extern Global Variables */
>> +extern int Tst_count; =A0 =A0 =A0 =A0 =A0 /* counter for tst_xxx routin=
es. =A0 =A0 =A0 =A0 */
>> +extern char *TESTDIR; =A0 =A0 =A0 =A0 =A0 /* temporary dir created by t=
st_tmpdir() */
>> +
>> +/* Global Variables */
>> +char *TCID =3D "rt_sigaction03"; =A0/* Test program identifier.*/
>> +int =A0testno;
>> +int =A0TST_TOTAL =3D 1; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* total nu=
mber of tests in
>> this file. =A0 */
>> +
>> +/* Extern Global Functions */
>> +/**********************************************************************=
********/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Function: =A0 =A0cleanup
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Description: Performs all one time clean up for this test on
>> successful =A0 =A0*/
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0completion, =A0premature exit or =A0failu=
re. Closes all
>> temporary */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0files, removes all temporary directories =
exits the
>> test with =A0*/
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0appropriate return code by calling tst_ex=
it()
>> function. =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Input: =A0 =A0 =A0 None.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Output: =A0 =A0 =A0None.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Return: =A0 =A0 =A0On failure - Exits calling tst_exit(). Non '0' re=
turn
>> code. =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0On success - Exits calling tst_exit(). Wi=
th '0'
>> return code. =A0*/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/**********************************************************************=
********/
>> +extern void cleanup() {
>> + =A0 =A0 =A0 =A0/* Remove tmp dir and all files in it */
>> + =A0 =A0 =A0 =A0TEST_CLEANUP;
>> + =A0 =A0 =A0 =A0tst_rmdir();
>> +
>> + =A0 =A0 =A0 =A0/* Exit with appropriate return code. */
>> + =A0 =A0 =A0 =A0tst_exit();
>> +}
>> +
>> +/* Local =A0Functions */
>> +/**********************************************************************=
********/
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Function: =A0 =A0setup
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Description: Performs all one time setup for this test. This
>> function is =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0typically used to capture signals, create=
 temporary
>> dirs =A0 =A0 =A0*/
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0and temporary files that may be used in t=
he course of
>> this =A0 =A0*/
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0test.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Input: =A0 =A0 =A0 None.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Output: =A0 =A0 =A0None.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/* Return: =A0 =A0 =A0On failure - Exits by calling cleanup().
>> =A0 =A0 =A0 =A0 */
>> +/* =A0 =A0 =A0 =A0 =A0 =A0 =A0On success - returns 0.
>> =A0 =A0 =A0 =A0 */
>> +/*
>> =A0 =A0 =A0 =A0 */
>> +/**********************************************************************=
********/
>> +void setup() {
>> + =A0 =A0 =A0 =A0/* Capture signals if any */
>> + =A0 =A0 =A0 =A0/* Create temporary directories */
>> + =A0 =A0 =A0 =A0TEST_PAUSE;
>> + =A0 =A0 =A0 =A0tst_tmpdir();
>> +}
>> +
>> +int test_flags[] =3D {SA_RESETHAND|SA_SIGINFO, SA_RESETHAND,
>> SA_RESETHAND|SA_SIGINFO, SA_RESETHAND|SA_SIGINFO, SA_NOMASK};
>> +char *test_flags_list[] =3D {"SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND",
>> "SA_RESETHAND|SA_SIGINFO", "SA_RESETHAND|SA_SIGINFO", "SA_NOMASK"};
>> +
>> +
>> +struct test_case_t {
>> + =A0 =A0 =A0 =A0int exp_errno;
>> + =A0 =A0 =A0 =A0char *errdesc;
>> +} test_cases[] =3D {
>> + =A0 =A0 { EINVAL, "EINVAL" }
>> +};
>> +
>> +void
>> +handler(int sig)
>> +{
>> + =A0 =A0 =A0 =A0tst_resm(TINFO,"Signal Handler Called with signal numbe=
r %d\n",sig);
>> + =A0 =A0 =A0 =A0return;
>> +}
>> +
>> +int
>> +set_handler(int sig, int sig_to_mask, int mask_flags)
>> +{
>> + =A0 =A0 =A0 =A0struct sigaction sa, oldaction;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sa.sa_sigaction =3D (void *)handler;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sa.sa_flags =3D mask_flags;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sigemptyset(&sa.sa_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sigaddset(&sa.sa_mask, sig_to_mask);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* long sys_rt_sigaction (int sig, const str=
uct sigaction *act, *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* truct sigaction *oact, size_t sigsetsize)=
; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* EINVAL: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* sigsetsize was not equivalent to the size=
 of a sigset_t type *
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(syscall(__NR_rt_sigaction,sig, &sa=
 ,
>> &oldaction,INVAL_SIGSETSIZE));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (TEST_RETURN =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return TEST_RETURN;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> +}
>> +
>> +
>> +int main(int ac, char **av) {
>> + =A0 =A0 int signal, flag;
>> + =A0 =A0 =A0 =A0int lc; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* loop counter=
 */
>> + =A0 =A0 =A0 =A0char *msg; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* message return=
ed from parse_opts */
>> +
>> + =A0 =A0 =A0 =A0/* parse standard options */
>> + =A0 =A0 =A0 =A0if ((msg =3D parse_opts(ac, av, (option_t *)NULL, NULL)=
) !=3D
>> (char *)NULL){
>> + =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR=
 - %s", msg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
>> + =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0setup();
>> +
>> + =A0 =A0 =A0 =A0/* Check looping state if -i option given */
>> + =A0 =A0 =A0 =A0for (lc =3D 0; TEST_LOOPING(lc); ++lc) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Tst_count =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (testno =3D 0; testno < TST_TOTAL; =
++testno) {
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (signal =3D SIGRTMIN; sign=
al <=3D (SIGRTMAX ); signal++){//signal
>> for 34 to 65
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for(flag=3D0; =
flag<5;flag++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0TEST(set_handler(signal, 0, test_flags[flag]));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 if((TEST_RETURN =3D=3D -1) && (TEST_ERRNO =3D=3D test_cases[0].exp_errn=
o)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "sa.sa_flags =3D %s ",t=
est_flags_list[flag]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TPASS, "%s failure with sig: %=
d as
>> expected errno =A0=3D %s : %s", TCID, signal,test_cases[0].errdesc,
>> strerror(TEST_ERRNO));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0} else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL, "rt_sigaction call succeeded: result =
=3D
>> %d got error %d:but expected =A0%d", TEST_RETURN, TEST_ERRNO,
>> test_cases[0].exp_errno);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 tst_resm(TINFO, "sa.sa_flags =3D %s ",test_flags_list[f=
lag]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> +
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0 cleanup();
>> + =A0 =A0 =A0 =A0tst_exit();
>> +}
>> +
>
>

--0015175cf70a02553b046e1c4253
Content-Type: application/octet-stream; name="ltp-fix-rt_sigaction.patch"
Content-Disposition: attachment; filename="ltp-fix-rt_sigaction.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwujnqtn0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ2FjdGlvbi9ydF9z
aWdhY3Rpb24wMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdhY3Rpb24vcnRf
c2lnYWN0aW9uMDEuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ2FjdGlv
bi9ydF9zaWdhY3Rpb24wMS5jCTIwMDktMDctMDcgMTY6NTg6MTEuMDAwMDAwMDAwICswNTMwCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lnYWN0aW9uL3J0X3NpZ2FjdGlvbjAx
LmMJMjAwOS0wNy0wNyAxNjo1OTozOC4wMDAwMDAwMDAgKzA1MzAKQEAgLTU5LDcgKzU5LDcgQEAK
ICNkZWZpbmUgU0lHU0VUU0laRSAxNgogI2VuZGlmCiAKLSNpZiBkZWZpbmVkIF9fYXJtX18gfHwg
X19pMzg2X18gfHwgX19wb3dlcnBjX18KKyNpZiBkZWZpbmVkIF9fYXJtX18gfHwgX19pMzg2X18g
fHwgX19wb3dlcnBjX18gfHwgX19hbWQ2NF9fIHx8IF9faWE2NF9fCiAjZGVmaW5lIFNJR1NFVFNJ
WkUgOAogI2VuZGlmCiAKZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0
X3NpZ2FjdGlvbi9ydF9zaWdhY3Rpb24wMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9y
dF9zaWdhY3Rpb24vcnRfc2lnYWN0aW9uMDIuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3J0X3NpZ2FjdGlvbi9ydF9zaWdhY3Rpb24wMi5jCTIwMDktMDctMDcgMTY6NTg6MTEuMDAw
MDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lnYWN0aW9u
L3J0X3NpZ2FjdGlvbjAyLmMJMjAwOS0wNy0wNyAxNjo1OTo0OC4wMDAwMDAwMDAgKzA1MzAKQEAg
LTU1LDcgKzU1LDcgQEAKICNkZWZpbmUgU0lHU0VUU0laRSAxNgogI2VuZGlmCiAKLSNpZiBkZWZp
bmVkIF9fYXJtX18gfHwgX19pMzg2X18gfHwgX19wb3dlcnBjX18KKyNpZiBkZWZpbmVkIF9fYXJt
X18gfHwgX19pMzg2X18gfHwgX19wb3dlcnBjX18gfHwgX19hbWQ2NF9fIHx8IF9faWE2NF9fCiAj
ZGVmaW5lIFNJR1NFVFNJWkUgOAogI2VuZGlmCiAK
--0015175cf70a02553b046e1c4253
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
--0015175cf70a02553b046e1c4253
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0015175cf70a02553b046e1c4253--

