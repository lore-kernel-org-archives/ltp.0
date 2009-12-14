Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1NK1g7-0000NQ-3w
	for ltp-list@lists.sourceforge.net; Mon, 14 Dec 2009 03:32:55 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NK1g2-0000Ik-8k
	for ltp-list@lists.sourceforge.net; Mon, 14 Dec 2009 03:32:55 +0000
Date: Sun, 13 Dec 2009 22:32:29 -0500 (EST)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1371765689.267861260761549881.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <754596231.267801260761514383.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
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

> 
>     If the new version from CVS doesn't compile, your build tree or
> compile options are most likely not properly setup:
> 
> [garrcoop@sjc-lds-265 /nobackup/garrcoop/main]$ file
> contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace0*
> contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace01: ELF
> 64-bit MSB executable, cisco 7500, version 1 (SYSV), for GNU/Linux
> 2.6.4, dynamically linked (uses shared libs), not stripped
> contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace02: ELF
> 64-bit MSB executable, cisco 7500, version 1 (SYSV), for GNU/Linux
> 2.6.4, dynamically linked (uses shared libs), not stripped
> contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace03: ELF
> 64-bit MSB executable, cisco 7500, version 1 (SYSV), for GNU/Linux
> 2.6.4, dynamically linked (uses shared libs), not stripped
> contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace04: ELF
> 64-bit MSB executable, cisco 7500, version 1 (SYSV), for GNU/Linux
> 2.6.4, dynamically linked (uses shared libs), not stripped
> contrib/ltp/obj-ppc64/testcases/kernel/syscalls/ptrace/ptrace05: ELF
> 64-bit MSB executable, cisco 7500, version 1 (SYSV), for GNU/Linux
> 2.6.4, dynamically linked (uses shared libs), not stripped
> 
>     This is glibc 2.3.4 with kernel version 2.6.24. This was done
> with
> a cross-compile toolchain from work.

The latest CVS version can't finish compiling either. The kernel version
on RHEL5 is 2.6.18, I think that's the problem. 

Thanks,
Caspar


------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
