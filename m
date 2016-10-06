From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 6 Oct 2016 03:24:45 -0400 (EDT)
Subject: [LTP] [PATCH] move_pages04: fix zero page status code for
 kernels >= 4.3
In-Reply-To: <20161005154735.GE23476@rei.lan>
References: <896d677024a4273f2d762aaef1a020c6b08e186b.1475501850.git.jstancek@redhat.com>
 <20161005154735.GE23476@rei.lan>
Message-ID: <1351583701.742495.1475738685339.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 5 October, 2016 5:47:35 PM
> Subject: Re: [LTP] [PATCH] move_pages04: fix zero page status code for kernels >= 4.3
> 
> Hi!
> > -		if (status[UNTOUCHED_PAGE] == -ENOENT)
> > -			tst_resm(TPASS, "status[%d] set to expected -ENOENT",
> > +		if (status[UNTOUCHED_PAGE] == exp_status)
> > +			tst_resm(TPASS, "status[%d] has expected value",
> >  				 UNTOUCHED_PAGE);
> >  		else
> > -			tst_resm(TFAIL, "status[%d] is %d", UNTOUCHED_PAGE,
> > -				 status[UNTOUCHED_PAGE]);
> > +			tst_resm(TFAIL, "status[%d] is %d, expected %d",
> > +				UNTOUCHED_PAGE, status[UNTOUCHED_PAGE],
> > +				exp_status);
> 
> It would be a bit better to print the errno with tst_strerrno() in both
> cases. I.e. tst_strerrno(-exp_status) and
> tst_strerrno(-status[UNTOUCHED_PAGE]) otherwise this looks obviously
> fine.

Pushed with your ack and suggested changes.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
