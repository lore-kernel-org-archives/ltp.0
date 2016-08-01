From: Li Wang <liwang@redhat.com>
Date: Mon, 1 Aug 2016 18:37:21 +0800
Subject: [LTP] [PATCH v2] swapping: replace mem_free by mem_available
In-Reply-To: <799714053.10227172.1470045890634.JavaMail.zimbra@redhat.com>
References: <1470040135-26072-1-git-send-email-liwang@redhat.com>
 <799714053.10227172.1470045890634.JavaMail.zimbra@redhat.com>
Message-ID: <20160801103721.GC20856@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 01, 2016 at 06:04:50AM -0400, Jan Stancek wrote:
> 
> ----- Original Message -----
> > +
> > +	/* at least 10MB available physical memory needed */
> > +	if (mem_available_init < 10240)
> >  			tst_brkm(TCONF, cleanup,
> > -				 "Not enough free memory to test.");
> > -	}
> > -	if (swap_free_init < mem_over)
> > -		tst_brkm(TCONF, cleanup, "Not enough swap space to test.");
> > +				 "Not enough avalable memory to test.");
> > +
> > +	if (swap_total < mem_over_max)
> > +		tst_brkm(TCONF, cleanup, "swap size is not fit to test");
> 
> Shouldn't this be "swap_free_init > mem_over_max"? Some of the swap
> can be used at the start of test and condition below compares the
> difference from initial value.

sure, that would be more precise.

> > -		}
> > +	i = 0;
> > +	while (i < 10) {
> > +		swap_free_now = read_meminfo("SwapFree:");
> >  		sleep(1);
> > +		if (abs(swap_free_now - read_meminfo("SwapFree:")) < 512)
> > +			break;
> > +
> > +		i++;
> >  	}
> > +
> 
> I'd probably add here:
>   swap_free_now = read_meminfo("SwapFree:");
> again, since current value can be stale.

Ok, agree your point. Thanks for reviewing.

Regards,
Li Wang
