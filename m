From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Jun 2021 10:19:25 +0200
Subject: [LTP] [PATCH 2/2] shell: Extend timeout tests,
 to run on multiple shells
In-Reply-To: <3fd9fb2f-3242-5268-eef3-0e5aa4faecef@jv-coder.de>
References: <20210519063109.224352-1-lkml@jv-coder.de>
 <20210519063109.224352-2-lkml@jv-coder.de> <YKToUgBnK6ZQ5I0Q@yuki>
 <2f8e652b-aaa8-5f98-4f9d-5b7c138c17fa@jv-coder.de>
 <YNA+6shWiWYRNi2P@pevik>
 <3fd9fb2f-3242-5268-eef3-0e5aa4faecef@jv-coder.de>
Message-ID: <YNBLjbu7DleeTnQQ@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> Hi Petr,

> On 6/21/2021 9:25 AM, Petr Vorel wrote:
> > Hi all,

> > I wonder what is the state of this patchset?
> > Do we still consider it?
> I still think this should be included, but we can drop shells if you like.
> > Apart from reducing shells (i.e. which distro has ash, which is not
> > alias to other shell in the list) I'm not against non-default shells, but I
> > don't like how whole test gets complicated by this.

> > Also we're reinventing wheel with printing results, checking whether test exist
> > etc. Maybe using test API for this?
> I know that this is reimplementing a lot of stuff, but I think I tried using
> the lib (a bit strange using the object under test to test it, but would be
> ok for me), but failed to do so.
> I guess this was because it uses traps and the set -m stuff, but I am not
> sure anymore.
Yes, using lib for testing it's a bit strange. But test_timeout.sh is already
messy and patch increases it even more. I'd prefer to implement the test
coverage in a cleaner way. Probably to create some very basic testing library,
a wrapper of actual tests.

There was some effort [1], based on my previous work, which concentrated on
having metadata of expected output. That allows to run tests which TBROK by
purpose (quite a lot of tests). I plan to get back to it, but but first I'd like
to create make target for running tests [2].

Kind regards,
Petr

> J?rg

[1] https://patchwork.ozlabs.org/project/ltp/patch/ce675759672af52bea02c11d51bd7d10f0bcb5cb.1566500817.git.clanig@suse.com/
[2] https://patchwork.ozlabs.org/project/ltp/patch/20210618191252.12403-1-pvorel@suse.cz/
