From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jul 2020 20:16:58 +0200
Subject: [LTP] [RFC PATCH 1/1] Remove nfsv4
In-Reply-To: <20200720151742.GA16973@infradead.org>
References: <20200720091449.19813-1-pvorel@suse.cz>
 <ffb5cd64d5d65b762bdc85b6044b7fdc526d27cb.camel@hammerspace.com>
 <20200720151742.GA16973@infradead.org>
Message-ID: <20200720181658.GA32123@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christoph,

> On Mon, Jul 20, 2020 at 01:32:09PM +0000, Trond Myklebust wrote:
> > On Mon, 2020-07-20 at 11:14 +0200, Petr Vorel wrote:
> > > Reasons to drop:
> > > * outdated tests (from 2005)
> > > * not used (NFS kernel maintainers use pynfs [1])
> > > * written in Python (we support C and shell, see [2])

> > > [1] http://git.linux-nfs.org/?p=bfields/pynfs.git;a=summary
> > > [2] https://github.com/linux-test-project/ltp/issues/547


> > Unlike pynfs, these tests run on a real NFS client, and were designed
> > to test client implementations, as well as the servers.

> > So if they get dropped from ltp, then we will have to figure out some
> > other way of continuing to maintain them.

> NFS tests using the kernel sound like a prime candidate for xfstests.
In the past Yong Sun moved some ext4 related tests from LTP to xfstests.
LTP has various NFS related tests. IMHO more important than where these tests
should be is if anybody has a deeper look into them an cleanup them / rewrite
them from scratch.

Kind regards,
Petr
