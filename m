From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Aug 2018 15:18:19 +0200
Subject: [LTP] [PATCH] [RFC] [WORK-IN-PROGRESS] syscalls: Add
 set_mempolicy numa tests.
In-Reply-To: <87r2j24oby.fsf@rpws.prws.suse.cz>
References: <20180809152308.18982-1-chrubis@suse.cz>
 <87r2j24oby.fsf@rpws.prws.suse.cz>
Message-ID: <20180814131818.GD22915@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > + * nodemap counters. We also make sure that only the newly allocated pages are
> > + * accounted for correctly, which requires forking a separate process to
> 
> I think you mean that only newly allocated pages are counted?
> (i.e. previously allocated pages are ignored). The above implies that
> previously allocated pages are accounted for incorrectly.

It should say something "We also make sure only and only the pages we
allocated for the test are accounted for." or something similar.

> > +static void store_val(unsigned int node, unsigned int val,
> > +                      struct tst_nodemap *nodes)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i = 0; i < nodes->cnt; i++) {
> > +		if (nodes->map[i] == node) {
> > +			nodes->counters[i] += val;
> 
> Maybe this should be called inc_counter or similar? Because you are
> doing += not =.

Given that there are multiple counters, best name would probably be
inc_counters().

> > +			break;
> > +		}
> > +	}
> > +
> > +//	tst_res(TINFO, "Node %u allocated %u pages", node, val);
> > +}
> > +
> > +static void parse_line(char *line, struct tst_nodemap *nodes)
> > +{
> > +	char *c;
> > +	int state = 0;
> > +	int node;
> > +	int val;
> > +
> > +	for (c = line; *c && *c != '\n'; c++) {
> > +
> > +		if (state == 0 && *c == 'N') {
> > +			state = 1;
> > +			continue;
> > +		}
> 
> We need to skip the file path because N3=1.txt is a valid file name.
> Unless it is guaranteed we will never parse a line with that file name
> in it.

Theoretically it's possible, but very unlikely since our process would
have to open such silly named file somewhere in the libc library without
our knowledge. But anyways it looks like Jan has much better way of
figuring out on which node are pages allocated on, so I will probably go
with that in v2.

> > +void tst_numa_alloc_parse(struct tst_nodemap *nodes, const char *path,
> > +                          unsigned int pages)
> > +{
> > +	size_t page_size = getpagesize();
> > +	char *ptr;
> > +	int fd = -1;
> > +	int flags = MAP_PRIVATE|MAP_ANONYMOUS;
> 
> It might be useful to ensure nodes are allocated here by calling
> reset_counters if they are not. On the other hand I am not sure this
> makes sense with the current usage.

Actually it does not, since certain tests accumulate the statistic over
several allocatings, so this is supposed to be called in loop while we
gather statistic in the counters.

-- 
Cyril Hrubis
chrubis@suse.cz
