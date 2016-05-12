From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 May 2016 11:14:57 +0200
Subject: [LTP] [PATCH 2/2] pause01: rewrite testcase
In-Reply-To: <1517175101.1991600.1463044297830.JavaMail.zimbra@redhat.com>
References: <b1cd0d1691b4d5416fdc34dd6b35dee1b7909a7c.1462968075.git.jstancek@redhat.com>
 <95ff9c04f7d84a25fc19697a20e96b870f3c65ca.1462968075.git.jstancek@redhat.com>
 <20160511132136.GE24701@rei.lan>
 <1517175101.1991600.1463044297830.JavaMail.zimbra@redhat.com>
Message-ID: <20160512091456.GA31561@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > -static void go(int sig)
> > > -{
> > > -	(void)sig;
> > > +	/*
> > > +	 * TST_CHECKPOINT_WAIT has built-in timeout, if pause() doesn't return,
> > > +	 * this checkpoint call will reliably end the test.
> > > +	 */
> > > +	TST_CHECKPOINT_WAIT(0);
> > > +	SAFE_WAIT(&status);
> > 
> > Hmm, maybe it would be better if we add timeout logic to the new test
> > library instead of adding it to selected few testcases.
> 
> I pushed it with all your suggestions, except for the timeout logic.
> 
> Did you have something specific in mind how to implement this?
> My first thought was a new field to tst_test struct, and forking
> a watchdog process.

I was thinking of forking watchdog process for every test since you
cannot really tell which testcases will block. Then have defined default
timeout in the test library with possible override in the tst_test
structure. But perhaps this is too heavy approach, I will have to
measure how much will this slow down the test execution.

-- 
Cyril Hrubis
chrubis@suse.cz
