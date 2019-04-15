From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 15 Apr 2019 13:39:15 +0800
Subject: [LTP] [PATCH] syscalls/getcpu: Add libc sched_getcpu()
 detection && fix compiler errors
In-Reply-To: <20190412114632.GD28648@haruka.lan>
References: <1555052585-2293-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190412094304.GB28648@haruka.lan> <5CB06C84.8030900@cn.fujitsu.com>
 <20190412114632.GD28648@haruka.lan>
Message-ID: <5CB41903.5010203@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/4/12 19:46, Cyril Hrubis wrote:

> Hi!
>>>> -#if defined(__i386__)
>>>> -	return syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
>>>> +#ifndef HAVE_SCHED_GETCPU
>>>> +	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
>>>>    #else
>>>>    	*cpu_id = sched_getcpu();
>>>>    #endif
>>> So when __NR_getcpu is not implemented we end up with tst_brk(TCONF,
>>> ...) called from the tst_syscall, right? Since AFAIK the getcpu syscall
>>> is not implemented on all architectures...
>> Yes. It will report TCONF if __NR_getcpu is not implemented.
>>
>>   From getcpu manpage, it is not implemented on all architectures as you
>> said, I think we can remove sched_getcpu and use __NR_getcpu directly.
> Reading the manual pages I think it's correct to fall back to
> sched_getcpu() since as far as I can tell platforms that don't support
> getcpu syscall have implemented the functionality as vDSO. So unless we
> implement vDSO variant of getcpu we have to rely on sched_getcpu().
>
Hi cyril

    Reading the sched_getcpu manpage,I mistakenly think the sched_getcpu uses
    the getcpu syscall diretly.|  |Actually|sched_getcpu uses VDSO getcpu() syscall
    since glibc 2.22. Thanks for you explanation.|



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190415/5499b512/attachment.html>
