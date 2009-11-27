Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NDx38-0001FE-31
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 09:23:34 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-3.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NDx2y-0000ii-2f
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 09:23:34 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 27 Nov 2009 18:23:11 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 27 Nov 2009 18:23:11 +0900
Message-ID: <000001ca6f43$3ec6ac20$bc540460$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] build failure in ia64
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Hi,

I ran "make" with ltp-2009-11-26.tar.gz.
Kernel release is 2.6.18-164.el5.
Architecture is ia64.

But it failed with following error message.
"make autotools" and "./configure" has been done before make.
I use "make 3.81", "autoconf 2.61", "automake 1.10.2", and "m4 1.4.7".

------------
make[4]: Entering directory
`/home/mitani/LTP/ltp-2009-11-26/testcases/kernel/controllers/
freezer'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
-I/home/mitani/LTP/ltp-2009-11-26/test
cases/kernel/include -I../../../../include -I../../../../include
-L../../../../lib  vfor
k.c   -lltp -o vfork
In file included from ../../syscalls/ptrace/ptrace.h:14,
                 from vfork.c:44:
/usr/include/sys/ptrace.h:127: error: array type has incomplete element type
In file included from ../../syscalls/ptrace/ptrace.h:22,
                 from vfork.c:44:
/usr/include/asm/ptrace.h:208: error: redefinition of 'struct
FU_pt_all_user_regs'
make[4]: *** [vfork] Error 1
make[4]: Leaving directory
`/home/mitani/LTP/ltp-2009-11-26/testcases/kernel/controllers/f
reezer'
------------

Similar failure continues from ltp-2009-11-17.tar.gz at the latest.
"ltp-2009-11-27.tar.gz" (today's version) seems to fail by another
new failure before these problems.
Perhaps, "ltp-2009-11-27.tar.gz" will fail by similar failure after
this "another new failure" solved, I think.

So I will report about "ltp-2009-11-26.tar.gz".


The problems are following two.
(1) Line 127 of "/usr/include/sys/ptrace.h" declares "array type has
    incomplete element type"

(2) Line 208 of "/usr/include/asm/ptrace.h" declares same structure as
    "/usr/include/sys/ptrace.h".


The files related to these problems are as follows:

 - ${LTPROOT}/testcases/kernel/controllers/freezer/vfork.c
 - ${LTPROOT}/testcases/kernel/syscalls/ptrace/ptrace.h
    It's added from ltp-2009-11-17.tar.gz at the latest.
    I call this file ".../ptrace/ptrace.h" afterward.
 - /usr/include/sys/ptrace.h
    I call this file ".../sys/ptrace.h" afterward.
 - /usr/include/asm/ptrace.h
    I call this file ".../asm/ptrace.h" afterward.


Follows show ".../ptrace/ptrace.h", ".../sys/ptrace.h" and
".../asm/ptrace.h".

".../ptrace/ptrace.h":
------------
/* Ordering matters. Do not move this code block below the #include's */
#ifdef __ia64__ /* what a pos */
# define ia64_fpreg FU_ia64_fpreg
# define pt_all_user_regs FU_pt_all_user_regs
#endif
#ifdef HAVE_SYS_PTRACE_H
# include <sys/ptrace.h>
#elif defined(HAVE_LINUX_PTRACE_H)
# include <linux/ptrace.h>
#endif
#ifdef HAVE_SYS_REG_H
# include <sys/reg.h>
#endif
#ifdef HAVE_ASM_PTRACE_H
# include <asm/ptrace.h>
#endif
#undef FU_ia64_fpreg
#undef FU_pt_all_user_regs
------------

".../sys/ptrace.h":
------------
struct pt_all_user_regs
  {
    unsigned long nat;
    unsigned long cr_iip;
    unsigned long cfm;
    unsigned long cr_ipsr;
    unsigned long pr;

    unsigned long gr[32];
    unsigned long br[8];
    unsigned long ar[128];
    struct ia64_fpreg fr[128];              ............ L.127
  };
------------

".../asm/ptrace.h":
------------
struct pt_all_user_regs {                   ............ L.208
        unsigned long nat;
        unsigned long cr_iip;
        unsigned long cfm;
        unsigned long cr_ipsr;
        unsigned long pr;

        unsigned long gr[32];
        unsigned long br[8];
        unsigned long ar[128];
        struct ia64_fpreg fr[128];
};
------------



I tried to avoid above "make" failure as follows:

Avoiding of (1) problem:

"# define ia64_fpreg FU_ia64_fpreg" definition of ".../ptrace/ptrace.h"
influences "struct ia64_fpreg fr[128];" of ".../sys/ptrace.h", I thought.
I searched "ia64_fpreg" for all LTP sources, but this structure name was
not found. I have no ideas why "FU_ia64_fpreg" was defined.

So I commented out "# define ia64_fpreg FU_ia64_fpreg". After that, 
this problem did not occur.


Avoiding of (2) problem:

If ".../sys/ptrace.h" and ".../asm/ptrace.h" are included at the same
time in ".../ptrace/ptrace.h", this probrem occures.
Probably, "HAVE_SYS_PTRACE_H" and "HAVE_ASM_PTRACE_H" become effective
at the same time.
I referred to "${LTPROOT}/include/config.h" and "${LTPROOT}/config.log",
and found both defined "1".
In "ltp-full-20090930.tgz", "vfork.c" didn't include ".../asm/ptrace.h"
but ".../sys/ptrace.h".

So I commented out "# include <asm/ptrace.h>" from ".../ptrace/ptrace.h".
After that, this problem did not occur in "vfork.c".

But after this, "${LTPROOT}/testcases/kernel/syscalls/ptrace/ptrace04.c"
failed. In "ptrace04.c", struct "pt_regs" is used, and it's declared in
".../asm/ptrace.h".

After examination, I understood that "vfork.c" and six source files
from "${LTPROOT}/testcases/kernel/syscalls/ptrace01.c" to ".../ptrace06.c"
include "../ptrace/ptrace.h", and they occur "redefinition" compile
failure without (2) revision of "../ptrace/ptrace.h".




May I have some questions?

(1) Why was "FU_ia64_fpreg" defined?
    I deleted this definition to let "make" succeed.
    But I'm worried whether this revision has a problem.


(2) I refer "${LTPROOT}/include/config.h" in my system. It was as follows:

------------
[...]
/* Define to 1 if you have the <asm/ptrace.h> header file. */
#define HAVE_ASM_PTRACE_H 1
[...]
/* Define to 1 if you have the <sys/ptrace.h> header file. */
#define HAVE_SYS_PTRACE_H 1
[...]
------------

    In this state, "redefinition" failure such as this time will 
    happen, I think. But I don't know what kind of revision should I do.



Regards--


-Tomonori Mitani



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
