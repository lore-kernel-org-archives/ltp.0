From: Li Wang <liwang@redhat.com>
Date: Fri, 22 Feb 2019 11:13:06 +0800
Subject: [LTP] [PATCH v2] mprotect04: Support execute-only page access
	permissions
In-Reply-To: <CAE2F3rD-h0Hpu6o8ZM+ZQhcf=kX9hO1NCswP13B4kdLimQT=_A@mail.gmail.com>
References: <20190212000008.57085-1-danielmentz@google.com>
 <CAEemH2d+jAXjtv=AnQ=GFP4gm7Hu_9Lc32x4v2gSkw1JFc2boQ@mail.gmail.com>
 <CAE2F3rAEifdGzUaxOm9bxO_LAOrQc0gU6C-2zf-BPAdywgUC2g@mail.gmail.com>
 <CAEemH2dx8q9u2bSwrGE3Li72shOMtsQQECRT_MftOdUqcOPQzA@mail.gmail.com>
 <20190221150137.GA13320@fuggles.cambridge.arm.com>
 <CAE2F3rD-h0Hpu6o8ZM+ZQhcf=kX9hO1NCswP13B4kdLimQT=_A@mail.gmail.com>
Message-ID: <CAEemH2dh90-ev2wZXNY7smmNwfPkbkY7S3vTNqKVXh84M6mVQQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Feb 22, 2019 at 4:44 AM Daniel Mentz <danielmentz@google.com> wrote:

> On Thu, Feb 21, 2019 at 7:01 AM Will Deacon <will.deacon@arm.com> wrote:
>
>> On Wed, Feb 20, 2019 at 03:59:57PM +0800, Li Wang wrote:
>> > On Wed, Feb 20, 2019 at 8:21 AM Daniel Mentz <danielmentz@google.com>
>> wrote:
>> >     No, execute-only page access permissions don't need any special
>> >     configuration. They have been introduced by the following commit:
>> >
>> >     "arm64: Introduce execute-only page access permissions"
>> >
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
>> ?
>> >     id=cab15ce604e550020bb7115b779013b91bcdbc21
>> >
>> >     /proc//maps for my mprotect04 executable looks as follows:
>> >
>> >     6458f5e000-6458f62000 r--p 00000000 fd:06 11691
>>       /
>> >     data/local/tmp/mprotect04
>> >     6458f62000-6458f67000 --xp 00004000 fd:06 11691
>>       /
>> >     data/local/tmp/mprotect04
>> >     6458f67000-6458f6a000 rw-p 00009000 fd:06 11691
>>       /
>> >     data/local/tmp/mprotect04
>> >     6458f6a000-6458f6d000 rw-p 00000000 00:00 0
>> >     70c5cc0000-70c5d11000 ---p 00000000 00:00 0
>> >
>> >     The notable difference are the access permissions of the second VMA
>> which
>> >     are "--xp". In your case, the permissions were "r-xp", hence
>> reading was
>> >     allowed in addition to execution. I should also note that most other
>> >     binaries on my device like /system/bin/sh don't have the
>> execute-only
>> >     mapping "--xp". Instead, they only have an "r-xp" VMA like your
>> mprotect04.
>> >     In the end, I couldn't find out why there's a difference. Objdump
>> and
>> >     readelf both show that the respective segment is execute-only, but
>> it's
>> >     somehow still mapped readable and executable:
>> >
>> >
>> > Not sure if that's a issue or intentional in design, Cc'ing Deacon and
>> Catalin
>> > to have look.
>>
>> I suspect this depends on the flags that are emitted in the program header
>> by your compiler. What does objdump -p say for your binary?
>>
>
My situation is different with Daniel's, on my aarch64 platform with
upstream kernel-v5.0-rc7, mprotect04 binary code segment has "r-x" flag and
maped as "r-x" permission in VMA, but with the "execute-only page access
permissions" patch shouldn't it map with execute only permission?

# grep CONFIG_ARM64_UAO /boot/config-5.0.0-rc7
CONFIG_ARM64_UAO=y

# lscpu
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              32
On-line CPU(s) list: 0-31
Thread(s) per core:  1
Core(s) per socket:  32
Socket(s):           1
NUMA node(s):        1
Vendor ID:           APM
Model:               1
Model name:          X-Gene
Stepping:            0x3
CPU max MHz:         3000.0000
CPU min MHz:         375.0000
BogoMIPS:            100.00
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
NUMA node0 CPU(s):   0-31
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid

# gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W
-Wold-style-definition -D_FORTIFY_SOURCE=2 -I../../../../include
-I../../../../include -I../../../../include/old/   -L../../../../lib
mprotect04.c   -lltp -o mprotect04

# objdump -p mprotect04

mprotect04:     file format elf64-littleaarch64

Program Header:
    PHDR off    0x0000000000000040 vaddr 0x0000000000400040 paddr
0x0000000000400040 align 2**3
         filesz 0x00000000000001f8 memsz 0x00000000000001f8 flags r--
  INTERP off    0x0000000000000238 vaddr 0x0000000000400238 paddr
0x0000000000400238 align 2**0
         filesz 0x000000000000001b memsz 0x000000000000001b flags r--
    LOAD off    0x0000000000000000 vaddr 0x0000000000400000 paddr
0x0000000000400000 align 2**16
         filesz 0x000000000001a98c memsz 0x000000000001a98c flags r-x
    LOAD off    0x000000000001fde8 vaddr 0x000000000042fde8 paddr
0x000000000042fde8 align 2**16
         filesz 0x00000000000007fc memsz 0x0000000000003858 flags rw-
 DYNAMIC off    0x000000000001fdf8 vaddr 0x000000000042fdf8 paddr
0x000000000042fdf8 align 2**3
         filesz 0x00000000000001d0 memsz 0x00000000000001d0 flags rw-
    NOTE off    0x0000000000000254 vaddr 0x0000000000400254 paddr
0x0000000000400254 align 2**2
         filesz 0x0000000000000044 memsz 0x0000000000000044 flags r--
EH_FRAME off    0x00000000000171b0 vaddr 0x00000000004171b0 paddr
0x00000000004171b0 align 2**2
         filesz 0x00000000000006d4 memsz 0x00000000000006d4 flags r--
   STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr
0x0000000000000000 align 2**4
         filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
   RELRO off    0x000000000001fde8 vaddr 0x000000000042fde8 paddr
0x000000000042fde8 align 2**0
         filesz 0x0000000000000218 memsz 0x0000000000000218 flags r--

>
>>
> Not sure if this question was meant for Li or me.
> On my system, the objdump output looks as follows:
>
> $ objdump -p out/target/product/crosshatch/system/bin/sh
>
> out/target/product/crosshatch/system/bin/sh:     file format
> elf64-littleaarch64
>
> Program Header:
>     PHDR off    0x0000000000000040 vaddr 0x0000000000000040 paddr
> 0x0000000000000040 align 2**3
>          filesz 0x0000000000000230 memsz 0x0000000000000230 flags r--
>   INTERP off    0x0000000000000270 vaddr 0x0000000000000270 paddr
> 0x0000000000000270 align 2**0
>          filesz 0x0000000000000015 memsz 0x0000000000000015 flags r--
>     LOAD off    0x0000000000000000 vaddr 0x0000000000000000 paddr
> 0x0000000000000000 align 2**12
>          filesz 0x0000000000009f94 memsz 0x0000000000009f94 flags r--
>     LOAD off    0x000000000000a000 vaddr 0x000000000000a000 paddr
> 0x000000000000a000 align 2**12
>          filesz 0x000000000003a450 memsz 0x000000000003a450 flags --x
>     LOAD off    0x0000000000045000 vaddr 0x0000000000045000 paddr
> 0x0000000000045000 align 2**12
>          filesz 0x00000000000025f0 memsz 0x0000000000004cc8 flags rw-
>  DYNAMIC off    0x0000000000046e80 vaddr 0x0000000000046e80 paddr
> 0x0000000000046e80 align 2**3
>          filesz 0x0000000000000200 memsz 0x0000000000000200 flags rw-
>    RELRO off    0x0000000000046000 vaddr 0x0000000000046000 paddr
> 0x0000000000046000 align 2**0
>          filesz 0x00000000000015f0 memsz 0x0000000000002000 flags r--
> EH_FRAME off    0x0000000000005498 vaddr 0x0000000000005498 paddr
> 0x0000000000005498 align 2**2
>          filesz 0x0000000000000d64 memsz 0x0000000000000d64 flags r--
>    STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr
> 0x0000000000000000 align 2**0
>          filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
>     NOTE off    0x0000000000000288 vaddr 0x0000000000000288 paddr
> 0x0000000000000288 align 2**2
>          filesz 0x0000000000000038 memsz 0x0000000000000038 flags r--
>
> The second "LOAD" segment is defined with "flags --x". After looking at
> the kernel source file fs/binfmt_elf.c, my understanding is that this
> should translate into a VMA that is mapped execute-only. However, when
> looking at /proc//maps, the corresponding VMA is mapped "read and execute".
> I couldn't find out why there's a discrepancy. A different binary i.e.
> mprotect04 looked similar in "objdump -p", but its code segment got indeed
> mapped execute-only. I currently don't have the objdump output for that
> binary, but I can get it if needed. To conclude, I noticed that ELF
> segments marked as "--x" are sometimes mapped execute-only and sometimes
> read-and-execute.
> We are using an Android kernel based on Linux 4.9.153
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190222/7981f1f0/attachment-0001.html>
