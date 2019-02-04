From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 4 Feb 2019 11:56:29 +0000
Subject: [LTP] [PATCH v3] memcg_stress_test.sh: ported to newlib
In-Reply-To: <20190201134537.GA17626@x230>
References: <20190104105407.48123-1-cristian.marussi@arm.com>
 <20190104105407.48123-2-cristian.marussi@arm.com>
 <20190128163207.GA26834@dell5510> <20190129175019.GA14252@dell5510>
 <VI1PR08MB31815A4CF9A142A5B8A5E69F9E970@VI1PR08MB3181.eurprd08.prod.outlook.com>
 <20190201134537.GA17626@x230>
Message-ID: <c328de8d-418f-d81e-910a-890e6639af6c@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

On 01/02/2019 13:45, Petr Vorel wrote:
> Hi Cristian,
> 
>> Thanks for the review and the cleanup. (next I was going to rework following your today's advises, but you've been faster...)
> I'm sorry, I'll be patient next time :).
> I was thinking to add these changes to your commit and merge patchset,
> but as I introduced 2 regressions in your patchset last time (I test it of
> course), I was careful.
> 
>> I'll test asap.
> Thanks a lot!

Tested from you branch with ToT as:

10df48aa7 (HEAD -> pevik_ltp/christian/memcg_stress_test.sh.v3.fixes)
memcg_stress_test.sh: fix memory usage
ebd6efaa6 memcg_stress_test.sh: Further cleanup
02c520928 memcg_stress_test.sh: ported to newlib
fc544f842 controllers/mem_process.c: Fix comparison warning
...

on 4k/64k pages defocnfig....looks fine to me.

Thanks a lot for the cleanup.

Regards

Cristian

> 
> 
> Kind regards,
> Petr
> 

