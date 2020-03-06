From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 6 Mar 2020 16:05:30 +0100
Subject: [LTP] [PATCH V2] syscalls/openat2: New tests
In-Reply-To: <20200306144603.GA31015@rei.lan>
References: <6b3d4c2c92b4a4e6eeef708ac181b57cf7affda4.1583233870.git.viresh.kumar@linaro.org>
 <20200306144603.GA31015@rei.lan>
Message-ID: <20200306150530.GA15614@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +void openat2_supported_by_kernel(void)
> > +{
> > +	if ((tst_kvercmp(5, 6, 0)) < 0) {
> > +		/* Check if the syscall is backported on an older kernel */
> > +		TEST(syscall(__NR_openat2, -1, NULL, NULL, 0));
> > +		if (TST_RET == -1 && TST_ERR == ENOSYS)
> > +			tst_brk(TCONF, "Test not supported on kernel version < v5.2");

> The test is for 5.6 but the message says 5.2, so which one is correct?
Added in v5.6.

Kind regards,
Petr
