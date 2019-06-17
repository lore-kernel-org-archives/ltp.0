From: Li Wang <liwan@redhat.com>
Date: Mon, 17 Jun 2019 15:18:03 +0800
Subject: [LTP] [PATCH] syscalls/tgkill03: wait for defunct tid to get
	detached
In-Reply-To: <807012526.28418206.1560755030501.JavaMail.zimbra@redhat.com>
References: <a15d4137b63e4202751bea4e726658aa14be7351.1560678643.git.jstancek@redhat.com>
 <CAEemH2dAr_6q8cfkBhRamUJNcP5=W=PcOp1UTEttBsXkhgNABA@mail.gmail.com>
 <807012526.28418206.1560755030501.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2fzRXDZh5P7yOxG1_+prO6iuFc+OJ2qyOmATxsG7KkKWQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 17, 2019 at 3:03 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > On Sun, Jun 16, 2019 at 5:52 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > > Case where defunct tid is used has been observed to sporadically fail:
> > >   tgkill03.c:96: FAIL: Defunct tid should have failed with ESRCH:
> SUCCESS
> > >
> > > glibc __pthread_timedjoin_ex() waits for CLONE_CHILD_CLEARTID to clear
> tid,
> > > and then resumes. Kernel clears it (glibc pd->tid) at:
> > >   do_exit
> > >     exit_mm
> > >       mm_release
> > >         put_user(0, tsk->clear_child_tid);
> > >
> > > but kernel tid is still valid, presumably until:
> > >   release_task
> > >     __exit_signal
> > >       __unhash_process
> > >         detach_pid
> > >
> > > To avoid race wait until /proc/<pid>/task/<tid> disappears.
> > >
> > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > > ---
> > >  testcases/kernel/syscalls/tgkill/tgkill03.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/testcases/kernel/syscalls/tgkill/tgkill03.c
> > > b/testcases/kernel/syscalls/tgkill/tgkill03.c
> > > index f5bbdc5a8d4e..5ac1d2651f7a 100644
> > > --- a/testcases/kernel/syscalls/tgkill/tgkill03.c
> > > +++ b/testcases/kernel/syscalls/tgkill/tgkill03.c
> > > @@ -7,6 +7,7 @@
> > >
> > >  #include <pthread.h>
> > >  #include <pwd.h>
> > > +#include <stdio.h>
> > >  #include <sys/types.h>
> > >
> > >  #include "tst_safe_pthread.h"
> > > @@ -42,6 +43,7 @@ static void setup(void)
> > >  {
> > >         sigset_t sigusr1;
> > >         pthread_t defunct_thread;
> > > +       char defunct_tid_path[PATH_MAX];
> > >
> > >         sigemptyset(&sigusr1);
> > >         sigaddset(&sigusr1, SIGUSR1);
> > > @@ -55,8 +57,10 @@ static void setup(void)
> > >         TST_CHECKPOINT_WAIT(0);
> > >
> > >         SAFE_PTHREAD_CREATE(&defunct_thread, NULL, defunct_thread_func,
> > > NULL);
> > > -
> > >         SAFE_PTHREAD_JOIN(defunct_thread, NULL);
> > > +       sprintf(defunct_tid_path, "/proc/%d/task/%d", getpid(),
> > > defunct_tid);
> > > +       while (access(defunct_tid_path, R_OK) == 0)
> > > +               usleep(10000);
> > >
> >
> > To be on the safe side, I think maybe TST_RETRY_FUNC is a better choice
> > here.
>
> Given high steal time on s390, I rather not put 1s cap on sleep here.
> This is newlib test, so there's already a timeout, I'd prefer to lower
> tst_test.timeout, say 30 seconds?
>

Sure, I think it's long enough for the tgkill03 test.

# uname -rm
4.18.0-94.el8.s390x s390x

# time ./tgkill03
tst_test.c:1112: INFO: Timeout per run is 0h 05m 00s
tgkill03.c:97: PASS: Invalid tgid failed as expected: EINVAL
tgkill03.c:97: PASS: Invalid tid failed as expected: EINVAL
tgkill03.c:97: PASS: Invalid signal failed as expected: EINVAL
tgkill03.c:97: PASS: Defunct tid failed as expected: ESRCH
tgkill03.c:97: PASS: Defunct tgid failed as expected: ESRCH
tgkill03.c:104: PASS: Valid tgkill call succeeded

Summary:
passed   6
failed   0
skipped  0
warnings 0

real 0m0.081s
user 0m0.001s
sys 0m0.002s

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190617/5d980816/attachment.html>
