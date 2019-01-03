From: Li Wang <liwang@redhat.com>
Date: Thu, 3 Jan 2019 17:56:20 +0800
Subject: [LTP] [PATCH 1/3] getrlimit/getrlimit03: fix breakage with
	Aarch32
In-Reply-To: <20181227003102.246617-1-smuckle@google.com>
References: <20181227003102.246617-1-smuckle@google.com>
Message-ID: <CAEemH2c+X3MjKRpd3=Nxv21LCnYRtyRAU2Ye1F8i0FUFAr8jEg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Dec 27, 2018 at 8:31 AM Steve Muckle <smuckle@google.com> wrote:
>
> A 64-bit ARM kernel running an Aarch32 user binary has the ugetrlimit
> and prlimit64 syscalls, but not the getrlimit syscall. This test
> currently assumes getrlimit is always available.

This patch is similar with another:
http://lists.linux.it/pipermail/ltp/2018-December/010249.html

From the structure, I think maybe this one is a tiny bit more clear
than previous, but that'd be better if this can print some TCONF
message for the ENOSYS.

>
> Modify the test so that it does not fail in this configuration.
>
> Signed-off-by: Steve Muckle <smuckle@google.com>
> ---
>  testcases/kernel/syscalls/getrlimit/getrlimit03.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
> index 376ef7241..53a1e2c5d 100644
> --- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
> +++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
> @@ -158,10 +158,15 @@ static void run(unsigned int resource)
>                               "rlim_max"))
>                 return;
>
> +       tst_res(TPASS, "__NR_prlimit64(%d) and %s(%d) gave consistent results",
> +               resource, __NR_getrlimit_ulong_str, resource);
> +
>  #if SIGNED_GETRLIMIT
>         errno = 0;
>         ret_l = getrlimit_long(resource, &rlim_l);
>         errno_l = errno;
> +       if (errno_l == ENOSYS)

Adding tst_res(TCONF, ...) here?

> +               return;
>
>         if (compare_retval(resource, ret_u64, errno_u64, ret_l, errno_l,
>                            "__NR_getrlimit") ||
> @@ -170,10 +175,10 @@ static void run(unsigned int resource)
>             compare_u64_long(resource, rlim_u64.rlim_max, rlim_l.rlim_max,
>                              "rlim_max"))
>                 return;
> -#endif
>
> -       tst_res(TPASS, "getrlimit(%u) was consistent during all syscalls",
> -               resource);
> +       tst_res(TPASS, "__NR_prlimit64(%d) and __NR_getrlimit(%d) gave "
> +               "consistent results", resource, resource);
> +#endif
>  }
>
>  static struct tst_test test = {
> --
> 2.20.1.415.g653613c723-goog
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp



--
Regards,
Li Wang
