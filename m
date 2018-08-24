From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 24 Aug 2018 05:09:06 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls: Add set_mempolicy numa tests.
In-Reply-To: <20180823135457.15806-1-chrubis@suse.cz>
References: <20180823135457.15806-1-chrubis@suse.cz>
Message-ID: <1686534238.42299708.1535101746576.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> This is initial attempt to replace numa.sh tests that despite having
> been fixed several times have still many shortcommings that wouldn't be
> easy to fix. It's not finished nor 100% replacement but I'm sending this
> anyway because I would like to get feedback at this point.
> 
> The main selling points of these testcases are:
> 
> The memory allocated for the testing is tracked exactly. We are using
> get_mempolicy() with MPOL_F_NODE | MPOL_F_ADDR that returns the node ID on
> which specified address is allocated on to count pages allocated per node
> after
> we set desired memory policy.
> 
> The tests for file based shared interleaved mappings are no longer
> mapping a single small file but rather than that we accumulate statistic
> for larger amount of files over longer period of time and we also allow
> for small offset (currently 10%). We should probably also increase the
> number of samples we take as currently it's about 5MB in total on x86
> although I haven't managed to make this test fail so far. This also
> fixes the test on Btrfs where the synthetic test that expects the pages
> to be distributed exactly equally fails.
> 
> What is not finished is compilation without libnuma, that will fail
> currently, but that is only a matter of adding a few ifdefs. And the
> coverage is still lacking, ideas for interesting testcases are welcomed
> as well.
> 
> I tested this testcases back to SLES11, which is basically the oldest
> distribution we really care for and everything was working fine.
> 

I don't have objections to this approach. Just want to re-iterate, that
we should also check each node has enough free memory. Couple comments below:

<snip>

+static void inc_counter(unsigned int node, struct tst_nodemap *nodes)
+{
+        unsigned int i;
+
+        for (i = 0; i < nodes->cnt; i++) {
+                if (nodes->map[i] == node) {
+                        nodes->counters[i]++;
+                        break;
+                }

I'd add some check here to warn or TBROK, in case we somehow end up with node id
that's not in the map.

> +void tst_numa_alloc_parse(struct tst_nodemap *nodes, const char *path,
> +                          unsigned int pages)
> +{
> +	size_t page_size = getpagesize();
> +	char *ptr;
> +	int fd = -1;
> +	int flags = MAP_PRIVATE|MAP_ANONYMOUS;
> +	int node;
> +	unsigned int i;
> +
> +	if (path) {
> +		fd = SAFE_OPEN(path, O_CREAT | O_EXCL | O_RDWR, 0666);
> +		SAFE_FTRUNCATE(fd, pages * page_size);
> +		flags = MAP_SHARED;
> +	}
> +
> +	ptr = SAFE_MMAP(NULL, pages  * page_size,
> +	                PROT_READ|PROT_WRITE, flags, fd, 0);
> +
> +	if (path) {
> +		SAFE_CLOSE(fd);
> +		SAFE_UNLINK(path);
> +	}
> +
> +	memset(ptr, 'a', pages * page_size);
> +
> +	for (i = 0; i < pages; i++) {
> +		get_mempolicy(&node, NULL, 0, ptr + i * page_size, MPOL_F_NODE |
> MPOL_F_ADDR);
> +
> +		if (node < 0 || (unsigned int)node >= nodes->cnt) {
> +			tst_res(TWARN, "get_mempolicy(...) returned invalid node %i\n", node);
> +			continue;
> +		}
> +
> +		inc_counter(node, nodes);
> +	}

This seems useful as a separate function, for example: tst_nodemap_count_area(ptr, size).
Maybe the user wants to count already allocated area.

> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
> + * We are testing set_mempolicy() with MPOL_BIND and MPOL_PREFERRED.

> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> + * We are testing set_mempolicy() with MPOL_BIND and MPOL_PREFERRED backed
> by a file.

First and third test look very similar, any chance we can combine them?

Regards,
Jan
