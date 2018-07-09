From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 9 Jul 2018 19:07:54 +0200
Subject: [LTP] [PATCH] memcg/memcg_subgroup_charge: Fix out of memory
In-Reply-To: <b663391f-40bb-a2ef-532e-45375961b400@linux.alibaba.com>
References: <1530783438-9860-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180704140748.nmpe7ewhyne575v2@dell5510>
 <b663391f-40bb-a2ef-532e-45375961b400@linux.alibaba.com>
Message-ID: <20180709170754.5qdgdkt2ojtovt2h@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

[snip]
> > BTW some of these tests fail on recent kernel even after these 2 fixes.
> > They work well on 3.10, but on 4.x fail at least.

> > Some of the issues has been reported:
> > * memcg_stat_test.sh
> > memcg_stat_test 6 TFAIL: hierarchical_memory_limit is 4096, 8192 expected
> > memcg_stat_test 2 TFAIL: mapped_file is 0, 4096 expected
> > https://github.com/linux-test-project/ltp/issues/326

> > * memcg_usage_in_bytes_test.sh
> > memcg_usage_in_bytes_test 1 TFAIL: memory.usage_in_bytes is 4325376, 4194304 expected
> > https://github.com/linux-test-project/ltp/issues/326

> > * memcg_use_hierarchy_test.sh
> > memcg_use_hierarchy_test 2 TFAIL: echo 1 > memory.use_hierarchy passed unexpectedly
> > https://github.com/linux-test-project/ltp/issues/93

> The last one sounds unrelated to those two fixes.
Yes, it's just related to memcg_* tests.

> Yang


Kind regards,
Petr
