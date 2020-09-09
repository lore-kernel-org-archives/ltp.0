From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Sep 2020 17:10:03 +0800
Subject: [LTP] [PATCH] ioctl: take use of TST_RETRY_FN* macro
In-Reply-To: <1908270893.11577594.1599641047815.JavaMail.zimbra@redhat.com>
References: <20200909075347.2863-1-liwang@redhat.com>
 <1908270893.11577594.1599641047815.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2d8CRnhN6b9-g+6E1v-vMSmenW90u1mChCuHBS6SPaRdA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 9, 2020 at 4:44 PM Jan Stancek <jstancek@redhat.com> wrote:


> > +     value ? (time_delay = 30) : (time_delay = 1);
> > +
> > +     ret = TST_RETRY_FN_EXP_BACKOFF(access(sys_loop_partpath, F_OK),
> > TST_RETVAL_EQ0, time_delay);
>
> Shouldn't we invert also the check when value == 0? At the moment
> there's TST_RETVAL_EQ0 for all cases, but we expect path to exist
> only for value == 1, correct?
>

Obviously yes, and I have thought a while to decrease the
waiting time for the nonzero return, but didn't realize there is also
a macro named TST_RETVAL_NOTNULL(x) can be used:).

Thanks for the suggestion, I think your method is better.


> diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c
> b/testcases/kernel/syscalls/ioctl/ioctl09.c
> index 151618df41db..dff31d58a054 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl09.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
> @@ -28,6 +28,9 @@ static void change_partition(const char *const cmd[])
>                 tst_brk(TBROK, "parted return %i", ret);
>  }
>
> +#define RETVAL_CHECK(x) \
> +       ({ value ? TST_RETVAL_EQ0(x) : TST_RETVAL_NOTNULL(x); })
> +
>  static void check_partition(int part_num, bool value)
>  {
>         int ret;
> @@ -36,7 +39,7 @@ static void check_partition(int part_num, bool value)
>                 dev_num, dev_num, part_num);
>         sprintf(loop_partpath, "%sp%d", dev_path, part_num);
>
> -       ret = access(sys_loop_partpath, F_OK);
> +       ret = TST_RETRY_FN_EXP_BACKOFF(access(sys_loop_partpath, F_OK),
> RETVAL_CHECK, 30);
>         if (ret == 0)
>                 tst_res(value ? TPASS : TFAIL, "access %s succeeds",
>                         sys_loop_partpath);
> @@ -44,7 +47,7 @@ static void check_partition(int part_num, bool value)
>                 tst_res(value ? TFAIL : TPASS, "access %s fails",
>                         sys_loop_partpath);
>
> -       ret = access(loop_partpath, F_OK);
> +       ret = TST_RETRY_FN_EXP_BACKOFF(access(loop_partpath, F_OK),
> RETVAL_CHECK, 30);
>         if (ret == 0)
>                 tst_res(value ? TPASS : TFAIL, "access %s succeeds",
>                         loop_partpath);
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200909/aed24b16/attachment.htm>
