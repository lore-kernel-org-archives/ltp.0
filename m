From: Jozef Pupava <jpupava@suse.cz>
Date: Thu, 26 Mar 2020 11:15:31 +0100
Subject: [LTP] [PATCH 1/2] Update syscalls/fsync02 to new API
In-Reply-To: <20200326083759.GA29830@dell5510>
References: <20200324143837.51d2df15@daedruan>
 <20200326083759.GA29830@dell5510>
Message-ID: <20200326111531.163fab48@daedruan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

I will add return for better readability in second patch.

Jozef

On Thu, 26 Mar 2020 09:37:59 +0100
Petr Vorel <pvorel@suse.cz> wrote:

> Hi Jozef,
> 
> LGTM, thanks for your patch.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > +	if (time_end == -1) {
> > +		tst_res(TFAIL | TTERRNO, "getting end time
> > failed");
> > +	} else if (TST_RET == -1) {
> > +		tst_res(TFAIL | TTERRNO, "fsync failed");
> > +	} else if (TST_RET != 0) {
> > +		tst_res(TFAIL | TTERRNO,
> > +		"fsync failed with unexpected return value");
> > +	} else if (time_end < time_start) {
> > +		tst_res(TFAIL,
> > +		"timer broken end %ld < start %ld",
> > +		time_end, time_start);
> > +	} else if ((time_delta =
> > +		difftime(time_end, time_start)) > TIME_LIMIT) {
> > +		tst_res(TFAIL,
> > +		"fsync took too long: %lf seconds; "
> > +		"max_block: %d; data_blocks: %d",
> > +		time_delta, max_block, data_blocks);
> > +	} else {
> > +		tst_res(TPASS,
> > +		"fsync succeeded in an acceptable amount of time");
> > +	}  
> 
> nit: note Cyril prefers due better readability return from function
> instead of having too much else if. So something like this might be
> more readable. But up to you.
> 
> 	if (time_end == -1) {
> 		tst_res(TFAIL | TTERRNO, "getting end time failed");
> 		return;
> 	}
> 
> 	if (TST_RET == -1) {
> 		tst_res(TFAIL | TTERRNO, "fsync failed");
> 		return;
> 	}
> 
> 	if (TST_RET != 0) {
> 		tst_res(TFAIL | TTERRNO, "fsync failed with
> unexpected return value"); return;
> 	}
> 
> 	if (time_end < time_start) {
> 		tst_res(TFAIL, "timer broken end %ld < start %ld",
> 		time_end, time_start);
> 		return;
> 	}
> 
> 	if ((time_delta = difftime(time_end, time_start)) >
> TIME_LIMIT) { tst_res(TFAIL,
> 		"fsync took too long: %lf seconds; max_block: %d;
> data_blocks: %d", time_delta, max_block, data_blocks);
> 		return;
> 	}
> 
> 	tst_res(TPASS, "fsync succeeded in an acceptable amount of
> time");
> 
> Kind regards,
> Petr
> 

