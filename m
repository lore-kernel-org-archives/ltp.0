From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jul 2020 20:12:13 +0200
Subject: [LTP] [RFC PATCH 1/1] Remove nfsv4
In-Reply-To: <20200720170117.GB25707@fieldses.org>
References: <20200720091449.19813-1-pvorel@suse.cz>
 <ffb5cd64d5d65b762bdc85b6044b7fdc526d27cb.camel@hammerspace.com>
 <20200720141255.GA25707@fieldses.org>
 <20200720143620.GD21201@dell5510> <20200720151508.GA13786@dell5510>
 <20200720170117.GB25707@fieldses.org>
Message-ID: <20200720181213.GA29583@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Bruce, Trond,

> > > > On Mon, Jul 20, 2020 at 01:32:09PM +0000, Trond Myklebust wrote:
> > > > > On Mon, 2020-07-20 at 11:14 +0200, Petr Vorel wrote:
> > > > > > Reasons to drop:
> > > > > > * outdated tests (from 2005)
> > > > > > * not used (NFS kernel maintainers use pynfs [1])
> > > > > > * written in Python (we support C and shell, see [2])

> > > > > > [1] http://git.linux-nfs.org/?p=bfields/pynfs.git;a=summary
> > > > > > [2] https://github.com/linux-test-project/ltp/issues/547


> > > > > Unlike pynfs, these tests run on a real NFS client, and were designed
> > > > > to test client implementations, as well as the servers.

> > > > > So if they get dropped from ltp, then we will have to figure out some
> > > > > other way of continuing to maintain them.

> > > > Just for fun, I grepped through old mail to see if I could find any
> > > > cases of these tests being used.  I found one, in which Chuck reports an
> > > > nfslock01 failure.  Looks like it did find a real bug, which we fixed:

> > > > 	https://lore.kernel.org/r/8DF85CB6-5FEB-4A25-9715-C9808F37A4B1@oracle.com
> > > > 	https://lore.kernel.org/r/20160807185024.11705.10864.stgit@klimt.1015granger.net

> > > Thanks for your explanation, this obviously justify these tests in LTP, unless
> > > you want to move it to git.linux-nfs.org and maintain on your own.
> > Actually, that fix 42691398be08 ("nfsd: Fix race between FREE_STATEID and LOCK")
> > from v4.8-rc2 reported by Alexey Kodanev (LTP network maintainer) was found by
> > nfslock01 test [1], which is integrated into other LTP NFS tests [2]. I'd
> > definitely keep these in LTP.

> Whoops, I don't know why I thought I saw nfslock01 in your patch.
> Apologies.
No problem at all, I at least had a second look and find missing runtest file.

> > nfsv4 I proposed to remove as outdated and not being used are testing ACL [3]
> > and fcntl locking [4]. ACL tests use rsh and aren't integrated into LTP
> > framework (use their custom [5] runtest file thus I doubt anyone is using it).
> > fcntl locktests are at least integrated into LTP (use fcntl-locktests runtest
> > file[6], I forget to remove it in this patch).
> > Both tests are written in 2005. I don't want to push for removal, if you see any
> > use in it.

> Looks like they may test some things (ACL enforcement, multi-client
> locking), that our other test suites don't.
That justify to have them, if they really test that properly. IMHO they need
at least a cleanup/rewrite (no matter whether they stay in LTP or adopted by
other project), but maybe write new tests from scratch might be easier.

> On the other hand, if nobody's actually running them then maybe it's on
> us to adopt them if we want them.  (Not volunteering for now.)
Even this brief review helped, thanks!

Kind regards,
Petr

> --b.


> > Kind regards,
> > Petr

> > [1] https://github.com/linux-test-project/ltp/tree/master/testcases/network/nfs/nfslock01/
> > [2] https://github.com/linux-test-project/ltp/blob/master/runtest/net.nfs
> > [3] https://github.com/linux-test-project/ltp/tree/master/testcases/network/nfsv4/acl
> > [4] https://github.com/linux-test-project/ltp/tree/master/testcases/network/nfsv4/locks
> > [5] https://github.com/linux-test-project/ltp/blob/master/testcases/network/nfsv4/acl/runtest
> > [6] https://github.com/linux-test-project/ltp/blob/master/runtest/fcntl-locktests
