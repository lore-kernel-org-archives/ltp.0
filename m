From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Mar 2019 11:10:22 +0100
Subject: [LTP] [PATCH 1/1] sigpending: Use 3 variants via
	test_multiplex()
In-Reply-To: <20190325151438.3712-1-pvorel@suse.cz>
References: <20190325151438.3712-1-pvorel@suse.cz>
Message-ID: <20190326101022.GA28312@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static void run(void)
>  {
> +	sigpending_info();
>  	test_sigpending();
>  	test_efault_on_invalid_sigset();
>  }
>  
>  static struct tst_test test = {
> -	.test_all = run
> +	.test_all = run,
> +	.test_variants = 3,
>  };

I would rather see .setup = singpending_info, here so that we don't spam
the output that much, otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
