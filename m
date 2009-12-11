Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NJ6OB-0001YP-0n
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 14:22:35 +0000
Received: from mail-gx0-f224.google.com ([209.85.217.224])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NJ6O5-0004g7-Kl
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 14:22:35 +0000
Received: by gxk24 with SMTP id 24so1032511gxk.6
	for <ltp-list@lists.sourceforge.net>;
	Fri, 11 Dec 2009 06:22:24 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1808828661.200561260496566142.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Fri, 11 Dec 2009 06:22:21 -0800
Message-Id: <EC76AAFC-5188-437C-BC62-9CCAFD521BA7@gmail.com>
References: <1808828661.200561260496566142.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
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

On Dec 10, 2009, at 5:56 PM, Caspar Zhang wrote:

> =

> ----- "Subrata Modak" <subrata@linux.vnet.ibm.com> wrote:
> =

>> Hi Caspar,
>> =

>> I just have 1 question below:
>> =

>> On Wed, 2009-12-09 at 21:12 -0500, Caspar Zhang wrote:
>>> Hi all,
>>> =

>>> When I compile ltp-full-20091130 on ppc64 machine which system is
>>> RHEL5(kernel 2.6.18), I met compile error as follows:
>>> =

>>> [...]
>>> ptrace04.c: In function =91compare_registers=92:
>>> ptrace04.c:59: error: =91PTRACE_GETREGS=92 undeclared (first use in
>> this
>>> function)
>>> ptrace04.c:59: error: (Each undeclared identifier is reported only
>>> once
>>> ptrace04.c:59: error: for each function it appears in.)
>>> make[5]: *** [ptrace04] Error 1
>>> [...]
>>> =

>>> It seems like there's no PTRACE_GETREGS in
>> /usr/include/asm/ptrace.h
>>> in old kernels, so I copy the definitions from new version of the
>>> head file and my ltp on ppc64, RHEL5 works.
>> =

>> Are these nos. similar across all archs ? If they are specific only
>> to
>> PPC, you can then add the following 2 more lines to your patch:
>> =

>>> =

>>> Thanks,
>>> Caspar =

>>> =

>>> =

>>> =

>>> =

>>> =

>>> =

>>> differences
>>> between files
>>> attachment
>>> (rhel5-ppc-PTRACE_GETREGS-compile-err.patch)
>>> =

>>> diff --git a/testcases/kernel/syscalls/ptrace/ptrace.h
>>> b/testcases/kernel/syscalls/ptrace/ptrace.h
>>> index a0d2708..e3fcbb2 100644
>>> --- a/testcases/kernel/syscalls/ptrace/ptrace.h
>>> +++ b/testcases/kernel/syscalls/ptrace/ptrace.h
>>> @@ -37,4 +37,27 @@ typedef struct user_regs_struct ptrace_regs;
>>> #undef HAVE_STRUCT_PTRACE_REGS
>>> #endif
>>> =

>>> +/* old kernel doesn't have PTRACE_GETREGS on ppc64 */
>>> +/* (new) PTRACE requests using the same numbers as x86 and the
>> same
>>> + * argument ordering. Additionally, they support more registers
>> too
>>> + */
>> =

>> #if defined(powerpc) || defined(__powerpc__) || defined(__ppc__) ||
>> defined (__PPC__)
> =

> Ah, yes. That sounds reasonable, thant you!

For whatever reason someone decided to be special on ppc64.. not sure why (=
maybe because ppc and ppc64 diverged in older kernels and converged in late=
r ones?):

[root@localhost /]# egrep 'PTRACE_[GS]ETREGS' /scratch/fc4/kernel/include/a=
sm-ppc64/ptrace.h =

#define PPC_PTRACE_GETREGS	      0x99  /* Get GPRs 0 - 31 */
#define PPC_PTRACE_SETREGS	      0x98  /* Set GPRs 0 - 31 */

[root@localhost /]# egrep 'PTRACE_[GS]ETREGS' /scratch/fc7/kernel/include/a=
sm-powerpc/ptrace.h =

#define PPC_PTRACE_GETREGS	0x99	/* Get GPRs 0 - 31 */
#define PPC_PTRACE_SETREGS	0x98	/* Set GPRs 0 - 31 */

A similar issue may exist for sparc64, but I doubt it:

[root@localhost /]# egrep 'PTRACE_[GS]ETREGS' /scratch/fc4/kernel/include/a=
sm-sparc*/ptrace.h =

/scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define PTRACE_GETREGS    =
        12
/scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define PTRACE_SETREGS    =
        13
/scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define PTRACE_GETREGS64	 =
 22
/scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define PTRACE_SETREGS64	 =
 23
/scratch/fc4/kernel/include/asm-sparc/ptrace.h:#define PTRACE_GETREGS      =
      12
/scratch/fc4/kernel/include/asm-sparc/ptrace.h:#define PTRACE_SETREGS      =
      13

What kernel version are you using again?

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
