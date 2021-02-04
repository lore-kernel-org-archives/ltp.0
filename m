From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Feb 2021 21:56:46 +0800
Subject: [LTP] [PATCH v1 3/3] syscalls/mallinfo03: Add an overflow test
 when setting 2G size
In-Reply-To: <601BC5DE.506@cn.fujitsu.com>
References: <1611654925-8994-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1611654925-8994-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
 <601BC5DE.506@cn.fujitsu.com>
Message-ID: <CAEemH2c01CEkm-S667xUL3J=nRVsEhEYK6yFFQXdNt5+dWA7Mw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> >     + tst_res(TFAIL, "The member of struct mallinfo overflow, we should
> >     use mallinfo2");
> >
> > TPASS?
> >
> >     + } else {
> >     + /*We will never get here*/
> >     + tst_res(TPASS, "The member of struct mallinfo doesn't overflow");
> >
> >
> > TFAIL?
> >
> >     + }
> >     + free(buf);
> >     +}
>
> It is a "always" fail test.  We should use mallinfo2 in the future. I
> guess failure may attract user's attention than pass.
>

Sorry, I don't understand the intention here. I got failures like below,
allow it to report FAIL each time in CI/CD system?

# ./mallinfo03
tst_test.c:1263: TINFO: Timeout per run is 0h 05m 00s
tst_mallinfo.c:15: TINFO: Test malloc 2G...
tst_mallinfo.c:17: TINFO: arena: 135168
tst_mallinfo.c:18: TINFO: ordblks: 1
tst_mallinfo.c:19: TINFO: smblks: 0
tst_mallinfo.c:20: TINFO: hblks: 1
tst_mallinfo.c:21: TINFO: hblkhd: -2147479552
tst_mallinfo.c:22: TINFO: usmblks: 0
tst_mallinfo.c:23: TINFO: fsmblks: 0
tst_mallinfo.c:24: TINFO: uordblks: 848
tst_mallinfo.c:25: TINFO: fordblks: 134320
tst_mallinfo.c:26: TINFO: keepcost: 134320
mallinfo03.c:36: TFAIL: The member of struct mallinfo overflow, we should
use mallinfo2

Summary:
passed   0
failed   1
broken   0
skipped  0
warnings 0

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210204/1680b7bd/attachment.htm>
