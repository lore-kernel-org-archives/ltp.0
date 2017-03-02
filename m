From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Mar 2017 17:10:57 +0100
Subject: [LTP] [PATCH] min_free_kbytes : Check panic_on_oom before
	running
In-Reply-To: <20170206132419.11060-1-the_hoang0709@yahoo.com>
References: <20170206132419.11060-1-the_hoang0709@yahoo.com>
Message-ID: <20170302161057.GA8152@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
> index cb00f40..8b6dc1c 100644
> --- a/testcases/kernel/mem/tunable/min_free_kbytes.c
> +++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
> @@ -71,6 +71,9 @@ int main(int argc, char *argv[])
>  
>  	tst_parse_opts(argc, argv, NULL, NULL);
>  
> +	if (get_sys_tune("panic_on_oom"))
> +		tst_brkm(TCONF, NULL,
> +			"panic_on_oom is set, disable it to run these testcases");

This check should be put into the test setup() and LKML coding style
prefers curly braces around multiline statemets like this.

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
