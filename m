From: Li Wang <liwang@redhat.com>
Date: Mon, 6 Aug 2018 17:26:44 +0800
Subject: [LTP] [PATCH v2] syscalls/execveat01: new test to verify
 execveat unlinked fd
In-Reply-To: <CALLuPvp4Ay5F_giNiUuDR9By+eLNPUNT-perUOE=gbCSmbsc2A@mail.gmail.com>
References: <1533111474.1176.4.camel@mtkswgap22>
 <CAEemH2dsg0Z18taXrBeQvCkJF1WHh9fHbP=GvMzRV62h4kNCzg@mail.gmail.com>
 <CALLuPvp4Ay5F_giNiUuDR9By+eLNPUNT-perUOE=gbCSmbsc2A@mail.gmail.com>
Message-ID: <CAEemH2f8di2qLvKPmutiO64w+YOxVbHxZgggvqtM-TPS5TU8eg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Eddie,

Eddie Horng <eddiehorng.tw@gmail.com> wrote:

> 2018-08-01 19:17 GMT+08:00 Li Wang <liwang@redhat.com>:
> > why not adding other arches?
> >
> > $ git grep __NR_execveat
> > alpha/include/uapi/asm/unistd.h:#define __NR_execveat
>  513
> > arm64/include/asm/unistd32.h:#define __NR_
> execveat 387
> > arm64/include/asm/unistd32.h:__SYSCALL(__NR_execveat,
> compat_sys_execveat)
>
> Hi Li,
> Thanks your tips on finding syscall id, but I still can't find all
> arches listed in
> [ltp]/include/lapi/syscalls from [kernel]/arch, should I just add the id
> as much
> as I can find from [kernel]/arch?
>

I think at least we'd better adding support as LTP(/include/lapi/syscalls)
has.


> So Cryil's suggestion works for the case? Same EINVAL error for
> both verifying TCONF and expected TFAIL.
>
>
Hmm, from your patch I got these information:

kernel < 3.19    :
execveat() not support
3.19 <= kernel < 4.14  :
execveat() fully support
kernel >= 4.14  :
execveat() return EINVAL expectly

If I was right, so Cyril's suggestion should be like:

static void do_child(void)
{
    ...

    /* Check if system support execveat() correctly */
    TEST(execveat(fd, "", argv, environ, AT_EMPTY_PATH));
    /* Do TCONF if we get EINVAL here */

    SAFE_UNLINK(TEST_FILE_PATH);

    /* Do your testing */
    TEST(execveat(fd, "", argv, environ, AT_EMPTY_PATH));
    /* Here if we get EINVAL again that means hit a bug! */
}

Did I miss anything?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180806/2d81b5e4/attachment.html>
