From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Jan 2021 11:34:58 +0100
Subject: [LTP] [PATCH v3 3/3] syscalls: Take use of TST_EXP_PASS_SILENT
In-Reply-To: <20210112020227.11775-3-yangx.jy@cn.fujitsu.com>
References: <20210112020227.11775-1-yangx.jy@cn.fujitsu.com>
 <20210112020227.11775-3-yangx.jy@cn.fujitsu.com>
Message-ID: <YAgHUvIge6svN0gu@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/capget/capget01.c b/testcases/kernel/syscalls/capget/capget01.c
> index 6c17a7c7c..af088e2fc 100644
> --- a/testcases/kernel/syscalls/capget/capget01.c
> +++ b/testcases/kernel/syscalls/capget/capget01.c
> @@ -32,8 +32,10 @@ static void verify_capget(unsigned int n)
>  	hdr->version = tc->version;
>  	hdr->pid = pid;
>  
> -	TST_EXP_PASS(tst_syscall(__NR_capget, hdr, data),
> +	TST_EXP_PASS_SILENT(tst_syscall(__NR_capget, hdr, data),
>  	             "capget() with %s", tc->message);
> +	if (!TST_PASS)
> +		return;
>  
>  	if (data[0].effective & 1 << CAP_NET_RAW)
>  		tst_res(TFAIL, "capget() gets CAP_NET_RAW unexpectedly in pE");

I do not agree with the change in the capget01 here since there are
really two testcases there and the test was producing the same amount of
TPASS messages before the change to the TST_EXP_PASS() as well.

Other than that the patchset is fine.

So with the capget change removed you can add my:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
