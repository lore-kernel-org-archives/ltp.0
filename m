From: Jeff Moyer <jmoyer@redhat.com>
Date: Fri, 22 Sep 2017 08:42:22 -0400
Subject: [LTP] io_submit test failed in latest kernel
In-Reply-To: <20170922093616.GB27514@spreadtrum.com> (Orson Zhai's message of
 "Fri, 22 Sep 2017 17:36:16 +0800")
References: <20170915043644.GA27514@spreadtrum.com>
 <x49mv5w9nn9.fsf@segfault.boston.devel.redhat.com>
 <20170922093616.GB27514@spreadtrum.com>
Message-ID: <x49lgl6gb0x.fsf@segfault.boston.devel.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Orson,

Orson Zhai <orson.zhai@spreadtrum.com> writes:

> Hi Jeff,
>
> On Fri, Sep 15, 2017 at 08:01:14AM -0400, Jeff Moyer wrote:
>> Orson Zhai <orson.zhai@spreadtrum.com> writes:
>> 
>> > Hi Guys,
>> >
>> > We got some test failed when running ltp(linux test project) on the latest kernel (v4.13-next).
>> >
>> > It is only observed at x86 platform but nothing wrong for arm test.
>> >
>> > Does anyone here have any comments on this?
>> 
>> What version of ltp are you using?  I don't see output like "expected
>> one of ..." in the latest github tree.  Can you please just send the
>> test code you are using?  Also, why are you using a linux-next tree from
>> August?  Can you try to reproduce this on the released 4.13?
>
> Here is my latest test info:
>
> root@harryfengpc:/home/zhai/ltp-full-20170516# uname -a
> Linux harryfengpc 4.13.0 #3 SMP Thu Sep 14 14:21:05 CST 2017 x86_64 GNU/Linux
>                   ^^^^^^
> root@harryfengpc:/home/zhai/ltp-full-20170516# ./testcases/kernel/syscalls/io_submit/io_submit01
>                                      ^^^^^^^^
> io_submit01    1  TPASS  :  expected failure - returned value = -22 : Invalid argument
> io_submit01    2  TPASS  :  expected failure - returned value = -22 : Invalid argument
> io_submit01    3  TFAIL  :  io_submit01.c:138: unexpected failure - returned value = -95 : Operation not supported, expected one of -EINVAL, -EBADF, -EFAULT
> io_submit01    4  TPASS  :  expected failure - returned value = -14 : Bad address
> io_submit01    5  TPASS  :  expected failure - returned value = -22 : Invalid argument
> io_submit01    6  TPASS  :  expected failure - returned value = -9 : Bad file descriptor
> io_submit01    7  TPASS  :  expected success - returned value = 0
> io_submit01    8  TPASS  :  expected success - returned value = 1
>
>
>
> I use 4.13 final release and download ltp src code of stable release from official website.

Thanks.  Basically, the test feeds in a garbage iocb, and expects one of
the three errnos listed.  This change:

commit b745fafaf70c0a98a2e1e7ac8cb14542889ceb0e
Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
Date:   Tue Jun 20 07:05:43 2017 -0500

    fs: Introduce RWF_NOWAIT and FMODE_AIO_NOWAIT

...

diff --git a/fs/aio.c b/fs/aio.c
index 020fa00..34027b6 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1592,6 +1592,12 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
                goto out_put_req;
        }
 
+       if ((req->common.ki_flags & IOCB_NOWAIT) &&
+                       !(req->common.ki_flags & IOCB_DIRECT)) {
+               ret = -EOPNOTSUPP;
+               goto out_put_req;
+       }
+

could result in a 4th errno.  The test should be updated.

Cheers,
Jeff
