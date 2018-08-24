From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Aug 2018 14:10:20 +0200
Subject: [LTP] [PATCH v2] syscalls: Add set_mempolicy numa tests.
In-Reply-To: <1686534238.42299708.1535101746576.JavaMail.zimbra@redhat.com>
References: <20180823135457.15806-1-chrubis@suse.cz>
 <1686534238.42299708.1535101746576.JavaMail.zimbra@redhat.com>
Message-ID: <20180824121020.GB17072@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I don't have objections to this approach. Just want to re-iterate, that
> we should also check each node has enough free memory. Couple comments below:

Yes, that is still missing here.

> +static void inc_counter(unsigned int node, struct tst_nodemap *nodes)
> +{
> +        unsigned int i;
> +
> +        for (i = 0; i < nodes->cnt; i++) {
> +                if (nodes->map[i] == node) {
> +                        nodes->counters[i]++;
> +                        break;
> +                }
> 
> I'd add some check here to warn or TBROK, in case we somehow end up with node id
> that's not in the map.

Well I do that in the tst_numa_alloc_parse() but I agree that this is a
more logical place to do the check.

> > +void tst_numa_alloc_parse(struct tst_nodemap *nodes, const char *path,
> > +                          unsigned int pages)
> > +{
> > +	size_t page_size = getpagesize();
> > +	char *ptr;
> > +	int fd = -1;
> > +	int flags = MAP_PRIVATE|MAP_ANONYMOUS;
> > +	int node;
> > +	unsigned int i;
> > +
> > +	if (path) {
> > +		fd = SAFE_OPEN(path, O_CREAT | O_EXCL | O_RDWR, 0666);
> > +		SAFE_FTRUNCATE(fd, pages * page_size);
> > +		flags = MAP_SHARED;
> > +	}
> > +
> > +	ptr = SAFE_MMAP(NULL, pages  * page_size,
> > +	                PROT_READ|PROT_WRITE, flags, fd, 0);
> > +
> > +	if (path) {
> > +		SAFE_CLOSE(fd);
> > +		SAFE_UNLINK(path);
> > +	}
> > +
> > +	memset(ptr, 'a', pages * page_size);
> > +
> > +	for (i = 0; i < pages; i++) {
> > +		get_mempolicy(&node, NULL, 0, ptr + i * page_size, MPOL_F_NODE |
> > MPOL_F_ADDR);
> > +
> > +		if (node < 0 || (unsigned int)node >= nodes->cnt) {
> > +			tst_res(TWARN, "get_mempolicy(...) returned invalid node %i\n", node);
> > +			continue;
> > +		}
> > +
> > +		inc_counter(node, nodes);
> > +	}
> 
> This seems useful as a separate function, for example: tst_nodemap_count_area(ptr, size).
> Maybe the user wants to count already allocated area.

Sure.

> > +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
> > + * We are testing set_mempolicy() with MPOL_BIND and MPOL_PREFERRED.
> 
> > +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> > + * We are testing set_mempolicy() with MPOL_BIND and MPOL_PREFERRED backed
> > by a file.
> 
> First and third test look very similar, any chance we can combine them?

I doubt so, the main difference is that the third test allocates the
memory by faulting memory mapped file and hence it's executed with
all_filesystems flag, while the the first one works only with anonymous
memory.

I guess that we may put some pieces of the code to a shared library
though.

-- 
Cyril Hrubis
chrubis@suse.cz
