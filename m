From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 31 Aug 2021 13:35:09 +0100
Subject: [LTP] [PATCH 1/1] lib/tests: Remove tst_fuzzy_sync02
In-Reply-To: <20210831121250.17557-1-pvorel@suse.cz>
References: <20210831121250.17557-1-pvorel@suse.cz>
Message-ID: <875yvllrlu.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> tst_fuzzy_sync02 is not stable enough [1]:
>
> ../../include/tst_fuzzy_sync.h:346: TINFO: loop = 10001, delay_bias = 3960
> ../../include/tst_fuzzy_sync.h:335: TINFO: start_a - start_b: { avg = -8859ns, avg_dev =    66ns, dev_ratio = 0.01 }
> ../../include/tst_fuzzy_sync.h:335: TINFO: end_a - start_a  : { avg = 17160ns, avg_dev =    85ns, dev_ratio = 0.00 }
> ../../include/tst_fuzzy_sync.h:335: TINFO: end_b - start_b  : { avg = 18474ns, avg_dev =    55ns, dev_ratio = 0.00 }
> ../../include/tst_fuzzy_sync.h:335: TINFO: end_a - end_b    : { avg = -10173ns, avg_dev =   124ns, dev_ratio = 0.01 }
> ../../include/tst_fuzzy_sync.h:335: TINFO: spins            : { avg =  2751  , avg_dev =    31  , dev_ratio = 0.01 }
> ../../include/tst_fuzzy_sync.h:685: TINFO: Exceeded execution loops, requesting exit
> tst_fuzzy_sync02.c:169: TFAIL: 2| =:48
> ...
> runtest TINFO: === C TEST RESULTS ===
> ...
> runtest TINFO: 1x TFAIL: tst_fuzzy_sync02
>
> Both tst_fuzzy_sync0{1,2} occasionally fails (restart helps). But
> tst_fuzzy_sync03 is stable thus we have at least smoke test for fuzzy
> sync.

Yes, there is probably some work to do on the algorithm itself. At least
to make it stable in this kind of environment.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.
