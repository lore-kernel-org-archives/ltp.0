From: Joerg Vehlow <lkml@jv-coder.de>
Date: Fri, 25 Jun 2021 11:24:18 +0200
Subject: [LTP] [PATCH v2 0/3] controllers/memcg: fixes for newer kernels
In-Reply-To: <CAEemH2dqM29Y5s5U2QbeONH30h6aR1B4DZxSnSdowWKSXzfgYQ@mail.gmail.com>
References: <20210617070730.7699-1-krzysztof.kozlowski@canonical.com>
 <bd56facc-55a3-4e8a-4e9d-304d5177462d@canonical.com>
 <CAEemH2dqM29Y5s5U2QbeONH30h6aR1B4DZxSnSdowWKSXzfgYQ@mail.gmail.com>
Message-ID: <0042989e-08b8-88d8-75e5-00c09f6c25bb@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 6/25/2021 10:21 AM, Li Wang wrote:
> On Fri, Jun 25, 2021 at 3:31 AM Krzysztof Kozlowski 
> <krzysztof.kozlowski@canonical.com 
> <mailto:krzysztof.kozlowski@canonical.com>> wrote:
>
>     On 17/06/2021 09:07, Krzysztof Kozlowski wrote:
>
>
>     The patchset got positive LGTM on the Github. Any further comments for
>     it or can it be applied?
>
>
> I slightly agree with Richard that we need an explanation/investigation
> on where the 32*PAGE_SIZE comes from. Otherwise, we are very possible
> to mask a counter bug if only to make the test happy.
+1. I think it has something to do with batch processing of counter updates.
The memory handling code is heavily batched per cpu and only committed 
to a global counter after the batch size overflows.
At least for the subgroup_charge test I once found that page table cache 
stored in kmem contributes to the memory counter used in the test.
Maybe something in that region was changed in recent kernel version. 
Maybe you could ask on the kernel mailing list?


>
> Forgive me pour cold water on the method though it looks good in coding:).
I would just suggest to make 32 * PAGESIZE a constant calculated in 
memcg_lib.sh, instead of calculating (and defining) it everywhere.
>
> -- 
> Regards,
> Li Wang
>
J?rg
