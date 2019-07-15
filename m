From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 15 Jul 2019 16:13:42 +0800
Subject: [LTP] [PATCH 2/2] syscalls/acct02: Fix failures with nearly
 full FS
In-Reply-To: <20190712141530.22195-3-chrubis@suse.cz>
References: <20190712141530.22195-1-chrubis@suse.cz>
 <20190712141530.22195-3-chrubis@suse.cz>
Message-ID: <5D2C35B6.6080606@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> While process accounting is running the kernel checks the percentage of
> available space on disk. If the accounting is enabled and the free space
> drops below 2% the accounting is disabled until we reach at least 4% of
> free space. Which especially means that we have to have more than 4% of
> free space when we start the accounting because we are starting in
> disabled state. And when accounting is disabled the data are dropped
> silently instead of being written to the file, which makes this test
> fail because we end up with an empty file.
>
> So this patch checks if there is at least 4.1% of free space before we
> start the test and exit with TCONF otherwise.
>
> Signed-off-by: Cyril Hrubis<chrubis@suse.cz>
> CC: Christian Amann<camann@suse.com>
> ---
>   testcases/kernel/syscalls/acct/acct02.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
> index f61faf206..6c375d5cb 100644
> --- a/testcases/kernel/syscalls/acct/acct02.c
> +++ b/testcases/kernel/syscalls/acct/acct02.c
> @@ -146,8 +146,20 @@ static void run(void)
>
>   static void setup(void)
>   {
> +	struct statfs buf;
> +
>   	clock_ticks = SAFE_SYSCONF(_SC_CLK_TCK);
>
> +	SAFE_STATFS(".",&buf);
> +
> +	float avail = (100.00 * buf.f_bavail) / buf.f_blocks;

Hi Cyril

  I met the same problem on last week when I ran acct02 on nearly full FS.  Since kernel/acct.c has defined the RESUME(4) and SUSPEND(2) macro,
4.1 is enough.  And I think we can leave a simple comment in here for why the limit is 4.1(even though the commit message has the reason).

Thanks
Yang Xu

> +
> +	if (avail<  4.1) {
> +		tst_brk(TCONF,
> +			"Less than 4.1%% (%.2f) of free space on filesystem",
> +			avail);
> +	}
> +
>   	TEST(acct(NULL));
>   	if (TST_RET == -1)
>   		tst_brk(TBROK | TTERRNO,



