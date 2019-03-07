From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 7 Mar 2019 11:01:54 +0530
Subject: [LTP] [PATCH] syscalls/rt_tgsigqueueinfo: fix compilation for
	Android
In-Reply-To: <20190306234452.197997-1-smuckle@google.com>
References: <20190306234452.197997-1-smuckle@google.com>
Message-ID: <CAFA6WYN9_RDcp1oPkBRNLy2uNH5cRUbujRUzsHvnrRipsHp5dA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 7 Mar 2019 at 05:14, Steve Muckle <smuckle@google.com> wrote:
>
> Glibc refers to the sigval_t in _sifields._rt as si_sigval. This
> differs from what is in the kernel's uapi siginfo.h, _sigval, which is
> what is used by Android's bionic.
>
> Signed-off-by: Steve Muckle <smuckle@google.com>
> ---
>  .../rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c       | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
> index 4ae17c220..c8252ed8a 100644
> --- a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
> +++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
> @@ -18,12 +18,19 @@
>   */
>
>  #define _GNU_SOURCE
> +
>  #include <err.h>
>  #include <pthread.h>
>  #include "tst_safe_pthread.h"
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
>
> +#ifndef ANDROID
> +#define SI_SIGVAL si_sigval
> +#else
> +#define SI_SIGVAL _sigval
> +#endif
> +
>  static char sigval_send[] = "rt_tgsigqueueinfo data";
>  static volatile int signum_rcv;
>  static char *sigval_rcv;
> @@ -32,7 +39,7 @@ static void sigusr1_handler(int signum, siginfo_t *uinfo,
>                             void *p LTP_ATTRIBUTE_UNUSED)
>  {
>         signum_rcv = signum;
> -       sigval_rcv = uinfo->_sifields._rt.si_sigval.sival_ptr;
> +       sigval_rcv = uinfo->_sifields._rt.SI_SIGVAL.sival_ptr;
>  }
>
>  void *send_rcv_func(void *arg)
> @@ -44,7 +51,7 @@ void *send_rcv_func(void *arg)
>
>         uinfo.si_errno = 0;
>         uinfo.si_code = SI_QUEUE;
> -       uinfo._sifields._rt.si_sigval.sival_ptr = sigval_send;
> +       uinfo._sifields._rt.SI_SIGVAL.sival_ptr = sigval_send;
>
>         TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
>                          syscall(__NR_gettid), SIGUSR1, &uinfo));
> @@ -106,7 +113,7 @@ static void verify_signal_parent_thread(void)
>
>         uinfo.si_errno = 0;
>         uinfo.si_code = SI_QUEUE;
> -       uinfo._sifields._rt.si_sigval.sival_ptr = sigval_send;
> +       uinfo._sifields._rt.SI_SIGVAL.sival_ptr = sigval_send;
>
>         TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
>                          tid, SIGUSR1, &uinfo));
> @@ -123,7 +130,7 @@ void *sender_func(void *arg)
>
>         uinfo.si_errno = 0;
>         uinfo.si_code = SI_QUEUE;
> -       uinfo._sifields._rt.si_sigval.sival_ptr = sigval_send;
> +       uinfo._sifields._rt.SI_SIGVAL.sival_ptr = sigval_send;
>
>         TEST(tst_syscall(__NR_rt_tgsigqueueinfo, getpid(),
>                          *tid, SIGUSR1, &uinfo));
> --
> 2.21.0.352.gf09ad66450-goog
>
