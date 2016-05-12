From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 12 May 2016 05:11:37 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] pause01: rewrite testcase
In-Reply-To: <20160511132136.GE24701@rei.lan>
References: <b1cd0d1691b4d5416fdc34dd6b35dee1b7909a7c.1462968075.git.jstancek@redhat.com>
 <95ff9c04f7d84a25fc19697a20e96b870f3c65ca.1462968075.git.jstancek@redhat.com>
 <20160511132136.GE24701@rei.lan>
Message-ID: <1517175101.1991600.1463044297830.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 11 May, 2016 3:21:36 PM
> Subject: Re: [LTP] [PATCH 2/2] pause01: rewrite testcase

> > -static void go(int sig)
> > -{
> > -	(void)sig;
> > +	/*
> > +	 * TST_CHECKPOINT_WAIT has built-in timeout, if pause() doesn't return,
> > +	 * this checkpoint call will reliably end the test.
> > +	 */
> > +	TST_CHECKPOINT_WAIT(0);
> > +	SAFE_WAIT(&status);
> 
> Hmm, maybe it would be better if we add timeout logic to the new test
> library instead of adding it to selected few testcases.

I pushed it with all your suggestions, except for the timeout logic.

Did you have something specific in mind how to implement this?
My first thought was a new field to tst_test struct, and forking
a watchdog process.

Regards,
Jan
