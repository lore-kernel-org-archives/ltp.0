From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Mar 2019 16:45:12 +0100
Subject: [LTP] [ltp][PATCH v3] Add ltp pivot_root test
In-Reply-To: <20190319091136.GC26794@dell5510>
References: <20190305184455.93440-1-paullawrence@google.com>
 <20190319091136.GC26794@dell5510>
Message-ID: <20190319154512.GA13486@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +#else
> > +static void run(void)
> > +{
> > +	tst_brk(TCONF, NULL, "unshare is undefined.");
> Here NULL is copy paste error (that cleanup parameter is from legacy API, here
> suppress the message).
> We use TST_TEST_TCONF for cases like this.
> + Please guard everything, otherwise we get "defined but not used".

That is what I was going to suggest guard the whole test into #ifdef for
libcap and unshare, there is no point in doing anything else if the test
cannot run without these.

-- 
Cyril Hrubis
chrubis@suse.cz
