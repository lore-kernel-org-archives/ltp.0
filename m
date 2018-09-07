From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 7 Sep 2018 12:12:41 +0200
Subject: [LTP] [PATCH ltp] syscalls/bind03: Add version compare
 according to behaviour difference.
In-Reply-To: <20180831084240.GB16417@rei.lan>
References: <20180831132453.6461-1-junchi.chen@intel.com>
 <20180831083713.GA11320@dell5510> <20180831084240.GB16417@rei.lan>
Message-ID: <20180907101241.GB17370@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > ISSUE:
> > >   The case is designed to test the behaviour diverse caused by kernel
> > >   commit 0fb44559ffd6. And it failed for the new behaviour.

> > > ACTION:
> > >   Add a version compare to split part of the test.

> > > Signed-off-by: Junchi Chen <junchi.chen@intel.com>

> > Merged, thanks!

> I think that this should be reverted, until at least we got a clear
> reply from kernel developers...
Michal Kubecek doesn't plan to force his patch, so we can keep the fix.

Although we should improve the test of EINVAL (not to pass two invalid
parameters to the syscall at once).


Kind regards,
Petr
