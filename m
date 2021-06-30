From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 30 Jun 2021 08:11:47 +0100
Subject: [LTP] ee
In-Reply-To: <YNuA/0J20mjiV+NC@pevik>
References: <YNuA/0J20mjiV+NC@pevik>
Message-ID: <87tulf3jyk.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
> sporadically tst_fuzzy_sync01 fails. I wonder if we can relax it somehow.
> I found it while working on enabling API tests in CI, I'll have to disable this
> one to avoid false positives.
>
> Kind regards,
> Petr
>
> ./tst_fuzzy_sync01
> tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
> tst_fuzzy_sync01.c:224: TPASS: acs:0  act:0  art:0  | =:101  -:148  +:65  
> tst_fuzzy_sync01.c:224: TPASS: acs:0  act:1  art:0  | =:101  -:0    +:0   
> tst_fuzzy_sync01.c:224: TPASS: acs:1  act:1  art:1  | =:101  -:0    +:0   
> tst_fuzzy_sync01.c:224: TPASS: acs:3  act:1  art:1  | =:101  -:5    +:1   
> ../../include/tst_fuzzy_sync.h:522: TINFO: Minimum sampling period ended
> ../../include/tst_fuzzy_sync.h:345: TINFO: loop = 10000, delay_bias = 0
> ../../include/tst_fuzzy_sync.h:333: TINFO: start_a - start_b: { avg =   -17ns, avg_dev =     4ns, dev_ratio = 0.25 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: end_a - start_a  : { avg = 20773ns, avg_dev =  4714ns, dev_ratio = 0.23 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: end_b - start_b  : { avg = 20849ns, avg_dev =  4710ns, dev_ratio = 0.23 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: end_a - end_b    : { avg =   -94ns, avg_dev =    24ns, dev_ratio = 0.26 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: spins            : { avg =    54  , avg_dev =    17  , dev_ratio = 0.31 }
> ../../include/tst_fuzzy_sync.h:684: TINFO: Exceeded execution loops, requesting exit
> tst_fuzzy_sync01.c:224: TFAIL: acs:3  act:1  art:1  | =:0    -:1    +:2999999
> ../../include/tst_fuzzy_sync.h:522: TINFO: Minimum sampling period ended
> ../../include/tst_fuzzy_sync.h:345: TINFO: loop = 10000, delay_bias = 0
> ../../include/tst_fuzzy_sync.h:333: TINFO: start_a - start_b: { avg =   -18ns, avg_dev =     8ns, dev_ratio = 0.46 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: end_a - start_a  : { avg = 21475ns, avg_dev =  4558ns, dev_ratio = 0.21 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: end_b - start_b  : { avg = 19960ns, avg_dev =  4702ns, dev_ratio = 0.24 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: end_a - end_b    : { avg =  1497ns, avg_dev =  1956ns, dev_ratio = 1.31 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: spins            : { avg =    43  , avg_dev =    17  , dev_ratio = 0.39 }
> ../../include/tst_fuzzy_sync.h:684: TINFO: Exceeded execution loops, requesting exit
> tst_fuzzy_sync01.c:224: TFAIL: acs:1  act:1  art:3  | =:3    -:2999996 +:1   
> ../../include/tst_fuzzy_sync.h:522: TINFO: Minimum sampling period ended
> ../../include/tst_fuzzy_sync.h:345: TINFO: loop = 10000, delay_bias = 0
> ../../include/tst_fuzzy_sync.h:333: TINFO: start_a - start_b: { avg =  1529ns, avg_dev =  1930ns, dev_ratio = 1.26 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: end_a - start_a  : { avg = 18630ns, avg_dev =  4565ns, dev_ratio = 0.25 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: end_b - start_b  : { avg =  8430ns, avg_dev =  4163ns, dev_ratio = 0.49 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: end_a - end_b    : { avg = 11729ns, avg_dev =  2725ns, dev_ratio = 0.23 }
> ../../include/tst_fuzzy_sync.h:333: TINFO: spins            : { avg =  6115  , avg_dev =    33  , dev_ratio = 0.01 }
> ../../include/tst_fuzzy_sync.h:684: TINFO: Exceeded execution loops, requesting exit
> ...

It looks like the CI machines are too noisy/contended. The avg_dev is
very high. Probably we could relax the dev_ratio threshold to 0.2 or
0.3. Although we would still get failures occassionally. As this is a
probabalistic test.

Could you change the script so that it passes so long as the test
returns TPASS or TFAIL?

We don't want TBROK, TCONF or no result.

-- 
Thank you,
Richard.
