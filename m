From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Jul 2020 17:32:05 +0200
Subject: [LTP] [PATCH v2 2/2] Add chdir() test for unprivileged user
In-Reply-To: <08409821-c9d4-d8a6-3393-b33dfa79fea4@suse.cz>
References: <20200724125052.20973-1-mdoucha@suse.cz>
 <20200724125052.20973-2-mdoucha@suse.cz>
 <20200724133247.GC24626@dell5510>
 <08409821-c9d4-d8a6-3393-b33dfa79fea4@suse.cz>
Message-ID: <20200724153205.GA28471@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> >> +++ b/runtest/syscalls
> >> @@ -54,6 +54,7 @@ capset04 capset04
> >>  cacheflush01 cacheflush01

> >>  chdir01 chdir01
> >> +chdir02 chdir02
> >>  chdir01A symlink01 -T chdir01
> >>  chdir04 chdir04
> > You missed to add chdir02 to runtest/quickhit. I guess this was deliberate,
> > right?
> > (I wonder if we really need runtest/quickhit anyway).

> Yes, this was deliberate since only chdir02 was there originally (the
> one that was checking only chdir("/"); and chdir("/etc");.
Understand, thanks for info.

> > I like both tests (nice work, thanks!), just don't like the duplicity. Isn't
> > there a way to use getopt parameter for one of the variants and have just single
> > test? But understand if you don't bother with it (maybe better duplicity but
> > simpler code).

> > Other that that LGTM.
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> I could add a second set of expected values to the test case list and do
> it like this:

> static void run(unsigned int n) {
> 	TEST(chdir(tc->name));
> 	/* result validation here */
> 	SAFE_SETEUID(ltpuser->pw_uid);
> 	TEST(chdir(tc->name));
> 	SAFE_SETEUID(0);
> 	/* result validation here */
> }
LGTM, thank you!

> Should I resubmit that as v3?
Yes, please.

Kind regards,
Petr
