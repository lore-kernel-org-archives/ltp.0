From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 7 Feb 2017 11:15:28 -0500 (EST)
Subject: [LTP] [PATCH] getrandom02: relax check for returned data
In-Reply-To: <20170207153352.GB3595@rei.suse.cz>
References: <e8ddadfad4495f90db68d5b714a570daa93b8a82.1486382998.git.jstancek@redhat.com>
 <20170207153352.GB3595@rei.suse.cz>
Message-ID: <1487036067.1086032.1486484128036.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Tuesday, 7 February, 2017 4:33:52 PM
> Subject: Re: [LTP] [PATCH] getrandom02: relax check for returned data
> 
> Hi!
> > +			} else {
> >  				tst_resm(TPASS, "getrandom returned %ld",
> >  						TEST_RETURN);
> > +				tmp = 0;
> > +				for (j = 0; j < TEST_RETURN; j++)
> > +					tmp |= buf[j];
> > +				if (tmp == 0)
> > +					tst_resm(TWARN, "all bytes from random"
> > +						" buffer are zero?");
> 
> This wouldn't for instance when the random output is filled with
> non-zero constant bytes...
> 
> What about just fixing the max value to something as:
> 
> max = 3 + nb * 0.2;
> 
> The constat part should handle cases with small buffer and a few
> repeating characters while for larger buffer it's neglectible.

In that case we may as well skip the check for small buffers.
What size would make reasonably large sample? 64?

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
