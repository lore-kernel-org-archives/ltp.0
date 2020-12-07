From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Dec 2020 15:41:36 +0100
Subject: [LTP] [PATCH v2 1/3] lib: add .min_cpus in tst_test struct
In-Reply-To: <20201204063305.6820-1-liwang@redhat.com>
References: <20201203110616.28302-1-liwang@redhat.com>
 <20201204063305.6820-1-liwang@redhat.com>
Message-ID: <X84/IAwVIwXjN+6Z@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two fixes, thanks.

> +	/* Minimum numbers of online CPU required by the test */
                      ^
		      number
> +	unsigned long min_cpus;
> +
>  	/*
>  	 * If set non-zero number of request_hugepages, test will try to reserve the
>  	 * expected number of hugepage for testing in setup phase. If system does not
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 535c0ff4c..c4e04eb4a 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -918,6 +918,9 @@ static void do_setup(int argc, char *argv[])
>  	if (tst_test->all_filesystems)
>  		tst_test->needs_device = 1;
>  
> +	if (tst_test->min_cpus > tst_ncpus())
                                   ^
				   Added (unsigned long) cast to silence
				   warnings.
> +		tst_brk(TCONF, "Test needs at least %lu CPUs online", tst_test->min_cpus);
> +
>  	if (tst_test->request_hugepages)
>  		tst_request_hugepages(tst_test->request_hugepages);
>  
> -- 
> 2.21.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
