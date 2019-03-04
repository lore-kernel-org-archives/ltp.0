From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Mar 2019 02:39:22 -0500 (EST)
Subject: [LTP] [PATCH 1/2 v4] syscalls: Add set_mempolicy numa tests.
In-Reply-To: <20190228153425.10286-2-chrubis@suse.cz>
References: <20190228153425.10286-1-chrubis@suse.cz>
 <20190228153425.10286-2-chrubis@suse.cz>
Message-ID: <2092842506.4709417.1551685162547.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> This is initial attempt to replace numa.sh tests that despite having
> been fixed several times have still many shortcommings that wouldn't
> easy to fix. It's not finished nor 100% replacement at this point but it
> should be pretty good start.
> 
> The main selling points of these testcases are:
> 
> The memory allocated for the testing is tracked exactly. We are using
> get_mempolicy() with MPOL_F_NODE | MPOL_F_ADDR that returns the node ID on
> which specified address is allocated on to count pages allocated per node
> after
> we set desired memory policy.

Hi,

> 
> We also check for free memory on each numa memory mode and skip nodes
> that don't have sufficient amount of memory for a particular test. The
> tests checks usuall for twice as much memory per each node in order to
> allow for allocations to be "misplaced".

I wonder if we should add some constant to it. I have foggy idea, that
kernel keeps some reserves.

> 
> The tests for file based shared interleaved mappings are no longer
> mapping a single small file but rather than that we accumulate statistic
> for larger amount of files over longer period of time and we also allow
> for small offset (currently 10%). We should probably also increase the
> number of samples we take as currently it's about 5MB in total on x86
> although I haven't managed to make this test fail so far. This also
> fixes the test on Btrfs where the synthetic test that expects the pages
> to be distributed exactly equally fails.

API looks good to me, ACK. Maybe you could split it into 2 commits, one for
new library API, and one for new tests.

Couple small comments below.

> +
> +void tst_nodemap_count_pages(struct tst_nodemap *nodes,
> +                             void *ptr, size_t size)
> +{
> +	size_t page_size = getpagesize();
> +	unsigned int i;
> +	int node;
> +	unsigned int pages = (size + page_size - 1)/page_size;
> +
> +	for (i = 0; i < pages; i++) {
> +		get_mempolicy(&node, NULL, 0, ptr + i * page_size, MPOL_F_NODE |
> MPOL_F_ADDR);

We should check return value from get_mempolicy here.

> +
> +		if (node < 0 || (unsigned int)node >= nodes->cnt) {
> +			tst_res(TWARN, "get_mempolicy(...) returned invalid node %i\n", node);
> +			continue;
> +		}
> +
> +		inc_counter(node, nodes);
> +	}
> +}
> +

<snip>

> +
> +static void verify_set_mempolicy(unsigned int n)
> +{
> +	struct bitmask *bm = numa_allocate_nodemask();
> +	unsigned int exp_alloc[nodes->cnt];
> +	unsigned int alloc_per_node = n ? 8 : 2;

Can you make this "8" a define, so that "16" above can be derived from it?

> +	unsigned int alloc_on_nodes = n ? 2 : nodes->cnt;
> +	unsigned int alloc_total = alloc_per_node * alloc_on_nodes;
> +	unsigned int i;
> +
> +	memset(exp_alloc, 0, sizeof(exp_alloc));
> +
> +	for (i = 0; i < alloc_on_nodes; i++) {
> +		exp_alloc[i] = alloc_per_node;
> +		numa_bitmask_setbit(bm, nodes->map[i]);
> +	}
> +
> +	TEST(set_mempolicy(MPOL_INTERLEAVE, bm->maskp, bm->size+1));
> +
> +	tst_res(TINFO, "Allocating on nodes 1-%u - %u pages",
> +	        alloc_on_nodes, alloc_total);
> +
> +	if (TST_RET) {
> +		tst_res(TFAIL | TTERRNO,
> +		        "set_mempolicy(MPOL_INTERLEAVE)");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "set_mempolicy(MPOL_INTERLEAVE)");
> +
> +	numa_free_nodemask(bm);
> +
> +	alloc_and_check(alloc_total, exp_alloc);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_set_mempolicy,
> +	.tcnt = 2,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +};
> +
> +#else
> +
> +TST_TEST_TCONF(NUMA_ERROR_MSG);
> +
> +#endif /* HAVE_NUMA_H */
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> new file mode 100644
> index 000000000..a1e7f1eb5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> @@ -0,0 +1,113 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*
> + * We are testing set_mempolicy() with MPOL_BIND and MPOL_PREFERRED backed
> by a
> + * file.

Maybe extend this comment to say it's across all filesystems.

Regards,
Jan
