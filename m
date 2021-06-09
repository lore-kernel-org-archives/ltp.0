From: Vinay Kumar <vinay.m.engg@gmail.com>
Date: Wed, 9 Jun 2021 23:08:34 +0530
Subject: [LTP] [PATCH 1/7] getitimer02: Skipped EFAULT tests for libc
 variant.
In-Reply-To: <YL/Wf51Y6V5lRnkM@pevik>
References: <20210607104515.29838-1-vinay.m.engg@gmail.com>
 <YL/Wf51Y6V5lRnkM@pevik>
Message-ID: <CANUMPcW3jQR431JtVdTvnd8v8c4KRt8VWOrJOjC-SnekJn0oxA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Sent v2 patches for review with suggested corrections.

>> In the text after blank line I'd mention EFAULT skipped on raw syscall.
>> It'd would deserve to mention why.

Yes, added the reason in the commit log of each test case.

>> Also, as test it's quite simple, it'd be nice, if you first convert it to new
>> API and in second commit added test variants.

getitimer02.c, getrusage02.c and setitimer02.c are updated to the new API.
Then added test variants. Remaining test cases are already updated
with the new API.

>> During rewrite you should remove #if !defined(UCLINUX) check as getitimer() is
>> supported on uclibc-ng.

Removed the same.

Regards,
Vinay

On Wed, Jun 9, 2021 at 2:13 AM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Vinay,
>
> > Tested EFAULT cases only for "__NR_getitimer" syscall.
> Well, you added testing raw syscall via test variant.
> That's IMHO the most important thing to mention.
>
> In the text after blank line I'd mention EFAULT skipped on raw syscall.
> It'd would deserve to mention why.
>
> Also, as test it's quite simple, it'd be nice, if you first convert it to new
> API and in second commit added test variants.
> During rewrite you should remove #if !defined(UCLINUX) check as getitimer() is
> supported on uclibc-ng.
>
> This apply to whole patchset (some tests are already ported to new API).
>
> Kind regards,
> Petr
