From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Jan 2019 14:55:08 +0100
Subject: [LTP] [PATCH 1/1] cgroup: Rewrite some C parts into new API
In-Reply-To: <20190104121339.32147-1-pvorel@suse.cz>
References: <20190104121339.32147-1-pvorel@suse.cz>
Message-ID: <20190104135508.GB11876@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c b/testcases/kernel/controllers/cgroup/cgroup_regression_6_2.c
...
> -int main(int argc, char **argv)
> +static void do_test(void)
>  {
>  	int usec;
> -
> -	if (argc == 2)
> -		usec = atoi(argv[1]);
> -	else
> +	if (tst_parse_int(str_usec, &usec, 1, INT_MAX))
>  		usec = DEFAULT_USEC;

>  	while (1) {
> @@ -32,5 +33,15 @@ int main(int argc, char **argv)
>  		ltp_clone_quick(CLONE_NEWNS, foo, NULL);
>  	}

> -	tst_exit();
> +	tst_res(TINFO, "exit");
tst_res(TPASS, "exit");

>  }
> +
> +static struct tst_option options[] = {
> +	{"u", &str_usec, "-u       usec (default " STR(DEFAULT_USEC) ")"},
{"u:", &str_usec, "-u       usec (default " STR(DEFAULT_USEC) ")"},
> +	{NULL, NULL, NULL}
> +};

But also have problem to kill it => this patch is not applicable.


Kind regards,
Petr
