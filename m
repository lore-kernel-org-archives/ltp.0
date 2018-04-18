From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 18 Apr 2018 16:50:22 +0300
Subject: [LTP] [PATCH 1/2] network/in6_02: Rewrite to the new library
In-Reply-To: <20180417124207.4561-1-pvorel@suse.cz>
References: <20180417124207.4561-1-pvorel@suse.cz>
Message-ID: <4961ba79-c603-5073-b1f8-65a135afcec4@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/17/2018 03:42 PM, Petr Vorel wrote:
...
> +
> +	for (i = 0; i < ARRAY_SIZE(test_case); ++i) {
> +		TEST(if_nametoindex(test_case[i].name));
> +		if (!TEST_RETURN != !test_case[i].nonzero) {
> +			tst_res(TFAIL, "if_nametoindex(\"%s\") %ld [should be %szero]",
> +					test_case[i].name, TEST_RETURN, test_case[i].nonzero ? "non"
> +					: "");
>  			return;
>  		}
>  		if (TEST_RETURN) {
>  			pifn = if_indextoname(TEST_RETURN, ifname);
> -			if (!pifn || strcmp(n2i[i].name, pifn)) {
> -				tst_resm(TFAIL, "if_nametoindex(\"%s\") %ld "
> -					"doesn't match if_indextoname(%ld) "
> -					"\"%s\"", n2i[i].name, TEST_RETURN,
> -					TEST_RETURN, pifn ? pifn : "");
> +			if (!pifn || strcmp(test_case[i].name, pifn)) {
> +				tst_res(TFAIL,
> +					"if_nametoindex(\"%s\") %ld doesn't match if_indextoname(%ld) \"%s\"",

Hi Petr,

It would better to replace all occurrence of \" with '. Or even without it,
if it is inside parenthesis.


> +					test_case[i].name, TEST_RETURN, TEST_RETURN, pifn ? pifn
> +						: "");
>  				return;
>  			}
>  		}
> -		tst_resm(TINFO, "if_nametoindex(\"%s\") %ld",
> -			n2i[i].name, TEST_RETURN);
> +		tst_res(TINFO, "if_nametoindex(\"%s\") %ld",
> +			test_case[i].name, TEST_RETURN);
>  	}
>  
> -	tst_resm(TPASS, "if_nametoindex() tests succeed");
> +	tst_res(TPASS, "if_nametoindex() test succeed");
>  }
>  
> -int sub_i2ntest(unsigned int if_index)
> +int sub_if_indextoname_test(unsigned int if_index)

Should the functions be static in this test?

>  {
>  	char ifname[IF_NAMESIZE];
>  	unsigned int idx;
> @@ -112,41 +93,42 @@ int sub_i2ntest(unsigned int if_index)
>  	TEST((ifname == if_indextoname(if_index, ifname)));
>  	if (!TEST_RETURN) {
>  		if (TEST_ERRNO != ENXIO) {
> -			tst_resm(TFAIL, "if_indextoname(%d) returns %ld "
> -				 "but errno %d != ENXIO", if_index, TEST_RETURN,
> -				 TEST_ERRNO);
> +			tst_res(TFAIL,
> +				"if_indextoname(%d) returns %ld but errno %d != ENXIO",
> +				if_index, TEST_RETURN, TEST_ERRNO);
>  			return 0;
>  		}
> -		tst_resm(TINFO, "if_indextoname(%d) returns NULL", if_index);
> +		tst_res(TINFO, "if_indextoname(%d) returns NULL", if_index);
>  		return 1;
>  	}
>  	/* else, a valid interface-- double check name */
>  	idx = if_nametoindex(ifname);
>  	if (idx != if_index) {
> -		tst_resm(TFAIL, "if_indextoname(%u) returns \"%s\" but "
> -			 "doesn't if_nametoindex(\"%s\") returns %u",
> -			 if_index, ifname, ifname, idx);
> +		tst_res(TFAIL,
> +			"if_indextoname(%u) returns \"%s\" but doesn't if_nametoindex(\"%s\") returns %u",
> +			if_index, ifname, ifname, idx);
>  		return 0;
>  	}
> -	tst_resm(TINFO, "if_indextoname(%d) returns \"%s\"", if_index, ifname);
> +	tst_res(TINFO, "if_indextoname(%d) returns \"%s\"", if_index, ifname);
>  	return 1;
>  }
>
 
...

> +
> +static void do_test(unsigned int i)
> +{
> +	(*testfunc[i])();


It can be just testfunc[i]()


Thanks,
Alexey
