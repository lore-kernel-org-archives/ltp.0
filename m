From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Mar 2020 08:47:01 +0100
Subject: [LTP] [PATCH v1 2/2] syscalls/settimeofday02: convert to new
 library
In-Reply-To: <1583311467-2379-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1583311467-2379-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1583311467-2379-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200309074701.GA299736@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> +static void verify_settimeofday(unsigned int n)
...
> +	struct tcase *tc = &tcases[n];
> +
> +	flag = 0;
> +	tst_res(TINFO, "%s", tc->message);
> +	TEST(settimeofday(&tc->tv, NULL));
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "settimeofday() succeeded unexpectedly");
Maybe add TTERRNO here as well?
> +		flag = 1;
> +		return;

Kind regards,
Petr
