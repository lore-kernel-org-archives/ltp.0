From: Michael Moese <mmoese@suse.de>
Date: Tue, 23 Jan 2018 10:16:16 +0100
Subject: [LTP] [RFC PATCH] Add library support for
 /proc/sys/kernel/tainted
In-Reply-To: <20180122153942.GA17451@rei>
References: <20180122131218.26407-1-mmoese@suse.de>
 <20180122153942.GA17451@rei>
Message-ID: <20180123091616.cc4gafw65z7evrb5@linux.suse>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,

On Mon, Jan 22, 2018 at 04:39:42PM +0100, Cyril Hrubis wrote:

> This patch lacks information on how this API is supposed to be used
> which is quite important for the review. What I mean is that, while
> important, the documentation for the function parameters and return
> values is not enough. What should be included is some sketch code of
> this is supposed to be used from an actual test source.

Agree. I will spend more effort on the documentation before
submitting again.


> These messages should go out via tst_res().
Agreed.

> We have tst_kvercmp() exactly for this purpose, see include/tst_kvercmp.h
Well, I tried to find this. But somehow I failed :) Thanks for pointing 
this out.

 
> > +	return taint_supported;
> > +}
> > +
> > +unsigned int tst_taint_read(void)
> > +{
> > +	int fd;
> > +	unsigned int val;
> > +	char buffer[11];
> > +
> > +	if (taint_supported == -1)
> > +		tst_taint_supported();
> 
> So this will only cause warning to be printed into the stderr, then we
> go ahead and read the file? Shouldn't we just tst_brk(TCONF, "") at this
> point?
> 
> > +	return val;
> > +}
> > +
> > +int tst_taint_check_mask(unsigned int taint, unsigned int mask)
> > +{
> > +	if ((taint & mask) != 0)
> > +		return 1;
> > +	return 0;
> > +}
> 
> Hmm, should this be combined with the read function?
I had this consideration. But maybe someone needs to compare the flags 
for two points in time, and just check if the mask matched the delta. 
In this case, doing a implicit read would not be what the user wants.
On the other hand, when this is not needed, we could save a line.

Thanks,
Michael

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
