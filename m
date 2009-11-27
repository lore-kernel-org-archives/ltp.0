Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NE9j4-0007fE-Tb
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 22:55:42 +0000
Received: from mail-px0-f174.google.com ([209.85.216.174])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NE9iy-0007bg-Ga
	for ltp-list@lists.sourceforge.net; Fri, 27 Nov 2009 22:55:42 +0000
Received: by pxi4 with SMTP id 4so1238501pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 27 Nov 2009 14:55:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca6f43$3ec6ac20$bc540460$@co.jp>
References: <000001ca6f43$3ec6ac20$bc540460$@co.jp>
Date: Fri, 27 Nov 2009 14:55:30 -0800
Message-ID: <364299f40911271455h792a91dudcedb1d29401b209@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

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
> /usr/include/sys/ptrace.h:127: error: array type has incomplete element t=
ype
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
