From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 31 Dec 2019 11:01:17 +0530
Subject: [LTP] [PATCH RFC] sync_file_range02: remove the toplimit of
 write back
In-Reply-To: <CAEemH2coGZGjFLhHzeR4JJYWpERGypjRdXRQ2dO0f1=Drh2KOg@mail.gmail.com>
References: <20191218082826.25083-1-liwang@redhat.com>
 <2104821569.17247635.1576661091375.JavaMail.zimbra@redhat.com>
 <CAFA6WYN1ssqCzCqvT=9=DLjZdQz8OnH7+YBi8VGo7XLRdNLyvg@mail.gmail.com>
 <CAEemH2eRhmozt5OiT6z-YBjJUBNaGZgQVQRh40hNpKcq2d4-aw@mail.gmail.com>
 <CAFA6WYOBbH8UbwrK1f3ZQjGuqHJqGZxhQ-N0w1mpBHz0bnPG1w@mail.gmail.com>
 <CAEemH2eXvZB9uCuZFsc2uMAt5k2F_gfgXCqch58juMsJn4Gr4w@mail.gmail.com>
 <CAEemH2coGZGjFLhHzeR4JJYWpERGypjRdXRQ2dO0f1=Drh2KOg@mail.gmail.com>
Message-ID: <CAFA6WYMC=vh9xevacVwLCTVTn=KB0TjFUug5=ZVXkSu11io17g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 31 Dec 2019 at 10:55, Li Wang <liwang@redhat.com> wrote:
>
> Hi,
>
> On Thu, Dec 19, 2019 at 5:15 PM Li Wang <liwang@redhat.com> wrote:
>>
>>
>>
>> On Thu, Dec 19, 2019 at 4:52 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>>>
>>> ...
>>> >> To avoid similar scenarios, I suggested to add a "sync()" call just
>>> >> prior to test here [1]. And I couldn't reproduce the failure in
>>> >> 1000-times run with 4.19 kernel.
>>> >
>>> >
>>> > Yes, that makes sense to me.
>>> >
>>>
>>> Would you mind to give it a try and check if you could reproduce the failure?
>>
>>
>> Actually, I haven't had one time to reproduce it. This failure was reported by CI jobs and very low frequency occurred. The fix is based on a discussion with FS developer analysis.
>>
>> But I would have a try with this patch(+ sync()).
>
>
> I have tried this for many different systems, and it doesn't hit the failure at least one time. So if no more comments, I would merge the patch as below in the next step.
>
> --- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> @@ -48,6 +48,8 @@ static void verify_sync_file_range(struct testcase *tc)
>
>         lseek(fd, tc->write_off, SEEK_SET);
>
> +       sync();
> +
>         tst_dev_bytes_written(tst_device->dev);
>
>         tst_fill_fd(fd, 0, TST_MB, tc->write_size_mb);
> @@ -66,8 +68,7 @@ static void verify_sync_file_range(struct testcase *tc)
>
>         SAFE_CLOSE(fd);
>
> -       if ((written >= tc->exp_sync_size) &&
> -           (written <= (tc->exp_sync_size + tc->exp_sync_size/10)))
> +       if (written >= tc->exp_sync_size)
>                 tst_res(TPASS, "%s", tc->desc);
>         else
>                 tst_res(TFAIL, "%s: Synced %li, expected %li", tc->desc,
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> --
> Regards,
> Li Wang
