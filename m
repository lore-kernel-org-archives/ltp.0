From: Julio Cruz Barroso <julio.cruz@smartmatic.com>
Date: Wed, 13 Apr 2016 01:17:08 +0000
Subject: [LTP] [PATCH-v2] getrusage03: check available memory and move
 initial allocation out test loop
In-Reply-To: <20160412155852.GC2917@rei.suse.cz>
References: <1460023301-25626-1-git-send-email-jcsistemas2001@gmail.com>
 <20160412155852.GC2917@rei.suse.cz>
Message-ID: <AF04265A3FC2B144B9892F621A394E13EA442CE6@tethys>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, thanks for your revision. I will send a new revision taking your suggestion.


> -----Original Message-----
> From: Cyril Hrubis [mailto:chrubis@suse.cz]
> Sent: Tuesday, April 12, 2016 11:59 PM
> To: Julio Cruz
> Cc: Julio Cruz Barroso; ltp@lists.linux.it; Jan Stancek
> Subject: Re: [LTP] [PATCH-v2] getrusage03: check available memory and move
> initial allocation out test loop
> 
> Hi!
> > +	tst_resm(TINFO, "Available memory: %ldMB\n",
> get_available_memory_mb());
>                                                  ^
> 				The tst_resm() and tst_brkm() functions
> 				adds newline at the end of output
> 				automatically. The '\n' here would
> 				produce empty lines in output.
> 
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
