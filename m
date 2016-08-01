From: Li Wang <liwang@redhat.com>
Date: Mon, 1 Aug 2016 14:43:19 +0800
Subject: [LTP] [PATCH] swapping: replace mem_free by mem_available
In-Reply-To: <1594266875.9316113.1469705306083.JavaMail.zimbra@redhat.com>
References: <1469000896-6122-1-git-send-email-liwang@redhat.com>
 <1594266875.9316113.1469705306083.JavaMail.zimbra@redhat.com>
Message-ID: <20160801064319.GA20856@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 28, 2016 at 07:28:26AM -0400, Jan Stancek wrote:
> 
> 
> > @@ -108,17 +108,17 @@ int main(int argc, char *argv[])
> >  static void init_meminfo(void)
> >  {
> >  	swap_free_init = read_meminfo("SwapFree:");
> > -	mem_free_init = read_meminfo("MemFree:");
> > -	mem_over = mem_free_init * COE_SLIGHT_OVER;
> > -	mem_over_max = mem_free_init * COE_DELTA;
> > -
> > -	/* at least 10MB free physical memory needed */
> > -	if (mem_free_init < 10240) {
> > -		sleep(5);
> > -		if (mem_free_init < 10240)
> > +	if (!FILE_LINES_SCANF(cleanup, "/proc/meminfo", "MemAvailable: %ld",
> > +				&mem_available_init))
> > +		mem_available_init = read_meminfo("MemFree:") + read_meminfo("Cached:");
> > +	mem_over = mem_available_init * COE_SLIGHT_OVER;
> > +	mem_over_max = mem_available_init * COE_DELTA;
> > +
> > +	/* at least 10MB available physical memory needed */
> > +	if (mem_available_init < 10240)
> >  			tst_brkm(TCONF, cleanup,
> > -				 "Not enough free memory to test.");
> > -	}
> > +				 "Not enough avalable memory to test.");
> > +
> >  	if (swap_free_init < mem_over)
> >  		tst_brkm(TCONF, cleanup, "Not enough swap space to test.");
> 
> Hi,
> 
> check_swapping() compares swap increase to mem_over_max. Is bad kernel
> really using that much swap? If so, then condition above looks
> wrong, since it doesn't check that we can fit so much into swap.

Good catch! If the total swap size is smaller than mem_over_max, there
seems no need to run this case, because theoretically it'll always get
PASS on bad kernel.

I'd like to add additional check:

	if (swap_total < mem_over_max)
		tst_brkm(TCONF, cleanup, "swap size is not fit to test");

> 
> >  }
> > @@ -128,8 +128,8 @@ static void do_alloc(void)
> >  	long mem_count;
> >  	void *s;
> >  
> > -	tst_resm(TINFO, "free physical memory: %ld MB", mem_free_init / 1024);
> > -	mem_count = mem_free_init + mem_over;
> > +	tst_resm(TINFO, "available physical memory: %ld MB", mem_available_init /
> > 1024);
> > +	mem_count = mem_available_init + mem_over;
> >  	tst_resm(TINFO, "try to allocate: %ld MB", mem_count / 1024);
> >  	s = malloc(mem_count * 1024);
> >  	if (s == NULL)
> > @@ -160,7 +160,7 @@ static void check_swapping(void)
> >  			tst_brkm(TFAIL, cleanup, "heavy swapping detected: "
> >  				 "%ld MB swapped.", swapped / 1024);
> >  		}
> > -		sleep(1);
> > +		usleep(100000);
> 
> The original code appears to check multiple times to be sure that
> writes to swap have settled. Did you test if shortened delay can still
> detect bug on bad kernel?

I didn't test it with bad kernel. But your worries are necessary, the swap
checker probably spend a long time on big RAM box.

> 
> I was thinking we break the loop if we see no change in swap usage
> for certain period:

Agreed, this method looks more stable. Just have a little query of that.

> 
> i = 0;
> while (i < X) {

How much should the X defined?

>   i++;
>   swapped = read_meminfo("SwapFree:");
>   sleep(1);
>   if (abs(swapped - read_meminfo("SwapFree:")) < 512)

Why set the limitation as 512?  why not 1024 or others?

>     break;
> }
> 
> if (swapped > mem_over_max) {
>   FAIL
> }

Regards,
Li Wang
