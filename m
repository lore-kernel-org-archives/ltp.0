From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 May 2017 13:15:51 +0200
Subject: [LTP] TWARN and "ltp-pan reported PASS"
In-Reply-To: <20170518104222.wqcnc3eykmhxo24b@dell5510>
References: <20170509120935.q2v6dqhwmecy265w@dell5510>
 <20170510090428.GC29838@rei.suse.de>
 <20170510101533.zu7x642tzfn73u4v@dell5510>
 <20170517134131.GA21784@rei.lan>
 <20170518104222.wqcnc3eykmhxo24b@dell5510>
Message-ID: <20170518111551.GB29477@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Looks like I've haven't been clear enough. The ltp-pan mapped any
> > non-zero test exit value to a failure. Partly becasuse there were (and
> > possibly still may be some) testcases that do not use LTP exit bitflags
> > and partly because ltp-pan predates LTP, at least that's what I remeber
> > from some CVS archeology.
> 
> > Then we added special support for the TCONF exit status, since otherwise
> > skipped testcases were listed as failed as well.
> 
> > So yes the TWARN still maps to a failure in ltp-pan and we use TWARN
> > mostly for non-fatal (to the test execution) failures, mostly in test
> > cleanups. Is that clear enough?
> 
> Thanks for an explanation.
> I still wish TWARN wouldn't be considered as error (and find and fix these tests which
> don't exit bitflags).

Well before that we would have to review all uses of TWARN in the source
tree, for some TBROK would possibly be a better fit. Generally we use
TWARN for things that are not easily recoverable i.e. we were not able
to restore the system state which is mostly used in the test cleanup.
And that is something that should be reported to the user since it may
and will affect subsequent tests. Maybe we can simply map all these to
TBROK.

> And I don't wouldn't like to introduce some kind of soft warning flag,
> which would lead to exit 0 which could be an alternative solution.

We are using TINFO for both informational messasges as well as for a
warnings that are not supposed to fail the test. Technically speaking
the only difference between using TWARN and TINFO is that the former
fails the test and that the log shows TWARN in yellow rather than TINFO
in blue. So if you have a message that should not fail the test consider
changing it to TINFO for now and we can always figure out something
better later.

Moreover the new test runner I'm working on counts warnings correctly
so I'm against filtering out TWARN from the exit value even if we decide
to use that only for a minor/recoverable errors. Anbody can filter it
out easily himself if needed.

Another solution would be removing TWARN completely since it's semantics
is not well defined that would leave us with TBROK for non-recoverable
problems and TINFO for the rest of the messages.

-- 
Cyril Hrubis
chrubis@suse.cz
