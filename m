From: Will Deacon <will.deacon@arm.com>
Date: Thu, 21 Feb 2019 15:01:37 +0000
Subject: [LTP] [PATCH v2] mprotect04: Support execute-only page access
 permissions
In-Reply-To: <CAEemH2dx8q9u2bSwrGE3Li72shOMtsQQECRT_MftOdUqcOPQzA@mail.gmail.com>
References: <20190212000008.57085-1-danielmentz@google.com>
 <CAEemH2d+jAXjtv=AnQ=GFP4gm7Hu_9Lc32x4v2gSkw1JFc2boQ@mail.gmail.com>
 <CAE2F3rAEifdGzUaxOm9bxO_LAOrQc0gU6C-2zf-BPAdywgUC2g@mail.gmail.com>
 <CAEemH2dx8q9u2bSwrGE3Li72shOMtsQQECRT_MftOdUqcOPQzA@mail.gmail.com>
Message-ID: <20190221150137.GA13320@fuggles.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Feb 20, 2019 at 03:59:57PM +0800, Li Wang wrote:
> On Wed, Feb 20, 2019 at 8:21 AM Daniel Mentz <danielmentz@google.com> wrote:
>     No, execute-only page access permissions don't need any special
>     configuration. They have been introduced by the following commit:
> 
>     "arm64: Introduce execute-only page access permissions"
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?
>     id=cab15ce604e550020bb7115b779013b91bcdbc21
> 
>     /proc//maps for my mprotect04 executable looks as follows:
> 
>     6458f5e000-6458f62000 r--p 00000000 fd:06 11691                          /
>     data/local/tmp/mprotect04
>     6458f62000-6458f67000 --xp 00004000 fd:06 11691                          /
>     data/local/tmp/mprotect04
>     6458f67000-6458f6a000 rw-p 00009000 fd:06 11691                          /
>     data/local/tmp/mprotect04
>     6458f6a000-6458f6d000 rw-p 00000000 00:00 0 
>     70c5cc0000-70c5d11000 ---p 00000000 00:00 0 
> 
>     The notable difference are the access permissions of the second VMA which
>     are "--xp". In your case, the permissions were "r-xp", hence reading was
>     allowed in addition to execution. I should also note that most other
>     binaries on my device like /system/bin/sh don't have the execute-only
>     mapping "--xp". Instead, they only have an "r-xp" VMA like your mprotect04.
>     In the end, I couldn't find out why there's a difference. Objdump and
>     readelf both show that the respective segment is execute-only, but it's
>     somehow still mapped readable and executable:
> 
> 
> Not sure if that's a issue or intentional in design, Cc'ing Deacon and Catalin
> to have look.

I suspect this depends on the flags that are emitted in the program header
by your compiler. What does objdump -p say for your binary?

Will
