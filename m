From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 3 Sep 2021 06:33:08 +0200
Subject: [LTP] [PATCH] syscalls/aarch64: Remove 32 bit only syscalls
In-Reply-To: <CAK8P3a3jH=4gq7gg64E-L158d8QZCpPjEaKBZiEY+mE+jN61Fw@mail.gmail.com>
References: <20210902093655.6104-1-lkml@jv-coder.de>
 <20210902094219.xy73hs5ccafkrysr@vireshk-i7>
 <CAK8P3a3jH=4gq7gg64E-L158d8QZCpPjEaKBZiEY+mE+jN61Fw@mail.gmail.com>
Message-ID: <84a0c4aa-4faf-4271-36c4-5570f8c3a004@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Arnd,

On 9/2/2021 8:32 PM, Arnd Bergmann wrote:
>
>>> I am not 100% sure, how the syscall table for aarch64 is generated.
>>> There are also compat version for some of the 32 bit only 64 bit syscalls,
>>> but I think they are only available, when running an 32 bit arm application.
> The syscall table for aarch64 is generated from the kernel's
> include/uapi/asm-generic/unistd.h, which has a number of #ifdefs in
> it. A lot of these are disabled on aarch64 since they refer to older or
> 32-bit-only calls.
>
> https://marcin.juszkiewicz.com.pl/download/tables/syscalls.html has a table
> with the correct set of syscalls for each architecture, and scripts to generate
> them from both the old asm-generic/unistd.h method (now only still used on
> modern architectures) and the newer syscall.tbl format (used on older
> architectures)
Thanks for this explanation, I already found this site, but wasn't sure 
if it is "correct".
>
> It would be good to finally convert asm-generic/unistd.h to the new format
> in order to automatically generate tables like the one used by ltp. In the
> meantime, please double-check all architectures against Marcin's tables.
> The same problem likely also exists elsewhere, e.g. for rv64.

@all
After Arnd's explanation, I guess this patch is correct and can be merged?
Other architectures and the remaining syscalls should be checked as well.
Maybe we can integrate Marcin's tool for extraction into ltp?
See: https://github.com/hrw/syscalls-table

Joerg
