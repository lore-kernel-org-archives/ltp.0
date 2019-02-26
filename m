From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 26 Feb 2019 01:17:16 +0100
Subject: [LTP] [PATCH v2 2/2] syscalls/clock_adjtime: create
 clock_adjtime syscall tests
In-Reply-To: <20190221203037.21826-2-rafael.tinoco@linaro.org>
References: <20190221200547.7277-2-rafael.tinoco@linaro.org>
 <20190221203037.21826-1-rafael.tinoco@linaro.org>
 <20190221203037.21826-2-rafael.tinoco@linaro.org>
Message-ID: <20190226001716.GA12569@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Rafael,

> diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
> new file mode 100644
> index 000000000..541d9437d
...

> +	SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &ttxc);
> +	timex_show("SET", ttxc);
> +
> +	if (tc[i].ptr) {
> +
> +		/* adjtimex field being tested so we can verify later */
> +
> +		ptroff = (long) tc[i].ptr - (long) &ttxc;
> +		ptr = (void *) &verify + ptroff;
> +	}
> +
> +	TEST(sys_clock_adjtime(CLOCK_REALTIME, &verify));
> +	timex_show("VERIFY", verify);
> +
> +	if (tc[i].ptr && *tc[i].ptr != *ptr) {
Can you please fix this compiler error:
clock_adjtime01.c: In function ‘verify_clock_adjtime’:
clock_adjtime01.c:199:33: warning: ‘ptr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  if (tc[i].ptr && *tc[i].ptr != *ptr) {


Kind regards,
Petr
