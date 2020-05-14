From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 14 May 2020 22:27:55 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
In-Reply-To: <20200514141454.GB17718@dell5510>
References: <20200513012626.1571-1-yangx.jy@cn.fujitsu.com>
 <5EBB5B3D.4020302@cn.fujitsu.com> <20200513092028.GA4598@dell5510>
 <5EBBCA12.5020901@cn.fujitsu.com> <20200513103032.GA18763@dell5510>
 <20200514073701.GA9562@dell5510> <5EBD12D9.70708@cn.fujitsu.com>
 <20200514141454.GB17718@dell5510>
Message-ID: <5EBD556B.4050406@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/5/14 22:14, Petr Vorel wrote:
> Hi Yang,
>
>>> To be honest I like this approach, because 1) it defines when new syscall was
>>> backported
>
>> Hmm, the reason seems a little weak, it can be done by adding a comment(e.g.
>> "the syscall is introduced since v5.6.0").
> Sure, that would work as well.
>
>> 2) if there is really problem that some functionality was removed, we
>>> can always handle it. But IMHO that's going to be rare (btrfs removed in RHEL 8
>>> is IMHO because RHEL does not want to support it, but that would not happen for
>>> syscalls).
>
>> Without the rare situation, I also think tst_syscall() is enough to check
>> the support of syscall.
> Well, nothing that much important, but I'd like to hear the opinion of
> other maintainers. BTW We now concentrate on pre-release fixes.
Hi Petr,

Sure.

>
>>> I'd also like to be consistent how we handle these new syscalls.
>> Agreed.
>
>> I also think if we can implement common func(e.g.
>> syscall_supported_by_kernel()).
> Sure, feel free to send a patch (could be a macro).

OK, I will send a patch after the release.

Best Regards,
Xiao Yang
>
>
> Kind regards,
> Petr
>
>
> .
>



