Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NK1c6-0003z4-Tw
	for ltp-list@lists.sourceforge.net; Mon, 14 Dec 2009 03:28:46 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NK1c2-0000QZ-0e
	for ltp-list@lists.sourceforge.net; Mon, 14 Dec 2009 03:28:46 +0000
Date: Sun, 13 Dec 2009 22:28:33 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <909309289.267681260761313475.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2132484028.267281260760555748.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


----- "Garrett Cooper" <yanegomi@gmail.com> wrote:

> For whatever reason someone decided to be special on ppc64.. not sure
> why (maybe because ppc and ppc64 diverged in older kernels and
> converged in later ones?):
> 
> [root@localhost /]# egrep 'PTRACE_[GS]ETREGS'
> /scratch/fc4/kernel/include/asm-ppc64/ptrace.h 
> #define PPC_PTRACE_GETREGS	      0x99  /* Get GPRs 0 - 31 */
> #define PPC_PTRACE_SETREGS	      0x98  /* Set GPRs 0 - 31 */

As you see, there's no PTRACE_[GS]ETREGS on ppc64 machine in RHEL5
but PPC_PTRACE_[GS]ETREGS exists. I wonder whether the test will 
still work if we change PTRACE_[GS]ETREGS to PPC_PTRACE_[GS]ETREGS
in c codes.

I use kernel version 2.6.18-164.el5 in RHEL5U4.

> [root@localhost /]# egrep 'PTRACE_[GS]ETREGS'
> /scratch/fc7/kernel/include/asm-powerpc/ptrace.h 
> #define PPC_PTRACE_GETREGS	0x99	/* Get GPRs 0 - 31 */
> #define PPC_PTRACE_SETREGS	0x98	/* Set GPRs 0 - 31 */
> 
> A similar issue may exist for sparc64, but I doubt it:
> 
> [root@localhost /]# egrep 'PTRACE_[GS]ETREGS'
> /scratch/fc4/kernel/include/asm-sparc*/ptrace.h 
> /scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define
> PTRACE_GETREGS            12
> /scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define
> PTRACE_SETREGS            13
> /scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define
> PTRACE_GETREGS64	  22
> /scratch/fc4/kernel/include/asm-sparc64/ptrace.h:#define
> PTRACE_SETREGS64	  23
> /scratch/fc4/kernel/include/asm-sparc/ptrace.h:#define PTRACE_GETREGS 
>           12
> /scratch/fc4/kernel/include/asm-sparc/ptrace.h:#define PTRACE_SETREGS 
>           13
> 
> What kernel version are you using again?
> 
> Thanks,
> -Garrett

-- 
/-------------------------------------------\
| Name: Caspar Zhang                        |
| Position: Kernel Qualification Engineer   |
| IRC: czhang on #kernel-qe, #eng-china     |
| Phone: +86-10-6260-8150                   |
| Cellphone: +86-1381-073-0090              |
\-------------------------------------------/


------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
