From: Li Wang <liwang@redhat.com>
Date: Mon, 2 Aug 2021 11:16:38 +0800
Subject: [LTP] [PATCH] lib: tst_device: Allow more control over the
 device size
In-Reply-To: <20210730133155.31284-1-chrubis@suse.cz>
References: <20210730133155.31284-1-chrubis@suse.cz>
Message-ID: <CAEemH2fw+=Y6DyC+rB2OsrQgzpFrxSxPDJusmrFsMAtiQgb8sw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 30, 2021 at 9:32 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> There is actually no reason for lower limit on the device size, and we
> can safely allow the tests to request smaller device than the default
> hardcoded in the library. The backing file is preallocated without
> actually writing to it as long as the underlying filesystem supports it
> so the speedup will be minimal if measurable but we will at least spare
> some space which needs to be reserved on the filesystem which is still a
> good thing.
>
> The test may end up with a device that is bigger than the requsted size
> in a case that a real device was passed to the LTP for the testrun.  So
> tests should be able to cope with that and that's also the reason why
> the turning knob is still called dev_min_size.
>
> Also currently we use the dev_min_size only to increase the device size
> for a few tests so this change is safe and cannot break anything.
>
> CC: Joerg Vehlow <lkml@jv-coder.de>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210802/b65aa6c5/attachment.htm>
