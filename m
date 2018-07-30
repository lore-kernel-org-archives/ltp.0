From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 Jul 2018 12:44:30 +0200
Subject: [LTP] [PATCH] syscalls/execveat01: new test to verify execveat
 unlinked fd
In-Reply-To: <CALLuPvpvAoM=roZjv85-fLCh=Bz7zomcwB9qXH7-BSNtUihtVA@mail.gmail.com>
References: <1532678306.28611.1.camel@mtkswgap22> <20180727094703.GB914@rei>
 <CALLuPvpvAoM=roZjv85-fLCh=Bz7zomcwB9qXH7-BSNtUihtVA@mail.gmail.com>
Message-ID: <20180730104429.GD5149@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +static void do_child(void)
> >> +{
> >> +
> >> +     char path[PATH_MAX];
> >> +     char *argv[2] = {TEST_APP, NULL};
> >> +     int fd;
> >> +
> >> +     if (tst_get_path(TEST_APP, path, sizeof(path))) {
> >> +             tst_brk(TBROK | TERRNO,
> >> +                      "Couldn't found "TEST_APP" binary in $PATH");
> >> +     }
> >> +     SAFE_CP(path, TEST_FILE_PATH);
> >
> > We do have a better API for this, have a look at creat07.c
> 
> Could you have more detail guide on this? ie. copy TEST_APP to
> ovl mount path

If you specify the child executable as a resource file as in:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2222-datafiles

It will be compied to the test temporary directory before the test is
executed, then you can SAFE_CP() the file when you need it.

Alternatively I can also change the resource file mechanims in the test
library so that we can pass destionation there as well or export the
TST_RESOURCE_COPY() macro to the new library. Then you can use it to
copy the file into its final destination.

> >> +     fd = SAFE_OPEN(TEST_FILE_PATH, O_PATH);
> >> +     SAFE_UNLINK(TEST_FILE_PATH);
> >> +
> >> +     argv[0] = TEST_FILE_PATH;
> >> +     TEST(execveat(fd, "", argv, NULL, AT_EMPTY_PATH));
> >> +     if (TEST_ERRNO == ENOSYS) {
> >> +             tst_brk(TCONF,
> >> +                     "execveat is not supported in this kernel.");
> >> +     }
> >
> > I suppose that we should handle EINVAL here, I think that we will get
> > EINVAL rather than ENOSYS when kernel will not recognize __NR_execveat
> 
> EINVAL is happened to be the same return code of this testcase is expecting --
> the regression introduced from 8db6c34f1dbc ("Introduce v3 namespaced
> file capabilities"), therefore I might need another way to test whether kernel
> recognize __NR_execveat, so that I can differentiate not recognize and the
> regression. Do you have suggestion on this?

We usually specify minimal kernel version for the testcase in the
tst_test structure in that case and the test is skipped automatically on
old kernels that do not have the execveat() syscall implemented.

> >> +int main(void)
> >> +{
> >> +     printf("Hello World\n");
> >> +     exit(0);
> >
> > You can print the TPASS message from here and the result will be
> > propagated to the parent program. You just need to call tst_reinit()
> > that will initialize the test library. See creat07_child.c.
> 
> I change execveat_child.c as below and get errors as:
> tst_test.c:144: BROK: LTP_IPC_PATH is not defined
> tst_test.c:869: BROK: Test haven't reported results!
> 
> I think the cause is execveat() doesn't pass environment variables
> to its child, but SAFE_EXECL in creat07.c does.
> Do you suggest pass LTP_IPC_PATH in execveat() to make
> tst_reinit() in execveat_child run properly, or something else?

Yes, the LTP_IPC_PATH has to be passed manually in this case so that the
library could be re-initialized.

> #define TST_NO_DEFAULT_MAIN
> #include "tst_test.h"
> 
> int main()
> {
>   tst_reinit();
>   tst_res(TPASS, "execveat_child is lunched as expcted");
>   return 0;
> }
> 
> thanks,
> Eddie

-- 
Cyril Hrubis
chrubis@suse.cz
