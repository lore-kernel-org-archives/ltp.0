From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 8 Jan 2019 10:33:44 +0100
Subject: [LTP] [PATCH] device-drivers/cpufreq_boost.c: skip test if
 turbo is disabled by BIOS or unavailable on processor
In-Reply-To: <1546852515-19045-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1546852515-19045-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20190108093344.GA2687@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> If intel_pstate driver has been initialized but turbo is disabled by BIOS
> or unavailable on processor(i.e. intel_pstate/no_turbo file exists but its
> default value is 1), we cannot write data into intel_pstate/no_turbo and
> return EPERM, as below:
> ------------------------------------------------------------------------
> cpufreq_boost    1  TBROK  :  safe_file_ops.c:301: Failed to close FILE '/sys/devices/system/cpu/intel_pstate/no_turbo' at cpufreq_boost.c:151: errno=EPERM(1): Operation not permitted
> cpufreq_boost    2  TBROK  :  safe_file_ops.c:301: Remaining cases broken
> ------------------------------------------------------------------------

> We try to skip test in this case.

> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

Not merging it as it's a git freeze (although it's a fix).

> +	/* We try to skip test when getting EPERM. */
> +	if (write(fd, off, 1) == -1 && errno == EPERM) {
> +		SAFE_CLOSE(NULL, fd);
> +		tst_brkm(TCONF, NULL, "Turbo is disabled by "
> +			 "BIOS or unavailable on processor");
Minor tip: I wouldn't split the string (better for grep, also checkpatch.pl
warns about it).

Kind regards,
Petr
