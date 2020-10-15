From: Petr Mladek <pmladek@suse.com>
Date: Thu, 15 Oct 2020 14:22:46 +0200
Subject: [LTP] [PATCH] printk: ringbuffer: Wrong data pointer when
 appending small string
In-Reply-To: <20201014175051.GC13775@alley>
References: <CA+G9fYt46oC7-BKryNDaaXPJ9GztvS2cs_7GjYRjanRi4+ryCQ@mail.gmail.com>
 <20201014140514.GB17231@alley> <20201014151311.GB13775@alley>
 <20201014175051.GC13775@alley>
Message-ID: <20201015122246.GD8871@alley>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed 2020-10-14 19:50:54, Petr Mladek wrote:
> data_realloc() returns wrong data pointer when the block is wrapped and
> the size is not increased. It might happen when pr_cont() wants to
> add only few characters and there is already a space for them because
> of alignment.
> 
> It might cause writing outsite the buffer. It has been detected by LTP
> tests with KASAN enabled:
> 
> Link: https://lore.kernel.org/r/CA+G9fYt46oC7-BKryNDaaXPJ9GztvS2cs_7GjYRjanRi4+ryCQ@mail.gmail.com
> Fixes: 4cfc7258f876a7feba673ac ("printk: ringbuffer: add finalization/extension support")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

The patch is committed into printk/linux.git, branch for-5.10-fixup.

I am going to send a pull request with it tomorrow unless something
happens in the meantime.

Best Regards,
Petr
