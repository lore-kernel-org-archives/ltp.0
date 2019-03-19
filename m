From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Mar 2019 17:58:57 +0100
Subject: [LTP] [PATCH v3 2/2] sigpending/rt_sigpending: add basic test
In-Reply-To: <20190319113153.13436-3-maennich@google.com>
References: <20190308163832.212631-1-maennich@google.com>
 <20190319113153.13436-1-maennich@google.com>
 <20190319113153.13436-3-maennich@google.com>
Message-ID: <20190319165857.GA28406@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Matthias,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> -static void run(void)
> -{
> -	/* set sigset to point to an invalid location */
> -	sigset_t *sigset = (sigset_t *) - 1;
> +#define min(x, y) (((x) < (y)) ? (x) : (y))
We have MIN() macro in include/tst_minmax.h.

>  #if defined(TEST_SIGPENDING)
> -	TEST(tst_syscall(__NR_sigpending, sigset));
> +#define tested_sigpending(sigset) TEST(tst_syscall(__NR_sigpending, sigset))
>  #elif defined(TEST_RT_SIGPENDING)
> -	TEST(tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE));
> +#define tested_sigpending(sigset)                                              \
> +	TEST(tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE))
>  #else
>  #error Neither TEST_SIGPENDING nor TEST_RT_SIGPENDING is defined!
>  #endif

> +static int sighandler_counter = 0;
IMHO static is automatically 0, thus no assignment needed.


Kind regards,
Petr
