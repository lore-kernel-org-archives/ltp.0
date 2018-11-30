From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 30 Nov 2018 04:46:32 -0500 (EST)
Subject: [LTP] [PATCH v2] mtest06/mmap1: rewrite to newlib
In-Reply-To: <20181129134411.GA22216@rei.lan>
References: <0e62adebbb4e5c8e3aa28440f860234b937d3e56.1543219161.git.jstancek@redhat.com>
 <20181129134411.GA22216@rei.lan>
Message-ID: <2002461812.80702248.1543571192512.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > Instead each mmap/munmap increases a map/unmap counter. Upon hitting
> > SIGSEGV or when comparing read value, these counter values are used
> > to determine state of mapped area as observed by first thread.
> > This isn't 100% accurrate as first thread might be faster than the
> > check, but it allows second thread to race against map/unmap for
> > its entire duration.
> 
> Looks good to me, using atomic counters and comparing values before and
> after we access the memory is very clever as well. You can add my
> Reviewed-by.
> 
> Very minor comments below.
> > +/* compare "before read" counters  with "after read" counters */
> > +static inline int was_area_mapped(int br_m, int br_u, int ar_m, int ar_u)
> > +{
> > +	return (br_m == ar_m && br_u == ar_u && br_m > br_u);
> > +}
> 
> Since the br_map and br_unmap are global I would consider passing only
> the values after to this function.

Hi,

I find it more clear if it doesn't depend on globals. Since it's inlined
there should be no penalty, so I kept it as is.

> > +
> > +void *read_mem(LTP_ATTRIBUTE_UNUSED void *ptr)
> > +{
> > +	int i, j, ar_map, ar_unmap;
> > +	unsigned char c;
> > +
> > +	for (i = 0; i < num_iter; i++) {
> > +		if (setjmp(jmpbuf) == 1)
> > +			continue;

I made 'i' volatile, since longjmp could clobber it.

> > +static void run(void)
> > +{
> > +	pthread_t thid[2];
> > +	long chld_args[1];
> > +	int remaining = tst_timeout_remaining();
> > +	int elapsed = 0;
> > +
> > +	while (tst_timeout_remaining() > STOP_THRESHOLD) {
> > +		int fd = mkfile(file_size);
> > +
> > +		tst_atomic_store(0, &mapcnt);
> > +		tst_atomic_store(0, &unmapcnt);
> > +
> > +		chld_args[0] = fd;
> 
> I would have just casted the fd here to long or intptr_t (to make sure
> compiler padds it with zeroes) then to (void*) and passed the value
> directly, i.e. (void*)(inptr_t)fd and then back in the thread we do
> fd = (intptr_t)ptr.

I changed this to pass int ptr directly, which requires no casts AFAICT.

... and pushed.

Thanks,
Jan
