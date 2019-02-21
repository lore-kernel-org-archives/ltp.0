From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 21 Feb 2019 12:38:49 +0530
Subject: [LTP] [PATCH v2] syscalls: add syscall syncfs test
In-Reply-To: <CAFA6WYOhdeezYMG7bNwoMF2a0BuCPN1reg+BK3rkPNZXUgx-Rg@mail.gmail.com>
References: <1550215053-6795-1-git-send-email-sumit.garg@linaro.org>
 <5C667060.7020405@cn.fujitsu.com>
 <CAFA6WYOhdeezYMG7bNwoMF2a0BuCPN1reg+BK3rkPNZXUgx-Rg@mail.gmail.com>
Message-ID: <CAFA6WYOGZ9i4veamyM0qGaYz26rMwfQKo79Z27Nd-UnckqYzxA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 19 Feb 2019 at 12:14, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Xiao,
>
> On Fri, 15 Feb 2019 at 13:25, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
> >
> > Hi Sumit,
> >
> > Sorry for the late reply. :-)
> >
> > 1) Compilation failed on older kernel(e.g. v2.6.32) because of the
> > undefined syncfs().
> > According to manpage, syncfs() was first appeared in Linux 2.6.39 and
> > library
> > support was added to glibc in version 2.14. Perhaps, we need to check if
> > syncfs()
> > is defined.
> >
> > 2) Running this test got TBROK on older kernel(e.g. v3.10.0), as below:
> > -------------------------------------------------------------------
> > syncfs01.c:63: FAIL: Failed to sync test filesystem to device
> > -------------------------------------------------------------------
> > It seems that the content of /sys/block/<loopX>/stat is always zero and
> > doesn't update even though write and sync have been done. I am looking
> > into it, but i am not sure if this is a known bug on older kernel.
> >
>
> Did you get a chance to root cause this issue?
>
> I am not able to reproduce setup running kernel v3.10. If possible,
> can you please share your setup details?
>
> As Cyril suggested, we could solve this issue via configuring min_kver
> value. But I am not sure regarding appropriate value.
>
> BTW, as this seems to be kernel issue (/sys/block/<loopX>/stat not
> updated), do we really don't want to run this test-case on old kernel
> where it fails? To me this failure case is value add for user of old
> kernel to be aware about this issue and probably fix it.
>

Thinking more about broken /sys/block/<loopX>/stat [1]. It seems that
following param should be a good indicator of block device stat file
being broken:

io_ticks        milliseconds  total time this block device has been active

This param should be non-zero inside test-case as there are already
some file-system operations performed on the device like formatting
etc.

If you could confirm that you see this param as zero on older kernel
(v3.10), then I will add a TCONF check for this param being non-zero
as follows:

-       SAFE_FILE_SCANF(NULL, dev_stat_path, "%*s %*s %*s %*s %*s %*s %lu",
-                       &dev_sec_write);
+       SAFE_FILE_SCANF(NULL, dev_stat_path,
+                       "%*s %*s %*s %*s %*s %*s %lu %*s %*s %lu",
+                       &dev_sec_write, &io_ticks);
+
+       if (!io_ticks)
+               tst_brkm(TCONF, NULL, "Test device stat file: %s broken",
+                        dev_stat_path);

[1] https://www.kernel.org/doc/Documentation/block/stat.txt

-Sumit

>
> > Best Regards,
> > Xiao Yang
