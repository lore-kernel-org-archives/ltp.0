From: He Zhe <zhe.he@windriver.com>
Date: Fri, 2 Apr 2021 12:38:43 +0800
Subject: [LTP] [PATCH] bugfix for ssetmask01.c
In-Reply-To: <YGVkS23e+/eytuEn@pevik>
References: <20210330021830.17402-1-zhanglianjie@uniontech.com>
 <YGVkS23e+/eytuEn@pevik>
Message-ID: <8927deb1-a21e-637e-a355-4f25ba027a51@windriver.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 4/1/21 2:12 PM, Petr Vorel wrote:
> Hi,
>
>> mips architecture syscall(69) __NR_ssetmask not supported on your arch.
> nit: "mips_o32: Fix __NR_s{g,s}etmask" for bug title would be more descriptive
> than "bugfix for ssetmask01.c". And then in text mention ssetmask01.c.
>
>> +++ b/include/lapi/syscalls/mips_o32.in
>> @@ -66,8 +66,8 @@ getppid 64
>>  getpgrp 65
>>  setsid 66
>>  sigaction 67
>> -sgetmask 68
>> -ssetmask 69
>> +sgetmask 4068
>> +ssetmask 4069
> But more important: I guess you're right because we don't add any offset to the
> numbers. But IMHO all numbers are wrong, all mips files should contain offset
> (01e4dc222 was wrong). mips_o32.in should be offset 4000, mips_n32.in 6000 and
> mips_n64.in 5000 (comparing scall32-o32.S, scall64-64.S, scall64-n32.S in
> arch/mips/kernel in kernel and mips{,n32,64}/bits/syscall.h.in in musl).

Petr is correct. I probably missed interpreting the offsets for each sub-arch.
Sorry for the inconvenience. I'll send a patch to correct this later.

Thanks,
Zhe

>
> Kind regards,
> Petr

