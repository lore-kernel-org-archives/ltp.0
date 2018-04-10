From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Apr 2018 17:18:42 +0200
Subject: [LTP] [RFC PATCH v6 0/7] Rewriting network tests into new shell
	API
In-Reply-To: <f7a1ec8a-471e-1dcd-83d7-e3df59d6c201@oracle.com>
References: <20180406123118.21309-1-pvorel@suse.cz>
 <f7a1ec8a-471e-1dcd-83d7-e3df59d6c201@oracle.com>
Message-ID: <20180410151842.6hb2ztrfqzfelbfj@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Hi Petr,

> three times... does it happen after these patches?

> It's sourced by the helper to export the environment variables and export
> the variables that are not yet set, so once here.

> And each of the tests sources it once as well...

Sorry, ignore this. It's just me realized obvious thing, that helper is optional.
I explained it more in
https://lists.linux.it/pipermail/ltp/2018-April/007681.html


> > For further development I'd like to move network setup from
> > testscripts/network.sh to tst_net.sh to function tst_net_run(). This
> > would allow to run tests with runltp (and keep our
> > testscripts/network.sh helper). That would reduce one user of
> > tst_net.sh.
> > Another benefit I see to have unique way to run script (one day there
> > might be runltp replaced by better implementation and I don't want
> > network scripts to be missing it).


> This helper is really optional, I'm not quite follow you here, what
> is the purpose of moving it's setup to tst_net_run()? The tests run
> fine without the helper, and with runltp as well.
As I wrote above, please ignore it.

> For netns and runltp, each test-case flushes interfaces and waits for
> completion of DAD process, I think we could remove this latency by:
Oh yes DAD, it takes some time.

> * checking that interface already has the needed configuration, no need
>   to flush and re-add anything, check that there is no xfrm policy, etc.
> * may be save temp configuration in a file on the first test-case run and
>   source it for the next test-cases

> * pass nodad when setting IPv6 addresses
If the this is safe, that could be easiest to implement.


Kind regards,
Petr

> Thanks,
> Alexey
