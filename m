Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOxbl-0007gJ-F5
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 17:40:33 +0000
Received: from an-out-0708.google.com ([209.85.132.243])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOxbh-00028m-5l
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 17:40:33 +0000
Received: by an-out-0708.google.com with SMTP id c38so149374ana.37
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Jul 2009 10:40:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810907090750lde8e9carc9fe8a6317e67153@mail.gmail.com>
References: <f5a7b3810907070546v727fafc0o71fde4613e590254@mail.gmail.com>
	<364299f40907070906v174de45ci6765d3111f64a279@mail.gmail.com>
	<f5a7b3810907090750lde8e9carc9fe8a6317e67153@mail.gmail.com>
Date: Thu, 9 Jul 2009 10:40:28 -0700
Message-ID: <364299f40907091040v73e1dc3dm8c8eada4221abc7b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Compile failure with rt_sigaction on amd64
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jul 9, 2009 at 7:50 AM, naresh kamboju<naresh.kernel@gmail.com> wro=
te:
> On Tue, Jul 7, 2009 at 9:36 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
>> On Tue, Jul 7, 2009 at 5:46 AM, naresh kamboju<naresh.kernel@gmail.com> =
wrote:
>>> Hi Garrett Cooper,
>>>
>>> Thanks for your info.
>>>
>>>>Oops... looks like someone forgot __amd64__ / >__ia64__:
>>>
>>> yes.
>>> i forgot to add these ARCH.
>>> Because I am not having this Architecture at my end :-(
>>>
>>>>gcc -g -O2 -I../../include -g -Wall -I../../../../include >-Wall -O2 -W
>>>>rt_sigaction01.c -L../../../../lib -lltp -o rt_sigaction01
>>>>rt_sigaction01.c: In function 'set_handler':
>>>>rt_sigaction01.c:147: error: 'SIGSETSIZE' >undeclared .(first use in
>>>>this function)
>>>>rt_sigaction01.c:147: error: (Each undeclared >identifier is reported o=
nly once
>>>>rt_sigaction01.c:147: error: for each function it >appears in.)
>>>>make[4]: *** [rt_sigaction01] Error 1
>>>
>>>>I tried using sizeof(sigaction_t), but unfortunately the >results for
>>>>the testcase(s) on my system were always EINVAL. >This issue wasn't
>>>>present a few days ago...
>>>
>>>>Any ideas?
>>>
>>>
>>> I have made a patch to fix this issue please review the this temporary =
fix.
>>>
>>> In my previous mail I have stated that sigset size (size_t sigsetsize)
>>> will be different for Different ARCH. It is depending on
>>> _COMPAT_NSIG_WORDS Macro.
>>>
>>> We have to conform how its different with respect to ARCH and need to
>>> have a generic solution to fix this issue.
>>>
>>> I think its going to be an issue othere than __arm__ || __i386__ ||
>>> __powerpc__ || __amd64__ || __ia64__ and __mips__
>>>
>>> There are different ARCH are being used by our LTP developers.
>>>
>>> I=92ll investigate this issue and come back with generic Solution to
>>> support most of the ARCH.
>>>
>>>
>>> please refer this linux-2.6.30/include/linux/compat.h
>>>
>>> http://lxr.linux.no/linux+v2.6.30/include/linux/compat.h#L75
>>>
>>> #define _COMPAT_NSIG_WORDS (_COMPAT_NSIG / _COMPAT_NSIG_BPW)
>>>
>>> typedef struct {
>>> compat_sigset_word sig[_COMPAT_NSIG_WORDS];
>>> } compat_sigset_t;
>>>
>>> Your suggestions are welcome ... :)
>>>
>>>
>>> Best regards
>>> Naresh Kamboju
>>>
>>> Signed-off-by: Naresh Kamboju < naresh.kernel@gm... >
>>>
>>> diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
>>> b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
>>> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c 2009-07-07
>>> 16:58:11.000000000 +0530
>>> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c 2009-07-07
>>> 16:59:38.000000000 +0530
>>> @@ -59,7 +59,7 @@
>>> #define SIGSETSIZE 16
>>> #endif
>>>
>>> -#if defined __arm__ || __i386__ || __powerpc__
>>> +#if defined __arm__ || __i386__ || __powerpc__ || __amd64__ || __ia64__
>>> #define SIGSETSIZE 8
>>> #endif
>>>
>>> diff -Naurb a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
>>> b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
>>> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c 2009-07-07
>>> 16:58:11.000000000 +0530
>>> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c 2009-07-07
>>> 16:59:48.000000000 +0530
>>> @@ -55,7 +55,7 @@
>>> #define SIGSETSIZE 16
>>> #endif
>>>
>>> -#if defined __arm__ || __i386__ || __powerpc__
>>> +#if defined __arm__ || __i386__ || __powerpc__ || __amd64__ || __ia64__
>>> #define SIGSETSIZE 8
>>> #endif
>>
>> Interesting. I checked the kernel sources and it appears that __mips__
>> is the only odd man out.
>
> If you are sure about only MIPS is odd man out.
> Then it would be perfect patch to fix this issue.
>
> Subrata,
> Please review this patch and test at your end and conform with PASSED
> architectures and FAILED.
>
> If you found any issue please let me know.

Naresh,
    In retrospect the comment I wrote up about the calculation I made
could be a bit misleading... this one's better.

1. Fix compile issue across all platforms (like before)
2. Better comments on calculations =3D> less confusion =3D> happier
developers and users :).

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigact=
ion0
.c,v
retrieving revision 1.2
diff -u -r1.2 rt_sigaction01.c
--- testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c     6 Jul 2009 =
15:2
:06 -0000       1.2
+++ testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c     9 Jul 2009 =
17:3
:49 -0000
@@ -55,15 +55,25 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"

-#if defined __mips__
+/*
+ * For all but __mips__:
+ *
+ * _COMPAT_NSIG / _COMPAT_NSIG_BPW =3D=3D 2.
+ *
+ * For __mips__:
+ *
+ * _COMPAT_NSIG / _COMPAT_NSIG_BPW =3D=3D 4.
+ *
+ * See asm/compat.h under the kernel source for more details.
+ *
+ * Multiply that by a fudge factor of 4 and you have your SIGSETSIZE.
+ */
+#if defined (__mips__)
 #define SIGSETSIZE 16
-#endif
-
-#if defined __arm__ || __i386__ || __powerpc__
+#else
 #define SIGSETSIZE 8
 #endif

-
 /* Extern Global Variables */
 extern int Tst_count;           /* counter for tst_xxx routines.         */
 extern char *TESTDIR;           /* temporary dir created by tst_tmpdir() */
Index: testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/rt_sigaction/rt_sigact=
ion0
.c,v
retrieving revision 1.1
diff -u -r1.1 rt_sigaction02.c
--- testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c     6 Jul 2009 =
15:2
:06 -0000       1.1
+++ testcases/kernel/syscalls/rt_sigaction/rt_sigaction02.c     9 Jul 2009 =
17:3
:49 -0000
@@ -51,11 +51,22 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"

-#if defined __mips__
+/*
+ * For all but __mips__:
+ *
+ * _COMPAT_NSIG / _COMPAT_NSIG_BPW =3D=3D 2.
+ *
+ * For __mips__:
+ *
+ * _COMPAT_NSIG / _COMPAT_NSIG_BPW =3D=3D 4.
+ *
+ * See asm/compat.h under the kernel source for more details.
+ *
+ * Multiply that by a fudge factor of 4 and you have your SIGSETSIZE.
+ */
+#if defined (__mips__)
 #define SIGSETSIZE 16
-#endif
-
-#if defined __arm__ || __i386__ || __powerpc__
+#else
 #define SIGSETSIZE 8
 #endif

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
