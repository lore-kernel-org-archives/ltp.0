From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 Mar 2019 17:52:01 +0100
Subject: [LTP] [PATCH v3 1/2] rt_sigpending02: reuse code from
 sigpending02
In-Reply-To: <20190319164416.GA14664@dell5510>
References: <20190308163832.212631-1-maennich@google.com>
 <20190319113153.13436-1-maennich@google.com>
 <20190319113153.13436-2-maennich@google.com>
 <20190319164416.GA14664@dell5510>
Message-ID: <20190319165201.GA29265@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Matthias,

> >  static void run(void)
> > @@ -24,20 +28,26 @@ static void run(void)
> >  	/* set sigset to point to an invalid location */
> >  	sigset_t *sigset = (sigset_t *) - 1;
> There is (undocumented) library helper tst_get_bad_addr() which might bring some
> arch portability.
Sorry, this was added long time ago, not by you + you're going to remove it in
the next commit.

Kind regards,
Petr
