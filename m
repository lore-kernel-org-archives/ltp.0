From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 3 Jan 2019 06:39:55 -0500 (EST)
Subject: [LTP] [PATCH v3] syscalls: Add set_mempolicy numa tests.
In-Reply-To: <20181218155752.7028-1-chrubis@suse.cz>
References: <20181218155752.7028-1-chrubis@suse.cz>
Message-ID: <728475501.93120973.1546515595304.JavaMail.zimbra@redhat.com>
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
> 
> We also check for free memory on each numa memory mode and skip nodes
> that don't have sufficient amount of memory for a particular test. The
> tests checks usuall for twice as much memory per each node in order to
> allow for allocations to be "misplaced".
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
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Michal Hocko <mhocko@kernel.org>
> CC: Vlastimil Babka <vbabka@suse.cz>
> CC: Jan Stancek <jstancek@redhat.com>

Hi,

> +
> +
> +void tst_numa_alloc_parse(struct tst_nodemap *nodes, const char *path,
> +                          unsigned int pages)

I'd change this to a function that only counts allocated pages,
and increases counters.

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

I think all the alloc stuff shouldn't be in library. It's quite
possible tests will need different ways to allocate memory. 

Maybe the test will want to mmap, but not touch any pages,
or pass different flags to mmap. Allocate with other functions
than mmap, etc.

The rest of API looks good to me.

Regards,
Jan

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
> +
> +	SAFE_MUNMAP(ptr, pages * page_size);
> +}
> +
