From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 21 Mar 2019 17:31:48 -0300
Subject: [LTP] [PATCH v3 4/4] syscalls/clock_adjtime: create
 clock_adjtime syscall tests
In-Reply-To: <20190321202732.3331-4-rafael.tinoco@linaro.org>
References: <20190321141015.GG1252@rei>
 <20190321202732.3331-1-rafael.tinoco@linaro.org>
 <20190321202732.3331-4-rafael.tinoco@linaro.org>
Message-ID: <5A6B4777-4D7E-4D2A-A338-8972236466C1@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


> +static void setup(void)
> +{
> +	size_t i;
> +	int rval;
> +
> +	/* check if clock is TIME_OK and save original clock flags */
> +
> +	rval = SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
> +
> +	if (rval != TIME_OK)
> +		tst_brk(TBROK | TTERRNO, "unsynced clock or on-going leap”);

I choose to break test if rval > 0 mainly because it could still have
on-going leap operations, since clock_adjtime() is async, and also
because doing the test with an unsynced clock seems weird.

Ran both or 10 seconds w/out any issue.

Same for clock_adtime02:

> +static void setup(void)
> +{
> +	size_t i;
> +	int rval;
> +
> +	/* check if clock is TIME_OK and save original clock flags */
> +
> +	rval = SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &saved);
> +
> +	if (rval != TIME_OK)
> +		tst_brk(TBROK | TTERRNO, "unsynced clock or on-going leap");
> +
