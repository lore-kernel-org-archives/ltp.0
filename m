From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Apr 2019 13:46:32 +0200
Subject: [LTP] [PATCH] syscalls/getcpu: Add libc sched_getcpu()
 detection && fix compiler errors
In-Reply-To: <5CB06C84.8030900@cn.fujitsu.com>
References: <1555052585-2293-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190412094304.GB28648@haruka.lan>
 <5CB06C84.8030900@cn.fujitsu.com>
Message-ID: <20190412114632.GD28648@haruka.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> -#if defined(__i386__)
> >> -	return syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
> >> +#ifndef HAVE_SCHED_GETCPU
> >> +	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
> >>   #else
> >>   	*cpu_id = sched_getcpu();
> >>   #endif
> > So when __NR_getcpu is not implemented we end up with tst_brk(TCONF,
> > ...) called from the tst_syscall, right? Since AFAIK the getcpu syscall
> > is not implemented on all architectures...
> Yes. It will report TCONF if __NR_getcpu is not implemented.
> 
>  From getcpu manpage, it is not implemented on all architectures as you
> said, I think we can remove sched_getcpu and use __NR_getcpu directly.

Reading the manual pages I think it's correct to fall back to
sched_getcpu() since as far as I can tell platforms that don't support
getcpu syscall have implemented the functionality as vDSO. So unless we
implement vDSO variant of getcpu we have to rely on sched_getcpu().

-- 
Cyril Hrubis
chrubis@suse.cz
