From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Feb 2020 09:01:55 +0100
Subject: [LTP] [PATCH V2 02/10] lapi/fsmount.h: Add
 fsopen_supported_by_kernel()
In-Reply-To: <8d552688d85a7acc62d654832ab7ce270a70cf77.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <8d552688d85a7acc62d654832ab7ce270a70cf77.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <20200220080155.GB2860622@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Viresh,

...
> +++ b/include/lapi/fsmount.h
...
> +void fsopen_supported_by_kernel(void)
> +{
> +	if ((tst_kvercmp(5, 2, 0)) < 0) {
> +		/* Check if the syscall is backported on an older kernel */
> +		TEST(syscall(__NR_fsopen, NULL, 0));
> +		if (TST_RET == -1 && TST_ERR == ENOSYS)
> +			tst_brk(TCONF, "Test not supporter on kernel version < v5.2");
typo supporter => supported.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
