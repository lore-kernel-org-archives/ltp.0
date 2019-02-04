From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Feb 2019 00:34:35 +0100
Subject: [LTP] [PATCH v3] memcg_stress_test.sh: ported to newlib
In-Reply-To: <c328de8d-418f-d81e-910a-890e6639af6c@arm.com>
References: <20190104105407.48123-1-cristian.marussi@arm.com>
 <20190104105407.48123-2-cristian.marussi@arm.com>
 <20190128163207.GA26834@dell5510> <20190129175019.GA14252@dell5510>
 <VI1PR08MB31815A4CF9A142A5B8A5E69F9E970@VI1PR08MB3181.eurprd08.prod.outlook.com>
 <20190201134537.GA17626@x230>
 <c328de8d-418f-d81e-910a-890e6639af6c@arm.com>
Message-ID: <20190204233435.GA14637@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cristian,

> Tested from you branch with ToT as:

> 10df48aa7 (HEAD -> pevik_ltp/christian/memcg_stress_test.sh.v3.fixes)
> memcg_stress_test.sh: fix memory usage
> ebd6efaa6 memcg_stress_test.sh: Further cleanup
> 02c520928 memcg_stress_test.sh: ported to newlib
> fc544f842 controllers/mem_process.c: Fix comparison warning
> ...

> on 4k/64k pages defocnfig....looks fine to me.

> Thanks a lot for the cleanup.
Thanks a lot for testing!
Pushed (with your Tested-by on my commit).

I did few cleanup changes in my commit (TINFO messages, fix missing local pid, redirect
stderr for wait to make it quiet, move TPASS message into run_stress()).

I wonder how to suppress kill message for the first cgroup pid:
/opt/ltp/testcases/bin/memcg_stress_test.sh: line 65: 14750 User defined signal 1   memcg_process_stress $mem_size $interval

This pid is the only one killed by -USR1, but line 65 is not in fist kill loop.
Therefore it cannot be killed by -KILL (second kill loop).

Kind regards,
Petr

