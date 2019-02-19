From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Feb 2019 12:14:00 +0530
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <5C667060.7020405@cn.fujitsu.com>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
 <5C667060.7020405@cn.fujitsu.com>
Message-ID: <CAFA6WYOhdeezYMG7bNwoMF2a0BuCPN1reg+BK3rkPNZXUgx-Rg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

On Fri, 15 Feb 2019 at 13:25, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> Hi Sumit,
>
> Sorry for the late reply. :-)
>
> 1) Compilation failed on older kernel(e.g. v2.6.32) because of the
> undefined syncfs().
> According to manpage, syncfs() was first appeared in Linux 2.6.39 and
> library
> support was added to glibc in version 2.14. Perhaps, we need to check if
> syncfs()
> is defined.
>
> 2) Running this test got TBROK on older kernel(e.g. v3.10.0), as below:
> -------------------------------------------------------------------
> syncfs01.c:63: FAIL: Failed to sync test filesystem to device
> -------------------------------------------------------------------
> It seems that the content of /sys/block/<loopX>/stat is always zero and
> doesn't update even though write and sync have been done. I am looking
> into it, but i am not sure if this is a known bug on older kernel.
>

Did you get a chance to root cause this issue?

I am not able to reproduce setup running kernel v3.10. If possible,
can you please share your setup details?

As Cyril suggested, we could solve this issue via configuring min_kver
value. But I am not sure regarding appropriate value.

BTW, as this seems to be kernel issue (/sys/block/<loopX>/stat not
updated), do we really don't want to run this test-case on old kernel
where it fails? To me this failure case is value add for user of old
kernel to be aware about this issue and probably fix it.

-Sumit

> Best Regards,
> Xiao Yang
