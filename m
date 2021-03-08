From: Joerg Vehlow <lkml@jv-coder.de>
Date: Mon, 8 Mar 2021 09:07:15 +0100
Subject: [LTP] [PATCH] memcg: memcg_subgroup_charge.sh: Fix the parent
 memory limit
In-Reply-To: <20210305222714.257839-1-msys.mizuma@gmail.com>
References: <20210305222714.257839-1-msys.mizuma@gmail.com>
Message-ID: <a47ecbd7-ba4a-ff2c-ead9-e731040cb845@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 3/5/2021 11:27 PM, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>
> memcg_subgroup_charge.sh fails on v5.9 and later kernel.
> That's because memory.limit_in_bytes isn't set the suitable value
> so mem_process is killed by OOM accidentally.
>
> The memory.limit_in_bytes is now wrong value because commit
> 3e38e0aaca9e ("mm: memcg: charge memcg percpu memory to the parent cgroup")
> changed the charging memory usage. The percpu memory, which is
> needed to create the subgroup, is charged to the parent's usage.
>
> Since we can get the amount of the percpu memory as memory.usage_in_bytes
> after the subgroup is created, extend the limit to limit_in_bytes + usage_in_bytes.
Sounds reasonable, I guess the test always fails on 5.9?
But the problem is, this test also fails on older kernels sometimes. 
When I looked at this the last time, I thought it was because sometimes 
the kernel requires new pages for the page table and that is also taken 
into account for the memory limit.
I still don't know why the test even sets a limit for the parent group 
and would vote for completely removing the memory setting on the parent.

J?rg

