From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 12 Jun 2020 13:10:09 +0530
Subject: [LTP] [PATCH V2 2/2] syscalls/clock_gettime: Add test to check
 bug during successive readings
In-Reply-To: <CAK8P3a1VEj=QhvmeSpzA1GKLhg9isM106yW1trntNVTqP5UZQw@mail.gmail.com>
References: <0f1cc05d6d79238ed94b93417f300e9a026a2063.1591864369.git.viresh.kumar@linaro.org>
 <cc75beb4074b62e94b8ac92cba17af41b8f5fbdc.1591864369.git.viresh.kumar@linaro.org>
 <CAK8P3a1VEj=QhvmeSpzA1GKLhg9isM106yW1trntNVTqP5UZQw@mail.gmail.com>
Message-ID: <20200612074009.t5ccj36nf7pd25sz@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11-06-20, 15:05, Arnd Bergmann wrote:
> On Thu, Jun 11, 2020 at 10:34 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +static void find_vdso_helpers(void)
> > +{
> > +       /*
> > +        * Some vDSO exports its clock_gettime() implementation with a different
> > +        * name and version from other architectures, so we need to handle it as
> > +        * a special case.
> > +        */
> > +#if defined(__powerpc__) || defined(__powerpc64__)
> > +       const char *version = "LINUX_2.6.15";
> > +       const char *name = "__kernel_clock_gettime";
> > +#elif defined(__aarch64__)
> > +       const char *version = "LINUX_2.6.39";
> > +       const char *name = "__kernel_clock_gettime";
> > +#elif defined(__s390__)
> > +       const char *version = "LINUX_2.6.29";
> > +       const char *name = "__kernel_clock_gettime";
> > +#else
> > +       const char *version = "LINUX_2.6";
> > +       const char *name = "__vdso_clock_gettime";
> > +#endif
> 
> I see that risc-v uses version="LINUX_4.15", and nds32 uses "LINUX_4",
> the other ones look correct.

My bad, I only looked at man page of vdso for clock_gettime(), while I
looked at kernel source for clock_gettime64() :(

> > +                       ret = tv->gettime(clks[i], tst_ts_get(&ts));
> > +                       if (ret) {
> > +                               if (errno != ENOSYS) {
> > +                                       tst_res(TFAIL | TERRNO, "%s: clock_gettime() failed (%d)",
> > +                                               tst_clock_name(clks[i]), j);
> > +                               }
> > +                               continue;
> > +                       }
> 
> Is this a test case failure, or does it still succeed after skipping a call?

"continue" takes us to the next variant for the current test loop (out
of 10000 loops). So we don't exit here, though this reports a failure
and that will be visible in the output. But because we continue here,
we will also see a TPASS at the end for the same clock. So if the
test was running for CLOCK_REALTIME, then we will see both FAIL and
PASS in output. I didn't wanted to abandon the test in such a case and
so kept it like that.

> When any of the variants (in particular vdso_clock_gettime64) don't
> exist, I think you just need to continue without printing anything.

That is exactly why we are looking for ENOSYS here. The other code
(which you removed) explicitly sets the error to ENOSYS if
clock_gettime64() or clock_gettime() vdso isn't available. And so we
won't print an error here. Though the setup routine will print only
once if the vdso wasn't available, as general information.

> Note that older kernels before v5.1 don't have the clock_gettime64
> syscall, while riscv and future architectures as well as kernels with
> CONFIG_COMPAT_32BIT_TIME=n don't have clock_gettime(),
> and some architectures don't have a vdso, or only the time32 version
> of it.

-- 
viresh
