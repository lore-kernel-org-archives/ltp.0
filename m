From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Mar 2017 10:25:06 +0200
Subject: [LTP] Is MADV_HWPOISON supposed to work only on faulted-in
	pages?
In-Reply-To: <87zig6uvgd.fsf@firstfloor.org>
References: <6a445beb-119c-9a9a-0277-07866afe4924@redhat.com>
 <20170220050016.GA15533@hori1.linux.bs1.fc.nec.co.jp>
 <20170223032342.GA18740@hori1.linux.bs1.fc.nec.co.jp>
 <87zig6uvgd.fsf@firstfloor.org>
Message-ID: <20170328082506.GA30388@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I think that what the testcase effectively does is to test whether memory
> > handling on zero pages works or not.
> > And the testcase's failure seems acceptable, because it's simply not-implemented yet.
> > Maybe recovering from error on zero page is possible (because there's no data
> > loss for memory error,) but I'm not sure that code might be simple enough and/or
> > it's worth doing ...
> 
> I doubt it's worth doing, it's just too unlikely that a specific page
> is hit. Memory error handling is all about probabilities.
> 
> The test is just broken and should be fixed.
> 
> mce-test had similar problems at some point, but they were all fixed.

Well I disagree, the reason why the test fails is that MADV_HWPOISON on
not-faulted private mappings fails silently, which is a bug, albeit
minor one. If something is not implemented, it should report a failure,
the usual error return would be EINVAL in this case.

It appears that it fails with EBUSY on first try on newer kernels, but
still fails silently when we try for a second time.

Why can't we simply check if the page is faulted or not and return error
in the latter case?

-- 
Cyril Hrubis
chrubis@suse.cz
