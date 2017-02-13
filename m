From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 13 Feb 2017 08:33:52 -0500 (EST)
Subject: [LTP] [PATCH] mmap16: extend checkpoint wait time during fs fill
In-Reply-To: <20170213100234.GD16973@rei.lan>
References: <793ef4af0e7bb8827b5d2bd04321267ad530ed55.1486733825.git.jstancek@redhat.com>
 <20170213100234.GD16973@rei.lan>
Message-ID: <1957234398.3738860.1486992832599.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 13 February, 2017 11:02:34 AM
> Subject: Re: [LTP] [PATCH] mmap16: extend checkpoint wait time during fs fill
> 
> Hi!
> > +
> > +	/* Give parent enough time to consume FS free blocks */
> > +	if (tst_checkpoint_wait(0, 60*1000))
> > +		tst_brkm(TBROK | TERRNO, cleanup,
> > +			"wait for parent to fill entire space");
> 
> Hrm, I wonder why I hardcoded the timeout into the library. It would be
> much better if we could have used the safe variant here.
> 
> What about we add TST_SAFE_CHECKPOINT_WAIT2() that would take a timeout
> parameter. Pretty much the same as we do for WAKE2 that takes a number
> of processes to wake as a paramter.

Fine by me. Can you push it?
I can rebase & push patch using new TST_SAFE_CHECKPOINT_WAIT2().

Regards,
Jan
