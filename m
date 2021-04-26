From: sujiaxun <sujiaxun@uniontech.com>
Date: Mon, 26 Apr 2021 15:53:41 +0800
Subject: [LTP] [PATCH] Fix the 64-bit macro definition of mips
 architecture
In-Reply-To: <20210426070320.iow3avu2pq22qled@vireshk-i7>
References: <20210422072609.9938-1-sujiaxun@uniontech.com>
 <YIZSzNd9uK8kItYb@pevik> <20210426055556.dmcogdykez2ddxn3@vireshk-i7>
 <YIZa4Ph81LmkEkLZ@pevik> <20210426062357.i72js3urkoofvzcj@vireshk-i7>
 <f06db611-5024-78d6-07e9-36115889b7a7@uniontech.com>
 <20210426070320.iow3avu2pq22qled@vireshk-i7>
Message-ID: <827cdde8-18df-75b0-743c-7876704c2039@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 2021/4/26 ??3:03, Viresh Kumar wrote:
> On 26-04-21, 15:00, sujiaxun wrote:
>> uos@uos-PC:~$ echo |gcc -dM -E - | grep -i arch
>> #define _MIPS_ARCH "mips64r2"
>> #define _MIPS_ARCH_MIPS64R2 1
>> uos@uos-PC:~$ echo |gcc -dM -E - | grep -i mips64
>> #define _MIPS_ISA _MIPS_ISA_MIPS64
>> #define _MIPS_TUNE "mips64r2"
>> #define _MIPS_TUNE_MIPS64R2 1
>> #define _MIPS_ARCH "mips64r2"
>> #define _MIPS_ARCH_MIPS64R2 1
>> #define __mips64 1
>> uos@uos-PC:~$ uname  -m
>> mips64
>>
>> The mips architecture gcc has no built-in __arch64__, only __mips64
>> definitions. Of course, "__BITS_PER_LONG == 64" can also be used, but I
>> think it is better to use __mips64 in the mips architecture.
> 
> Hmm, I will rather try to do what the kernel source code does, i.e.
> use __BITS_PER_LONG here instead.
> 
I resubmitted a patch and changed "__arch64__" to "#if __BITS_PER_LONG 
== 64", the link is: 
https://patchwork.ozlabs.org/project/ltp/patch/20210426074812.27798-1-sujiaxun@uniontech.com 
/


