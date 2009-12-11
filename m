Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NJFHF-0001ne-Kv
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 23:52:01 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NJFH9-00082W-5c
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 23:52:01 +0000
Received: by pwj11 with SMTP id 11so505682pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Fri, 11 Dec 2009 15:51:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <EC76AAFC-5188-437C-BC62-9CCAFD521BA7@gmail.com>
References: <1808828661.200561260496566142.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<EC76AAFC-5188-437C-BC62-9CCAFD521BA7@gmail.com>
Date: Fri, 11 Dec 2009 15:51:49 -0800
Message-ID: <364299f40912111551x4959d4e7y2beef5cfbc1d27b5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH]fix compile error on ppc64 in RHEL5
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Dec 11, 2009 at 6:22 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Dec 10, 2009, at 5:56 PM, Caspar Zhang wrote:
>
>>
>> ----- "Subrata Modak" <subrata@linux.vnet.ibm.com> wrote:
>>
>>> Hi Caspar,
>>>
>>> I just have 1 question below:
>>>
>>> On Wed, 2009-12-09 at 21:12 -0500, Caspar Zhang wrote:
>>>> Hi all,
>>>>
>>>> When I compile ltp-full-20091130 on ppc64 machine which system is
>>>> RHEL5(kernel 2.6.18), I met compile error as follows:
>>>>
>>>> [...]
>>>> ptrace04.c: In function =91compare_registers=92:
>>>> ptrace04.c:59: error: =91PTRACE_GETREGS=92 undeclared (first use in
>>> this
>>>> function)
>>>> ptrace04.c:59: error: (Each undeclared identifier is reported only
>>>> once
>>>> ptrace04.c:59: error: for each function it appears in.)
>>>> make[5]: *** [ptrace04] Error 1
>>>> [...]
>>>>
>>>> It seems like there's no PTRACE_GETREGS in
>>> /usr/include/asm/ptrace.h
>>>> in old kernels, so I copy the definitions from new version of the
>>>> head file and my ltp on ppc64, RHEL5 works.
>>>
>>> Are these nos. similar across all archs ? If they are specific only
>>> to
>>> PPC, you can then add the following 2 more lines to your patch:
>>>
>>>>
>>>> Thanks,
>>>> Caspar
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> differences
>>>> between files
>>>> attachment
>>>> (rhel5-ppc-PTRACE_GETREGS-compile-err.patch)
>>>>
>>>> diff --git a/testcases/kernel/syscalls/ptrace/ptrace.h
>>>> b/testcases/kernel/syscalls/ptrace/ptrace.h
>>>> index a0d2708..e3fcbb2 100644
>>>> --- a/testcases/kernel/syscalls/ptrace/ptrace.h
>>>> +++ b/testcases/kernel/syscalls/ptrace/ptrace.h
>>>> @@ -37,4 +37,27 @@ typedef struct user_regs_struct ptrace_regs;
>>>> #undef HAVE_STRUCT_PTRACE_REGS
>>>> #endif
>>>>
>>>> +/* old kernel doesn't have PTRACE_GETREGS on ppc64 */
>>>> +/* (new) PTRACE requests using the same numbers as x86 and the
>>> same
>>>> + * argument ordering. Additionally, they support more registers
>>> too
>>>> + */
>>>
>>> #if defined(powerpc) || defined(__powerpc__) || defined(__ppc__) ||
>>> defined (__PPC__)
>>
>> Ah, yes. That sounds reasonable, thant you!
>
> For whatever reason someone decided to be special on ppc64.. not sure why=
 (maybe because ppc and ppc64 diverged in older kernels and converged in la=
ter ones?):
>
> [root@localhost /]# egrep 'PTRACE_[GS]ETREGS' /scratch/fc4/kernel/include=
/asm-ppc64/ptrace.h
> #define PPC_PTRACE_GETREGS =A0 =A0 =A0 =A0 =A0 =A00x99 =A0/* Get GPRs 0 -=
 31 */
> #define PPC_PTRACE_SETREGS =A0 =A0 =A0 =A0 =A0 =A00x98 =A0/* Set GPRs 0 -=
 31 */
>
> [root@localhost /]# egrep 'PTRACE_[GS]ETREGS' /scratch/fc7/kernel/include=
/asm-powerpc/ptrace.h
> #define PPC_PTRACE_GETREGS =A0 =A0 =A00x99 =A0 =A0/* Get GPRs 0 - 31 */
> #define PPC_PTRACE_SETREGS =A0 =A0 =A00x98 =A0 =A0/* Set GPRs 0 - 31 */
>
> A similar issue may exist for sparc64, but I doubt it:
>
> [root@localhost /]# egrep 'PTRACE_[GS]ETREGS' /scratch/fc4/kernel/include=
/asm-sparc*/ptrace.h
> /scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define PTRACE_GETREGS =
=A0 =A0 =A0 =A0 =A0 =A012
> /scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define PTRACE_SETREGS =
=A0 =A0 =A0 =A0 =A0 =A013
> /scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define PTRACE_GETREGS64=
 =A0 =A0 =A0 =A0 22
> /scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define PTRACE_SETREGS64=
 =A0 =A0 =A0 =A0 23
> /scratch/fc4/kernel/include/asm-sparc/ptrace.h:#define PTRACE_GETREGS =A0=
 =A0 =A0 =A0 =A0 =A012
> /scratch/fc4/kernel/include/asm-sparc/ptrace.h:#define PTRACE_SETREGS =A0=
 =A0 =A0 =A0 =A0 =A013
>
> What kernel version are you using again?

    If the new version from CVS doesn't compile, your build tree or
compile options are most likely not properly setup:

[garrcoop@sjc-lds-265 /nobackup/garrcoop/main]$ file
contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace0*
contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace01: ELF
64-bit MSB executable, cisco 7500, version 1 (SYSV), for GNU/Linux
2.6.4, dynamically linked (uses shared libs), not stripped
contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace02: ELF
64-bit MSB executable, cisco 7500, version 1 (SYSV), for GNU/Linux
2.6.4, dynamically linked (uses shared libs), not stripped
contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace03: ELF
64-bit MSB executable, cisco 7500, version 1 (SYSV), for GNU/Linux
2.6.4, dynamically linked (uses shared libs), not stripped
contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace04: ELF
64-bit MSB executable, cisco 7500, version 1 (SYSV), for GNU/Linux
2.6.4, dynamically linked (uses shared libs), not stripped
contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace05: ELF
64-bit MSB executable, cisco 7500, version 1 (SYSV), for GNU/Linux
2.6.4, dynamically linked (uses shared libs), not stripped

    This is glibc 2.3.4 with kernel version 2.6.24. This was done with
a cross-compile toolchain from work.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
