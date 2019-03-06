From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Mar 2019 16:30:54 +0100
Subject: [LTP] [PATCH 1/2 v4] syscalls: Add set_mempolicy numa tests.
In-Reply-To: <2092842506.4709417.1551685162547.JavaMail.zimbra@redhat.com>
References: <20190228153425.10286-1-chrubis@suse.cz>
 <20190228153425.10286-2-chrubis@suse.cz>
 <2092842506.4709417.1551685162547.JavaMail.zimbra@redhat.com>
Message-ID: <20190306153054.GC12479@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We also check for free memory on each numa memory mode and skip nodes
> > that don't have sufficient amount of memory for a particular test. The
> > tests checks usuall for twice as much memory per each node in order to
> > allow for allocations to be "misplaced".
> 
> I wonder if we should add some constant to it. I have foggy idea, that
> kernel keeps some reserves.

Hmm, no idea about this, I guess that adding a few megabytes for a good
luck in the library wouldn't do any harm.

> > The tests for file based shared interleaved mappings are no longer
> > mapping a single small file but rather than that we accumulate statistic
> > for larger amount of files over longer period of time and we also allow
> > for small offset (currently 10%). We should probably also increase the
> > number of samples we take as currently it's about 5MB in total on x86
> > although I haven't managed to make this test fail so far. This also
> > fixes the test on Btrfs where the synthetic test that expects the pages
> > to be distributed exactly equally fails.
> 
> API looks good to me, ACK. Maybe you could split it into 2 commits, one for
> new library API, and one for new tests.

Sure, will do.

Ok to commit the library and set_mempolicy() tests with fixed nits you
pointed out below or should I spin v5?

-- 
Cyril Hrubis
chrubis@suse.cz
