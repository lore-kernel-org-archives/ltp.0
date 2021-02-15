From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 15 Feb 2021 14:11:15 +0530
Subject: [LTP] LTP: madvise08.c:203: TFAIL: No sequence in dump after
 MADV_DODUMP.
In-Reply-To: <YCmAGNyFAOZs7GCG@zeniv-ca.linux.org.uk>
References: <CA+G9fYsvDWDogC+xgeG2V9MMofV5svTipDigDiUBje+2jSRK8g@mail.gmail.com>
 <CAK8P3a2OeeW29ekbD70Ns4LTjGRJRT9P0wM-SAxUin1zAxP7TA@mail.gmail.com>
 <CA+G9fYv89bfbixjuudPWkBAucTYg7qhNxcV54RMEkRP5is-bnQ@mail.gmail.com>
 <YCmAGNyFAOZs7GCG@zeniv-ca.linux.org.uk>
Message-ID: <CA+G9fYsZnBv4wAEKYb0mgMd-BsgXcPUGBQ=VRKcONqAZry_4XQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Al Viro,

On Mon, 15 Feb 2021 at 01:25, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Jan 25, 2021 at 10:01:48PM +0530, Naresh Kamboju wrote:
> > commit 8a3cc755b13808eba74846dfd1033fcbc21f9a65
> > Author: Al Viro <viro@zeniv.linux.org.uk>
> > Date:   Sun Mar 8 09:16:37 2020 -0400
> >
> >     coredump: don't bother with do_truncate()
> >
> >     have dump_skip() just remember how much needs to be skipped,
> >     leave actual seeks/writing zeroes to the next dump_emit()
> >     or the end of coredump output, whichever comes first.
> >     And instead of playing with do_truncate() in the end, just
> >     write one NUL at the end of the last gap (if any).
> >
> >     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> >
> >  fs/binfmt_elf.c          |  1 -
> >  fs/coredump.c            | 56 +++++++++++++++++++++++++++---------------------
> >  include/linux/binfmts.h  |  1 +
> >  include/linux/coredump.h |  1 -
> >
> >
> > Test case output link,
> > https://lkft.validation.linaro.org/scheduler/job/2184975#L1369
> > https://lkft.validation.linaro.org/scheduler/job/2184972#L1358
>
> I think I see what's going on.  Could you check if the following
> fixes your reproducer?
>
> diff --git a/arch/powerpc/platforms/cell/spufs/coredump.c b/arch/powerpc/platforms/cell/spufs/coredump.c
> index 60b5583e9eaf..1a587618015c 100644
> --- a/arch/powerpc/platforms/cell/spufs/coredump.c
> +++ b/arch/powerpc/platforms/cell/spufs/coredump.c
> @@ -149,8 +149,7 @@ static int spufs_arch_write_note(struct spu_context *ctx, int i,
>                         return -EIO;
>         }
>
> -       if (!dump_skip(cprm, roundup(cprm->pos - ret + sz, 4) - cprm->pos))
> -               return -EIO;
> +       dump_skip_to(cprm, roundup(cprm->pos - ret + sz, 4));
>         return 0;
>  }
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 66137d5dca5f..474a3c7dd5ce 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -2267,8 +2267,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>                 goto end_coredump;
>
>         /* Align to page */
> -       if (!dump_skip(cprm, dataoff - cprm->pos))
> -               goto end_coredump;
> +       dump_skip_to(cprm, dataoff);
>
>         for (i = 0; i < vma_count; i++) {
>                 struct core_vma_metadata *meta = vma_meta + i;
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index be4062b8ba75..01f043971644 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -1640,8 +1640,7 @@ static int elf_fdpic_core_dump(struct coredump_params *cprm)
>                                 goto end_coredump;
>         }
>
> -       if (!dump_skip(cprm, dataoff - cprm->pos))
> -               goto end_coredump;
> +       dump_skip_to(cprm, dataoff);
>
>         if (!elf_fdpic_dump_segments(cprm, vma_meta, vma_count))
>                 goto end_coredump;
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 27a93f724251..bfac7422cd14 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -894,7 +894,14 @@ int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>  }
>  EXPORT_SYMBOL(dump_emit);
>
> -int dump_skip(struct coredump_params *cprm, size_t nr)
> +void dump_skip_to(struct coredump_params *cprm, unsigned long pos)
> +{
> +       cprm->to_skip = pos - cprm->pos;
> +       return 0;


fs/coredump.c:903:9: error: 'return' with a value, in function
returning void [-Werror=return-type]
 903 | return 0;
        | ^

Build failed due to above error.

build log link,
https://gitlab.com/Linaro/lkft/users/naresh.kamboju/linux/-/jobs/1029838856#L383

- Naresh
