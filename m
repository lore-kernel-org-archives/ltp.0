From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 May 2017 12:42:23 +0200
Subject: [LTP] TWARN and "ltp-pan reported PASS"
In-Reply-To: <20170517134131.GA21784@rei.lan>
References: <20170509120935.q2v6dqhwmecy265w@dell5510>
 <20170510090428.GC29838@rei.suse.de>
 <20170510101533.zu7x642tzfn73u4v@dell5510>
 <20170517134131.GA21784@rei.lan>
Message-ID: <20170518104222.wqcnc3eykmhxo24b@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Looks like I've haven't been clear enough. The ltp-pan mapped any
> non-zero test exit value to a failure. Partly becasuse there were (and
> possibly still may be some) testcases that do not use LTP exit bitflags
> and partly because ltp-pan predates LTP, at least that's what I remeber
> from some CVS archeology.

> Then we added special support for the TCONF exit status, since otherwise
> skipped testcases were listed as failed as well.

> So yes the TWARN still maps to a failure in ltp-pan and we use TWARN
> mostly for non-fatal (to the test execution) failures, mostly in test
> cleanups. Is that clear enough?

Thanks for an explanation.
I still wish TWARN wouldn't be considered as error (and find and fix these tests which
don't exit bitflags). And I don't wouldn't like to introduce some kind of soft warning flag,
which would lead to exit 0 which could be an alternative solution.


Kind regards,
Petr
