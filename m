From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 25 Sep 2018 21:20:18 +0300
Subject: [LTP] [PATCH] syscalls/fanotify: test fanotify_init new flags
	FAN_EVENT_INFO_TID
In-Reply-To: <CAOQ4uxg-6A6R5w-CqRhOonp5OZ8+N3-PVaKpYus1PwpvLB6YkQ@mail.gmail.com>
References: <20180925084344.4397-1-nixiaoming@huawei.com>
 <CAOQ4uxg-6A6R5w-CqRhOonp5OZ8+N3-PVaKpYus1PwpvLB6YkQ@mail.gmail.com>
Message-ID: <CAOQ4uxjWtPA3FjPjMWaUiiEtS9H9GzFxJGHFJwV-qFz9_spMPw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[CC: Jan Kara]

On Tue, Sep 25, 2018 at 5:37 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Sep 25, 2018 at 12:31 PM nixiaoming <nixiaoming@huawei.com> wrote:
> >
> > fanotify_info_tid:
> >         test fanotify_init with FAN_EVENT_INFO_TID
> >         data->pid is ID(pid)  of the thread that caused the event
> > fanotify_info_tgid:
> >         test fanotify_init without FAN_EVENT_INFO_TID
> >         data->pid is ID(tgid) of the process that caused the event
>
> Nixiaoming,
>
> These two tests are identical except for probably a single if condition.
> They should be implemented as a single test with two test cases.
> See test fanotify10 I posted as an example.
>

Nixiaoming,

Two more things to add:
1. Test coverage would be more complete IMO if test would also generate an event
from a forked child. You have an example of SAFE_FORK and
'forks_child' in fanotify03.
You could execute the thread and the child process sequentially,
reading each event
before executing the other to simplify the test.
2. Since FAN_EVENT_INFO_TID is not yet merged and the API not even
reviewed by Jan,
it should be made clear when posting a test that this is an RFC and
not a request for merge
yet. What you could do though is post the test with a single test case
that only checks
tgid and request to merge it. Later post a patch that adds a test case with the
FAN_EVENT_INFO_TID variant after FAN_EVENT_INFO_TID code is merged upstream
(before that you can post RFC test of course).

Hope I didn't make the process too complicated to understand...
Thanks,
Amir.

> Please name your new test fanotify11. In LTP tests are usually numbered
> and not "named".
>
> >
> > Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> > ---
> >  testcases/kernel/syscalls/fanotify/Makefile        |   3 +-
> >  .../kernel/syscalls/fanotify/fanotify_info_tgid.c  | 200 ++++++++++++++++++++
> >  .../kernel/syscalls/fanotify/fanotify_info_tid.c   | 204 +++++++++++++++++++++
>
> Please see my same patch for required changes for new tests to:
>  runtest/syscalls
>  testcases/kernel/syscalls/fanotify/.gitignore
>
> >  3 files changed, 406 insertions(+), 1 deletion(-)
> >  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify_info_tgid.c
> >  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify_info_tid.c
> >
> > diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
> > index bb58878..d85c755 100644
> > --- a/testcases/kernel/syscalls/fanotify/Makefile
> > +++ b/testcases/kernel/syscalls/fanotify/Makefile
> > @@ -17,7 +17,8 @@
> >  #
> >
> >  top_srcdir             ?= ../../../..
> > -
> > +fanotify_info_tid: CFLAGS+=-pthread
> > +fanotify_info_tgid: CFLAGS+=-pthread
> >  include $(top_srcdir)/include/mk/testcases.mk
> >
> >  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify_info_tgid.c b/testcases/kernel/syscalls/fanotify/fanotify_info_tgid.c
> > new file mode 100644
> > index 0000000..3b10d79
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify_info_tgid.c
> > @@ -0,0 +1,200 @@
> > +/*
> > + * Copyright (c) 2013 SUSE.  All Rights Reserved.
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of version 2 of the GNU General Public License as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it would be useful, but
> > + * WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > + *
> > + * Further, this software is distributed without any warranty that it is
> > + * free of the rightful claim of any third person regarding infringement
> > + * or the like.  Any license provided herein, whether implied or
> > + * otherwise, applies only to this software file.  Patent licenses, if
> > + * any, provided herein do not apply to combinations of this program with
> > + * other software, or any other product whatsoever.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write the Free Software Foundation, Inc.,
> > + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > + *
> > + * Started by nixiaoming <nixiaoming@huawei.com>
> > + *
> > + * DESCRIPTION
> > + *     After fanotify_init without FAN_EVENT_INFO_TID,
> > + *     check whether the program can only show tgid
> > + *     in the multithreaded program triggered the event..
> > + *
> > + * This is a regression test for commit 55c5b2ed10331c3b22:
>
> This is not a regression test. Regression means there was a bug and
> a fix and this test verifies a fix.
> This test checks for correctness of event->pid value before and after
> the new FAN_EVENT_INFO_TID feature.
>
> > + *
> > + *     fanotify: support reporting thread id instead of process id
> > + */
> > +#define _GNU_SOURCE
> > +#include "config.h"
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +
> > +#include <sys/stat.h>
> > +#include <sys/types.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +#include <sys/syscall.h>
> > +#include <pthread.h>
> > +#include <sys/stat.h>
> > +#include <fcntl.h>
> > +#include <linux/limits.h>
> > +#include "tst_test.h"
> > +#include "fanotify.h"
> > +
> > +#if defined(HAVE_SYS_FANOTIFY_H)
> > +#include <sys/fanotify.h>
> > +
> > +
> > +#define BUF_SIZE 256
> > +#define gettid() syscall(SYS_gettid)
> > +
> > +static char fname[BUF_SIZE];
> > +int fd_notify;
> > +
> > +static int tid;
> > +static int tgid;
> > +static char tid_file[BUF_SIZE];
> > +
> > +void *thread_create_file(void *arg LTP_ATTRIBUTE_UNUSED)
> > +{
> > +       int fd;
> > +
> > +       tid = gettid();
> > +       snprintf(tid_file, sizeof(tid_file), "%s/test_tid_%d", fname, tid);
> > +       sleep(1);
>
> Why sleep? Can't call thread_create_file() after setting the mark?
>
> > +       fd = SAFE_OPEN(tid_file, O_WRONLY|O_CREAT, 0600);
> > +       tst_res(TINFO, "open file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
> > +       SAFE_WRITE(1, fd, tid_file, sizeof(tid_file));
> > +       tst_res(TINFO, "write file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
> > +       SAFE_CLOSE(fd);
> > +       tst_res(TINFO, "close file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
>
>
> SAFE_FILE_PRINTF(tid_file, "1");
> instead of all of the above?
> and all those TINFO seems too much to me.
>
> > +       SAFE_UNLINK(tid_file);
>
> You don't really need to unlink the file - it is created in a temp dir
> and even if 2nd iteration uses same tid, events would still be created.
>
> > +       tst_res(TINFO, "unlink file=%s. fd=%d, tid=%i\n", tid_file, fd, tid);
> > +       sleep(1);
> > +       pthread_exit(0);
> > +}
> > +
> > +static const char* mask2str(uint64_t mask)
> > +{
> > +       static char buffer[10];
> > +       int offset = 0;
> > +
> > +       if (mask & FAN_ACCESS)
> > +               buffer[offset++] = 'R';
> > +       if (mask & FAN_ONDIR)
> > +               buffer[offset++] = 'D';
> > +       if (mask & FAN_OPEN)
> > +               buffer[offset++] = 'O';
> > +       if (mask & FAN_CLOSE_WRITE || mask & FAN_CLOSE_NOWRITE)
> > +               buffer[offset++] = 'C';
> > +       if (mask & FAN_MODIFY || mask & FAN_CLOSE_WRITE)
> > +               buffer[offset++] = 'W';
> > +       buffer[offset] = '\0';
> > +
> > +       return buffer;
> > +}
> > +
> > +
> > +static void show_data(const struct fanotify_event_metadata *data)
> > +{
> > +       static char printbuf[100];
> > +       static char pathname[PATH_MAX];
> > +       struct stat st;
> > +       int len;
> > +
> > +       snprintf(printbuf, sizeof(printbuf), "/proc/self/fd/%i", data->fd);
> > +       len = readlink(printbuf, pathname, sizeof(pathname));
> > +       if (len < 0) {
> > +               /* fall back to the device/inode */
> > +               if (fstat(data->fd, &st) < 0) {
> > +                       perror("stat");
> > +                       exit(1);
> > +               }
> > +               snprintf(pathname, sizeof(pathname), "device %i:%i inode %ld\n",
> > +                               major(st.st_dev), minor(st.st_dev), st.st_ino);
> > +       } else {
> > +               pathname[len] = '\0';
> > +       }
> > +       tst_res(TINFO, "envnt: %i %s %s\n", data->pid, mask2str(data->mask),
> > +                       pathname);
> > +}
>
> I find all this a bit TMI (too much information) that is not relevant
> for this test.
>
> > +
> > +void test01(void)
> > +{
> > +       int res;
> > +       int ret;
> > +       char buffer[4096] = {0};
>
> You should not define a 4k buffer on the stack but its enough for you
> to use a single
> struct fanotify_event_metadata event;
> as the buffer for this test.
>
> > +       struct fanotify_event_metadata *data;
> > +
> > +       ret = fanotify_mark(fd_notify, FAN_MARK_ADD, FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD, AT_FDCWD, fname);
>
> You don't really need all these event masks. FAN_MODIFY should do.
>
> > +       if (ret != 0) {
> > +               tst_brk(TBROK, "fanotify_mark (%d, FAN_MARK_ADD, FAN_CLOSE | FAN_OPEN |FAN_EVENT_ON_CHILD, AT_FDCWD, %s) "
> > +                               "failed, ret=%d\n", fd_notify, fname, ret);
> > +       }
> > +       tst_res(TINFO, "add notify mark\n");
> > +       res = SAFE_READ(0, fd_notify, buffer, 4096);
> > +       data = (struct fanotify_event_metadata *) buffer;
> > +       while (FAN_EVENT_OK(data, res)) {
> > +               show_data(data);
> > +               if (data->pid == tid)
> > +                       tst_res(TFAIL, "data->pid == envent task thread id %u\n", tid);
> > +               else if (data->pid == tgid)
> > +                       tst_res(TPASS, "data->pid %u != envent task thread id %u\n", data->pid, tid);
> > +               else
> > +                       tst_res(TINFO, "Environmental interference....\n");
>
> That should definitely result in TFAIL.
>
> > +               close(data->fd);
> if (data->fd != FAN_NOFD)
>     SAFE_CLOSE(data->fd);
>
> > +               data = FAN_EVENT_NEXT(data, res);
> > +       }
> > +       fflush(stdout);
> > +
> > +       /* Remove mark to clear FAN_MARK_IGNORED_SURV_MODIFY */
> > +       ret = fanotify_mark(fd_notify, FAN_MARK_REMOVE, FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD, AT_FDCWD, fname);
> > +       if (ret != 0) {
> > +               tst_brk(TBROK, "fanotify_mark (%d, FAN_MARK_REMOVE, FAN_CLOSE | FAN_OPEN | FAN_EVENT_ON_CHILD, AT_FDCWD, %s) "
> > +                               "failed, ret=%d\n", fd_notify, fname, ret);
> > +       }
> > +       tst_res(TINFO, "remove notify mark\n");
> > +}
> > +
> > +static void setup(void)
> > +{
> > +       pthread_t p_id;
> > +
> > +       tgid = getpid();
> > +       sprintf(fname, "tfile_%d", tgid);
> > +       mkdir(fname, 0755);
> > +
> > +       fd_notify = SAFE_FANOTIFY_INIT(0, 0);
>
> To simplify using test cases, better move fanotify_init into the test itself
> and keep SAFE_CLOSE(fd_notify) both at end of test and in cleanup().
> In each test cases your test would use different fanotify_init flags and
> you should specify FAN_CLASS_NOTIF even though is it 0.
>
> > +       if (fd_notify < 0)
> > +               tst_brk(TCONF, "no support\n");
>
> This check is moot because safe_fanotify_init already exists the test
> in this case, but for this reason you cannot use SAFE_FANOTIFY_INIT
> in your test. You need to use fanotify_init() and check for errno == EINVAL
> when you use flag FAN_EVENT_INFO_TID, so you can report TCONF
> for feature not supported in kernel - see my change to fanotify01 to
> test new init flag FAN_UNPRIVILEGED on branch fanotify_unpriv
> in my LTP tree.
>
> > +       pthread_create(&p_id, NULL, thread_create_file, NULL);
> > +}
> > +
>
> Please look into using SAFE_PTHREAD_CREATE
> (and SAFE_PTHREAD_JOIN in cleanup()).
>
> Thanks,
> Amir.
