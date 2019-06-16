From: Li Wang <liwang@redhat.com>
Date: Sun, 16 Jun 2019 12:22:39 +0800
Subject: [LTP] [PATCH v3 3/3] syscalls/tgkill03: add new test
In-Reply-To: <1142529550.28348566.1560640103965.JavaMail.zimbra@redhat.com>
References: <1552978181-27748-1-git-send-email-sumit.garg@linaro.org>
 <1552978181-27748-4-git-send-email-sumit.garg@linaro.org>
 <1142529550.28348566.1560640103965.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cCvaPKa480Y3L5+V8ihRtwcTYZPo5ebU7Ss8tfRDXkuQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, Jun 16, 2019 at 7:08 AM Jan Stancek <jstancek@redhat.com> wrote:

>
> ----- Original Message -----
> > +static void setup(void)
> > +{
> > +     sigset_t sigusr1;
> > +     pthread_t defunct_thread;
> > +
> > +     sigemptyset(&sigusr1);
> > +     sigaddset(&sigusr1, SIGUSR1);
> > +     pthread_sigmask(SIG_BLOCK, &sigusr1, NULL);
> > +
> > +     parent_tgid = getpid();
> > +     parent_tid = sys_gettid();
> > +
> > +     SAFE_PTHREAD_CREATE(&child_thread, NULL, child_thread_func, NULL);
> > +
> > +     TST_CHECKPOINT_WAIT(0);
>
> I'm seeing reports of this test failing on s390x:
>
> st_test.c:1096: INFO: Timeout per run is 0h 05m 00s
> tgkill03.c:92: PASS: Invalid tgid failed as expected: EINVAL
> tgkill03.c:92: PASS: Invalid tid failed as expected: EINVAL
> tgkill03.c:92: PASS: Invalid signal failed as expected: EINVAL
> tgkill03.c:96: FAIL: Defunct tid should have failed with ESRCH: SUCCESS
> tgkill03.c:92: PASS: Defunct tgid failed as expected: ESRCH
> tgkill03.c:99: PASS: Valid tgkill call succeeded
>
> and I suspect this piece:
>
> > +
> > +     SAFE_PTHREAD_CREATE(&defunct_thread, NULL, defunct_thread_func,
> NULL);
> > +
> > +     SAFE_PTHREAD_JOIN(defunct_thread, NULL);
> > +}
>
> glibc pthread_join() waits for CLONE_CHILD_CLEARTID to clear tid,
> and then resumes. Which kernel does at:
>   do_exit
>     exit_mm
>       mm_release
>         put_user(0, tsk->clear_child_tid);
>
> so there's still work to be done after that, and I suspect tid is still
> valid
> while that happens.
>
> My first idea: wait until /proc/pid/task/<tid> disappears.
>

The anaysis is probably right, but this idea doesn't work for me. Seems
/proc/pid/task/<tid> is not the key point to confirm that tid has been
clear.

I just have a try as below:

===========
# for i in `seq 1000`; do echo "i = $i" && ./tgkill03 || break; done
...
i = 96
tst_test.c:1112: INFO: Timeout per run is 0h 05m 00s
tgkill03.c:106: FAIL: Defunct tid should have failed with ESRCH: SUCCESS

===========
--- a/testcases/kernel/syscalls/tgkill/tgkill03.c
+++ b/testcases/kernel/syscalls/tgkill/tgkill03.c
@@ -5,6 +5,7 @@
  * Test simple tgkill() error cases.
  */

+#include <stdio.h>
 #include <pthread.h>
 #include <pwd.h>
 #include <sys/types.h>
@@ -19,6 +20,7 @@ static pid_t parent_tgid;
 static pid_t parent_tid;
 static pid_t child_tid;
 static pid_t defunct_tid;
+char buf[1024];

 static const int invalid_pid = -1;

@@ -35,6 +37,8 @@ static void *defunct_thread_func(void *arg)
 {
        defunct_tid = sys_gettid();

+       sprintf(buf, "/proc/pid/task/%d", defunct_tid);
+
        return arg;
 }

@@ -73,18 +77,23 @@ static const struct testcase {
        const int sig;
        const int err;
 } testcases[] = {
-       { "Invalid tgid", &invalid_pid, &parent_tid, SIGUSR1, EINVAL },
-       { "Invalid tid", &parent_tgid, &invalid_pid, SIGUSR1, EINVAL },
-       { "Invalid signal", &parent_tgid, &parent_tid, -1, EINVAL },
+//     { "Invalid tgid", &invalid_pid, &parent_tid, SIGUSR1, EINVAL },
+//     { "Invalid tid", &parent_tgid, &invalid_pid, SIGUSR1, EINVAL },
+//     { "Invalid signal", &parent_tgid, &parent_tid, -1, EINVAL },
        { "Defunct tid", &parent_tgid, &defunct_tid, SIGUSR1, ESRCH },
-       { "Defunct tgid", &defunct_tid, &child_tid, SIGUSR1, ESRCH },
-       { "Valid tgkill call", &parent_tgid, &child_tid, SIGUSR1, 0 },
+//     { "Defunct tgid", &defunct_tid, &child_tid, SIGUSR1, ESRCH },
+//     { "Valid tgkill call", &parent_tgid, &child_tid, SIGUSR1, 0 },
 };

 static void run(unsigned int i)
 {
        const struct testcase *tc = &testcases[i];

+       // debug code //
+       while (access(buf, F_OK) == 0) {
+               tst_res(TINFO, "Debug: %s still exist!", buf);
+       }
+
        TEST(sys_tgkill(*tc->tgid, *tc->tid, tc->sig));
        if (tc->err) {
                if (TST_RET < 0 && TST_ERR == tc->err)


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190616/e441e026/attachment.html>
