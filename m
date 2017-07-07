From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Jul 2017 16:49:45 +0200
Subject: [LTP] [PATCH V2 04/14] mem/ksm: convert to new API
In-Reply-To: <20170410100556.4465-5-liwang@redhat.com>
References: <20170410100556.4465-1-liwang@redhat.com>
 <20170410100556.4465-5-liwang@redhat.com>
Message-ID: <20170707144945.GE28534@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	tst_parse_opts(argc, argv, ksm_options, ksm_usage);
> -	setup();
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		check_ksm_options(&size, &num, &unit);
> -		create_same_memory(size, num, unit);
> -	}
> -	cleanup();
> -	tst_exit();
> +	check_ksm_options(&size, &num, &unit);

There is no need to parse the test options on every test iteration, this
should be called once in the test setup.

Moreover passing things around in global variables is messy. What about
we (ideally in a separate patch) created a function(s) to parse the KSM
options and pass the string values explicitily.

setup(void)
{
	...
	parse_ksm_options(str_size, &size, str_num, &num, str_unit, &unit);
	...
}

Also could we define the ksm_options array in one place instead of
repeating it in each test. What about putting it into ksh_common.h in
the mem/ksm/ directory and including it in each test?

-- 
Cyril Hrubis
chrubis@suse.cz
