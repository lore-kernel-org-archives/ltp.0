From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Jul 2020 16:59:11 +0200
Subject: [LTP] [PATCH V7 08/19] syscalls/io_pgetevents: Add support for
 time64 tests
In-Reply-To: <2b946a2ec5c8083e326e4bb4ba08db3f0f9ad66f.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <2b946a2ec5c8083e326e4bb4ba08db3f0f9ad66f.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200703145911.GC11556@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	to.type = tv->type;
> +	tst_ts_set_sec(&to, 0);
> +	tst_ts_set_nsec(&to, 10000);

I've simplified these to "to = tst_ts_from_ns(tv->type, 10000)" and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
