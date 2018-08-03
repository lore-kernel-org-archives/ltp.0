From: Eddie Horng <eddiehorng.tw@gmail.com>
Date: Fri, 3 Aug 2018 17:32:52 +0800
Subject: [LTP] [PATCH v2] syscalls/execveat01: new test to verify
 execveat unlinked fd
In-Reply-To: <CAEemH2dsg0Z18taXrBeQvCkJF1WHh9fHbP=GvMzRV62h4kNCzg@mail.gmail.com>
References: <1533111474.1176.4.camel@mtkswgap22>
 <CAEemH2dsg0Z18taXrBeQvCkJF1WHh9fHbP=GvMzRV62h4kNCzg@mail.gmail.com>
Message-ID: <CALLuPvp4Ay5F_giNiUuDR9By+eLNPUNT-perUOE=gbCSmbsc2A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

2018-08-01 19:17 GMT+08:00 Li Wang <liwang@redhat.com>:
> why not adding other arches?
>
> $ git grep __NR_execveat
> alpha/include/uapi/asm/unistd.h:#define __NR_execveat                   513
> arm64/include/asm/unistd32.h:#define __NR_execveat 387
> arm64/include/asm/unistd32.h:__SYSCALL(__NR_execveat, compat_sys_execveat)

Hi Li,
Thanks your tips on finding syscall id, but I still can't find all
arches listed in
[ltp]/include/lapi/syscalls from [kernel]/arch, should I just add the id as much
as I can find from [kernel]/arch?


>> +       fd = SAFE_OPEN(TEST_FILE_PATH, O_PATH);
>> +       SAFE_UNLINK(TEST_FILE_PATH);
>> +
>> +       TEST(execveat(fd, "", argv, environ, AT_EMPTY_PATH));
>
>
> Shouldn't we handle EINVAL here? As the comment says from kernel-4.14,
> this case is expected to fail with EINVAL.
>
> something maybe like:
> -----------------------------
> if (TST_RET == -1) {
> if (TST_ERR == EINVAL)
> tst_res(TCONF, "execveat() return EINVAL as we expected");
> else
> tst_res(TFAIL | TERRNO, "execveat() returned unexpected errno");
> } else {
> tst_res(TFAIL, "On success, execveat() shouldn't return");
> }
>

So Cryil's suggestion works for the case? Same EINVAL error for
both verifying TCONF and expected TFAIL.

thanks,
Eddie
