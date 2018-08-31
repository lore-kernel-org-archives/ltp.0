From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Aug 2018 12:39:09 +0200
Subject: [LTP] [PATCH ltp] syscalls/bind03: Add version compare
 according to behaviour difference.
In-Reply-To: <20180831093700.GD16417@rei.lan>
References: <20180831132453.6461-1-junchi.chen@intel.com>
 <20180831084149.GA16417@rei.lan> <20180831093700.GD16417@rei.lan>
Message-ID: <20180831103909.GB14565@dell5510>
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

> > This is actually a not-yet fixed kernel bug as the correct errno to be
> > reported in this case is EADDRINUSE at least that is what I understand
> > after reading POSIX.

> Sigh, not enough coffee I would say, the rationale is correctly written
> in the patch from Michal.

> "in general, we do not want to change return code for given testcase and
>  old error (-EINVAL) is consistent with AF_INET(6)"

> Sorry for the confusion.

> > See:

> > https://patchwork.ozlabs.org/patch/782692/

I've already merged this fix, but as Cyril pointed out it might not be what is
wanted. I'll ask David Miller and Michal Kubecek at netdev ML.


Kind regards,
Petr
