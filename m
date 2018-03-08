From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Mar 2018 11:38:51 +0800
Subject: [LTP] [bug?] Access was denied by memory protection keys in
 execute-only address
In-Reply-To: <20180308004324.GK1060@ram.oc3035372033.ibm.com>
References: <CAEemH2f0LDqyR5AmUYv17OuBc5-UycckDPWgk46XU_ghQo4diw@mail.gmail.com>
 <20180308004324.GK1060@ram.oc3035372033.ibm.com>
Message-ID: <CAEemH2fTamDYsPWxs1ZB7LF1Uvhaz4GfyOFDLyN+oo+7z2+yOg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, Mar 8, 2018 at 8:43 AM, Ram Pai <linuxram@us.ibm.com> wrote:

> On Wed, Mar 07, 2018 at 04:09:06PM +0800, Li Wang wrote:
> >    Hi,
> >
> >    ltp/mprotect04[1] crashed by SEGV_PKUERR on ppc64(LPAR on P730, Power
> 8
> >    8247-22L) with kernel-v4.16.0-rc4.
> >    10000000-10020000 r-xp 00000000 fd:00 167223           mprotect04
> >    10020000-10030000 r--p 00010000 fd:00 167223           mprotect04
> >    10030000-10040000 rw-p 00020000 fd:00 167223           mprotect04
> >    1001a380000-1001a3b0000 rw-p 00000000 00:00 0          [heap]
> >    7fffa6c60000-7fffa6c80000 --xp 00000000 00:00 0 ​
> >    ​&exec_func = 0x10030170​
> >    ​&func = 0x7fffa6c60170​
> >
> >    ​While perform ​"(*func)();" we get the
> >    ​segmentation fault.
> >    ​
> >    ​strace log:​
> >    -------------------
> >    ​mprotect(0x7fffaed00000, 131072, PROT_EXEC) = 0
> >    rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
> >    --- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_PKUERR,
> >    si_addr=0x7fffaed00170} ---​
>
> Ran the same test on my machine. and did not encounter the bug.
>
> Can I get your kernel .config ?
>

​S​
ee the attachment.


> also is this a P7 LPAR or a P8 LPAR?  cat /proc/cpuinfo will help.
>

One is
​IBM LPAR on P730 {8231-E2B}​
, another is:
​IBM Power 8 8247-22L​



​# ./mprotect04
mprotect04    1  TPASS  :  test PROT_NONE for mprotect success
mprotect04    2  TFAIL  :  mprotect04.c:252: test PROT_EXEC for mprotect
failed​

​# cat /proc/cpuinfo
processor    : 0
cpu        : POWER8 (architected), altivec supported
clock        : 3425.000000MHz
revision    : 2.1 (pvr 004b 0201)

processor    : 1
cpu        : POWER8 (architected), altivec supported
clock        : 3425.000000MHz
revision    : 2.1 (pvr 004b 0201)

processor    : 2
cpu        : POWER8 (architected), altivec supported
clock        : 3425.000000MHz
revision    : 2.1 (pvr 004b 0201)

processor    : 3
cpu        : POWER8 (architected), altivec supported
clock        : 3425.000000MHz
revision    : 2.1 (pvr 004b 0201)

processor    : 4
cpu        : POWER8 (architected), altivec supported
clock        : 3425.000000MHz
revision    : 2.1 (pvr 004b 0201)

processor    : 5
cpu        : POWER8 (architected), altivec supported
clock        : 3425.000000MHz
revision    : 2.1 (pvr 004b 0201)

processor    : 6
cpu        : POWER8 (architected), altivec supported
clock        : 3425.000000MHz
revision    : 2.1 (pvr 004b 0201)

processor    : 7
cpu        : POWER8 (architected), altivec supported
clock        : 3425.000000MHz
revision    : 2.1 (pvr 004b 0201)

timebase    : 512000000
platform    : pSeries
model        : IBM,8247-22L
machine        : CHRP IBM,8247-22L
MMU        : Hash




-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180308/aec88dca/attachment-0001.html>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: config-4.16.0-rc3
Type: application/octet-stream
Size: 150740 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180308/aec88dca/attachment-0001.obj>
