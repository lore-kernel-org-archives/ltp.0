From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jun 2020 15:25:37 +0200
Subject: [LTP] [PATCH V3 2/2] syscalls/clock_gettime: Add test to check
 bug during successive readings
In-Reply-To: <0fb91044431a04c2787bfa121a7e5f969664fc8b.1591948595.git.viresh.kumar@linaro.org>
References: <cc75beb4074b62e94b8ac92cba17af41b8f5fbdc.1591864369.git.viresh.kumar@linaro.org>
 <0fb91044431a04c2787bfa121a7e5f969664fc8b.1591948595.git.viresh.kumar@linaro.org>
Message-ID: <20200625132537.GB28350@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +typedef int (*gettime_t)(clockid_t clk_id, void *ts);
> +static gettime_t ptr_vdso_gettime, ptr_vdso_gettime64;
> +
> +static inline int _vdso_gettime(gettime_t vdso, clockid_t clk_id, void *ts)
> +{
> +	if (!vdso) {
> +		errno = ENOSYS;
> +		return -1;
> +	}
> +
> +	return vdso(clk_id, ts);
> +}
> +
> +static inline int vdso_gettime(clockid_t clk_id, void *ts)
> +{
> +	return _vdso_gettime(ptr_vdso_gettime, clk_id, ts);
> +}
> +
> +static inline int vdso_gettime64(clockid_t clk_id, void *ts)
> +{
> +	return _vdso_gettime(ptr_vdso_gettime64, clk_id, ts);
> +}
> +
> +static void find_vdso_helpers(void)
> +{
> +	/*
> +	 * Some vDSO exports its clock_gettime() implementation with a different
> +	 * name and version from other architectures, so we need to handle it as
> +	 * a special case.
> +	 */
> +#if defined(__powerpc__) || defined(__powerpc64__)
> +	const char *version = "LINUX_2.6.15";
> +	const char *name = "__kernel_clock_gettime";
> +#elif defined(__aarch64__)
> +	const char *version = "LINUX_2.6.39";
> +	const char *name = "__kernel_clock_gettime";
> +#elif defined(__s390__)
> +	const char *version = "LINUX_2.6.29";
> +	const char *name = "__kernel_clock_gettime";
> +#elif defined(__nds32__)
> +	const char *version = "LINUX_4";
> +	const char *name = "__vdso_clock_gettime";
> +#elif defined(__riscv)
> +	const char *version = "LINUX_4.15";
> +	const char *name = "__vdso_clock_gettime";
> +#else
> +	const char *version = "LINUX_2.6";
> +	const char *name = "__vdso_clock_gettime";
> +#endif
> +
> +	const char *version64 = "LINUX_2.6";
> +	const char *name64 = "__vdso_clock_gettime64";
> +
> +	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
> +
> +	if (!sysinfo_ehdr) {
> +		tst_res(TINFO, "Couldn't find AT_SYSINFO_EHDR");
> +		return;
> +	}
> +
> +	vdso_init_from_sysinfo_ehdr(sysinfo_ehdr);
> +
> +	ptr_vdso_gettime = vdso_sym(version, name);
> +	if (!ptr_vdso_gettime)
> +		tst_res(TINFO, "Couldn't find vdso_gettime()");
> +
> +	ptr_vdso_gettime64 = vdso_sym(version64, name64);
> +	if (!ptr_vdso_gettime64)
> +		tst_res(TINFO, "Couldn't find vdso_gettime64()");
> +}

Shouldn't we put this code into the vdso lib so that we can add vdso
variant to all clock_gettime() tests?

-- 
Cyril Hrubis
chrubis@suse.cz
