From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Nov 2019 16:18:36 +0800
Subject: [LTP] [PATCH 1/2] Wrapper for Syzkaller reproducers
In-Reply-To: <20191107153458.16917-2-rpalethorpe@suse.com>
References: <20191107153458.16917-1-rpalethorpe@suse.com>
 <20191107153458.16917-2-rpalethorpe@suse.com>
Message-ID: <CAEemH2f=_oGD8Zo=EDE6D096EEP=jCjzEUPOszJ7W7j8vbV7XA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

Some more queries below.

On Thu, Nov 7, 2019 at 11:36 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> Allows one to run the Syzkaller reproducers as part of the LTP.
>
> ...
>
> +AC_ARG_WITH([syzkaller-repros],
> +  [AC_HELP_STRING([--with-syzkaller-repros],
> +    [compile and install Syzkaller reproducers (default=no)])],
> +  [with_syzkaller_repros=$withval]
>

To strictly, the [action-if-not-given] should be added too?


> +)
> +if test "x$with_syzkaller_repros" = xyes; then
> +    AC_SUBST([WITH_SYZKALLER_REPROS],["yes"])
> +else
> +    AC_SUBST([WITH_SYZKALLER_REPROS],["no"])
> +fi
> ...
> diff --git a/runtest/.gitignore b/runtest/.gitignore
> new file mode 100644
> index 000000000..2ae05bfac
> --- /dev/null
> +++ b/runtest/.gitignore
> @@ -0,0 +1 @@
> +syzkaller*
>

Why adding syzkaller* in here?


> diff --git a/testcases/kernel/Makefile b/testcases/kernel/Makefile
> index 3319b3163..0150cfb4f 100644
> --- a/testcases/kernel/Makefile
> +++ b/testcases/kernel/Makefile
> @@ -53,6 +53,7 @@ SUBDIRS                       += connectors \
>                            sched \
>                            security \
>                            sound \
> +                          syzkaller-repros \
>                            tracing \
>                            uevents \
>
> diff --git a/testcases/kernel/syzkaller-repros/.gitignore
> b/testcases/kernel/syzkaller-repros/.gitignore
> new file mode 100644
> index 000000000..dbda1c71f
> --- /dev/null
> +++ b/testcases/kernel/syzkaller-repros/.gitignore
> @@ -0,0 +1 @@
> +syzwrap
> diff --git a/testcases/kernel/syzkaller-repros/Makefile
> b/testcases/kernel/syzkaller-repros/Makefile
> new file mode 100644
> ...
> +# Some useful compiler flags for the LTP will cause problems with the
> +# syzkaller repros so the repros have seperate flags
> +SYZKALLER_CFLAGS ?= -pthread
> +SYZKALLER_REPROS = $(subst
> $(abs_top_srcdir),$(abs_top_builddir),$(SYZKALLER_REPROS_SRCS:.c=))
> +$(SYZKALLER_REPROS): %: %.c
> +       -@if grep -q "__NR_mmap2" $^; then \
> +               M32="-m32"; \
>

I got compiling errors on s390x:
  gcc: error: unrecognized command line option ?-m32?; did you mean ?-m31??

My other concern is syzkaller (I guess maybe) have some package
dependencies, and that will break the compiler phase on the embedded system.


> ....
> +       while (!waitpid(pid, &status, WNOHANG)) {
> +               rem = tst_timeout_remaining();
> +
> +               if (!sent_kill && rem / exec_time_start < 0.5) {
> +                       tst_res(TINFO, "Timeout; killing reproducer");
> +
> +                       TEST(kill(pid, SIGKILL));
> +                       if (TST_RET == -1)
> +                               tst_res(TWARN | TTERRNO, "kill() failed");
> +                       else
> +                               sent_kill = 1;
> +               }
> +
> +               usleep(backoff);
> +               backoff = MIN(2 * backoff, 1000000);
> +       }
>

Force to kill a timeout test process is fine, but one thing makes me
worried is that we don't do any cleanup work(e.g. release hugepage, devices
or other resources) for the children, that very probably causes many
additional issues in the next testing and not easy to reproduce it in a new
run.


> +
> +       if (tst_taint_check()) {
> +               tst_res(TFAIL, "Kernel is tainted");
> +       } else {
> +               tst_res(TPASS, "Kernel is not tainted");
> +       }


If this is the only condition to judge if all tests pass or not, we may
miss some test failure logs after running, unless we don't care about that.

Btw, I can't even finish one round for the test then system panic there.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191126/afa8ad90/attachment.htm>
