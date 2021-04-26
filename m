From: sujiaxun <sujiaxun@uniontech.com>
Date: Mon, 26 Apr 2021 15:00:26 +0800
Subject: [LTP] [PATCH] Fix the 64-bit macro definition of mips
 architecture
In-Reply-To: <20210426062357.i72js3urkoofvzcj@vireshk-i7>
References: <20210422072609.9938-1-sujiaxun@uniontech.com>
 <YIZSzNd9uK8kItYb@pevik> <20210426055556.dmcogdykez2ddxn3@vireshk-i7>
 <YIZa4Ph81LmkEkLZ@pevik> <20210426062357.i72js3urkoofvzcj@vireshk-i7>
Message-ID: <f06db611-5024-78d6-07e9-36115889b7a7@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 2021/4/26 ??2:23, Viresh Kumar wrote:
> On 26-04-21, 08:17, Petr Vorel wrote:
>> Hi Viresh,
>>
>> ...
>>>>> -#if defined(__arch64__)
>>>>> +#if defined(__mips64)
>>>> So __arch64__ is not defined for mips 64 bit? (as it's defined for sparc 64bit?)
>>>> __mips64 is obviously correct and better readable, but is it really required?
>>
>>> I am not sure what you meant by "is it really required?" The #ifdef hackery here
>>> ? It is as can be seen in include/uapi/asm-generic/shmbuf.h in Linux source.
>> I mean if #if defined(__mips__) && defined(__arch64__) detect 64bit mips
>> the patch would not be needed (although IMHO __mips64 is more descriptive than
>> __arch64__, for which you need to search for which architecture it was defined).
> 
> Ahh, right.
> 
> Actually the kernel has this instead:
> 
> #if __BITS_PER_LONG == 64
> 
>> But I'm not sure myself if __arch64__ is defined for mips 64bit.
> 
> Neither do I.
> 
uos@uos-PC:~$ echo |gcc -dM -E - | grep -i arch
#define _MIPS_ARCH "mips64r2"
#define _MIPS_ARCH_MIPS64R2 1
uos@uos-PC:~$ echo |gcc -dM -E - | grep -i mips64
#define _MIPS_ISA _MIPS_ISA_MIPS64
#define _MIPS_TUNE "mips64r2"
#define _MIPS_TUNE_MIPS64R2 1
#define _MIPS_ARCH "mips64r2"
#define _MIPS_ARCH_MIPS64R2 1
#define __mips64 1
uos@uos-PC:~$ uname  -m
mips64

The mips architecture gcc has no built-in __arch64__, only __mips64 
definitions. Of course, "__BITS_PER_LONG == 64" can also be used, but I 
think it is better to use __mips64 in the mips architecture.




