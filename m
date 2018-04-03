From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 3 Apr 2018 09:23:12 +0200
Subject: [LTP] [RFC PATCH v2 0/3] Rewritting network tests into new
	shell API
In-Reply-To: <be13578b-33b1-09cd-b824-eb7aec79a800@oracle.com>
References: <20180329233134.24151-1-pvorel@suse.cz>
 <5df04eac-2ce5-7628-4bbf-8a34e51fc10e@oracle.com>
 <20180330235943.GA17279@x230>
 <be13578b-33b1-09cd-b824-eb7aec79a800@oracle.com>
Message-ID: <20180403072311.j6k7nusnh7yoxn5v@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

again, thanks for your comments.

...
> > tst_run() is the biggest change in the behavior, which complicates migrating of
> > testscripts/network.sh. I haven't figured out, what would be an elegant way to move it and
> > I'd prefer to migrate it into new version. Not sure whether we'd like to add part of
> > "network_settings" execution to tst_run() for tst_net.sh and thus to be run twice (once
> > by testscripts/network.sh and then by test which is called by testscripts/network.sh).

> > Now I see the best would be move this "network_settings" stuff into new called function
> > tst_net_run() which would set it and at the end call tst_run() + remove sourcing
> > test_net.sh in testscripts/network.sh (only testing script would load it and call
> > tst_net_run() at the end instead of tst_run()).

> Hi Petr,

> I think we need to add a new flag, similar to LTP C library that can
> define TST_NO_DEFAULT_MAIN, i.e. we could add TST_NO_DEFAULT_RUN in
> the tst_test.sh.

I was thinking about it as well, while trying to implement it.

ATM network.sh is for handling getopts and setting environment variables. I was even
thinking whether
1) get rid of it at all
2) have network settings as "first test". This is the concept of tst_net_run(), I
described previously.

1) is probably not a good idea, as separation of functions in test_net.sh and using it in
network.sh is probably useful), but sourcing test_net.sh twice and handling correctly
getopts for tst_test.sh make things a bit complicated.

I'll try to come up with some solution in v3 (+ rename tests, as I wrote).

> >> Can we run a test without them temporary, without tst_run(),
> >> e.g. define some stubs and old API with the new one in
> >> tst_net.sh?
> > Do you mean to move all network scripts to new API, using these "shim" in tst_net.sh?
> > I'd prefer tests were really using new API (to benefit from it), I just don't want to
> > migrate all tests at once. This can be dangerous trying to implement new API functions in
> > legacy one.> That's why I implemented in tst_net.sh functions starting with underscore which choose the

> It's better to place underscore in the end of a function.
OK, I changed them.
I used them at the beginning as the same is for kernel / glibc internal (well, they have
it doubled).
I hope the migration of all network scripts will not take months, so it should be something temporary.

> > implementation via $TST_USE_LEGACY_API. I wanted to ony tst_net.sh itself using it.

> Thanks,
> Alexey


Kind regards,
Petr
