From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 May 2018 16:01:46 +0200
Subject: [LTP] [RFC PATCH 1/2] lib/tst_test.sh: TST_TESTFUNC_DATA and
 TST_TESTFUNC_DATA_IFS
In-Reply-To: <20180516134233.x6cp2jjhc6v75zdh@dell5510>
References: <20180516123924.11047-1-pvorel@suse.cz>
 <20180516123924.11047-2-pvorel@suse.cz> <20180516125008.GA544@rei>
 <20180516134233.x6cp2jjhc6v75zdh@dell5510>
Message-ID: <20180516140146.jahg5koje4cgevtd@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,


> And know tst_i (sequence number of a test) for test is needed for some tests which use
> only one function - i.e. TST_TESTFUNC_DATA is passed (no TST_CNT). Let's keep $1 as
> sequence number and $2 for data itself.
> I wonder if $1 shouldn't always have tst_i, even for tests without $TST_CNT. Something
> like:
> +++ testcases/lib/tst_test.sh
> @@ -352,14 +352,14 @@ tst_run()
>  			if type test1 > /dev/null 2>&1; then
>  				for tst_i in $(seq $TST_CNT); do
>  					local res=$(tst_resstr)
> -					$TST_TESTFUNC$tst_i
> +					$TST_TESTFUNC$tst_i $tst_i $TST_TEST_DATA
>  					tst_rescmp "$res"
>  					TST_COUNT=$((TST_COUNT+1))
>  				done
>  			else
>  				for tst_i in $(seq $TST_CNT); do
>  					local res=$(tst_resstr)
> -					$TST_TESTFUNC $tst_i
> +					$TST_TESTFUNC $tst_i $TST_TEST_DATA
>  					tst_rescmp "$res"
>  					TST_COUNT=$((TST_COUNT+1))
>  				done
> @@ -378,7 +378,7 @@ tst_run()
>  			done
>  		else
>  			local res=$(tst_resstr)
> -			$TST_TESTFUNC
> +			$TST_TESTFUNC 1
Actually, I'd avoid this '1', not useful much.
>  			tst_rescmp "$res"
>  			TST_COUNT=$((TST_COUNT+1))
>  		fi


Kind regards,
Petr
