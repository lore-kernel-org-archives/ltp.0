From: Trond Myklebust <trondmy@hammerspace.com>
Date: Mon, 20 Jul 2020 13:32:09 +0000
Subject: [LTP] [RFC PATCH 1/1] Remove nfsv4
In-Reply-To: <20200720091449.19813-1-pvorel@suse.cz>
References: <20200720091449.19813-1-pvorel@suse.cz>
Message-ID: <ffb5cd64d5d65b762bdc85b6044b7fdc526d27cb.camel@hammerspace.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2020-07-20 at 11:14 +0200, Petr Vorel wrote:
> Reasons to drop:
> * outdated tests (from 2005)
> * not used (NFS kernel maintainers use pynfs [1])
> * written in Python (we support C and shell, see [2])
> 
> [1] http://git.linux-nfs.org/?p=bfields/pynfs.git;a=summary
> [2] https://github.com/linux-test-project/ltp/issues/547
> 

Unlike pynfs, these tests run on a real NFS client, and were designed
to test client implementations, as well as the servers.

So if they get dropped from ltp, then we will have to figure out some
other way of continuing to maintain them.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


