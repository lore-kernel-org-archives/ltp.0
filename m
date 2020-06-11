From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 11 Jun 2020 15:05:52 +0200
Subject: [LTP] [PATCH V2 2/2] syscalls/clock_gettime: Add test to check
 bug during successive readings
In-Reply-To: <cc75beb4074b62e94b8ac92cba17af41b8f5fbdc.1591864369.git.viresh.kumar@linaro.org>
References: <0f1cc05d6d79238ed94b93417f300e9a026a2063.1591864369.git.viresh.kumar@linaro.org>
 <cc75beb4074b62e94b8ac92cba17af41b8f5fbdc.1591864369.git.viresh.kumar@linaro.org>
Message-ID: <CAK8P3a1VEj=QhvmeSpzA1GKLhg9isM106yW1trntNVTqP5UZQw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 11, 2020 at 10:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> +static void find_vdso_helpers(void)
> +{
> +       /*
> +        * Some vDSO exports its clock_gettime() implementation with a different
> +        * name and version from other architectures, so we need to handle it as
> +        * a special case.
> +        */
> +#if defined(__powerpc__) || defined(__powerpc64__)
> +       const char *version = "LINUX_2.6.15";
> +       const char *name = "__kernel_clock_gettime";
> +#elif defined(__aarch64__)
> +       const char *version = "LINUX_2.6.39";
> +       const char *name = "__kernel_clock_gettime";
> +#elif defined(__s390__)
> +       const char *version = "LINUX_2.6.29";
> +       const char *name = "__kernel_clock_gettime";
> +#else
> +       const char *version = "LINUX_2.6";
> +       const char *name = "__vdso_clock_gettime";
> +#endif

I see that risc-v uses version="LINUX_4.15", and nds32 uses "LINUX_4",
the other ones look correct.

> +                       ret = tv->gettime(clks[i], tst_ts_get(&ts));
> +                       if (ret) {
> +                               if (errno != ENOSYS) {
> +                                       tst_res(TFAIL | TERRNO, "%s: clock_gettime() failed (%d)",
> +                                               tst_clock_name(clks[i]), j);
> +                               }
> +                               continue;
> +                       }

Is this a test case failure, or does it still succeed after skipping a call?
When any of the variants (in particular vdso_clock_gettime64) don't
exist, I think you just need to continue without printing anything.
Note that older kernels before v5.1 don't have the clock_gettime64
syscall, while riscv and future architectures as well as kernels with
CONFIG_COMPAT_32BIT_TIME=n don't have clock_gettime(),
and some architectures don't have a vdso, or only the time32 version
of it.

        Arnd

      Arnd
