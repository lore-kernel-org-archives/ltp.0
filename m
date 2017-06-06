From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 6 Jun 2017 10:04:25 -0700
Subject: [LTP] [PATCH 0/2] ltp: update add_key tests for nonempty NULL
 payload fix
In-Reply-To: <20170606114416.GA5208@rei>
References: <20170605174811.95267-1-ebiggers3@gmail.com>
 <20170606114416.GA5208@rei>
Message-ID: <20170606170425.GA88445@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Tue, Jun 06, 2017 at 01:55:52PM +0200, Cyril Hrubis wrote:
> Hi!
> > (The reason I'm not simply changing the add_key02 test is that I don't want it
> > to appear as a regression on old kernels.  I'm not sure exactly how this kind of
> > thing is typically handled in LTP, though.)
> 
> What exactly do you mean by a regression here? The fact that it may
> crash older kernels? That is pretty much fine, when test fails/kernel
> crashes manual intervention is required and one of the first things you
> do is git log for the test.
> 

When I had tried updating existing tests in xfstests to test more cases, I was
told it shouldn't be done because then the test would start failing on some
systems as a result of the test change, rather than as a result of a kernel
regression.  So it would be more difficult to figure out what caused the test
regression.

Personally, I don't align quite as strongly with that viewpoint (and maybe you
and the other LTP developers don't either) because this can, after all, only be
a problem in cases where the test suite is upgraded, and furthermore if a test
fails it's helpful to 'git log' the test anyway.

Would you suggest I simply update add_key02 instead?

Eric
