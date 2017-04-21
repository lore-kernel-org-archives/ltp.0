From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 20 Apr 2017 21:43:04 -0700
Subject: [LTP] [lkp-robot] [KEYS]  bdf7c0f8bf: ltp.add_key02.fail
In-Reply-To: <20170420125750.GD10246@rei.lan>
References: <20170401213428.17097-1-ebiggers3@gmail.com>
 <20170417062641.GN31394@yexl-desktop>
 <20170417172955.GA31469@gmail.com> <20170420125750.GD10246@rei.lan>
Message-ID: <20170421044304.GB626@zzz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Thu, Apr 20, 2017 at 02:57:50PM +0200, Cyril Hrubis wrote:
> > 
> > In my opinion this is a valid behavior, and the test is just weird; it's passing
> > in *both* an unaddressable payload and an invalid description, so it's not clear
> > which case it's meant to be testing.  (Generally, if a syscall will fail for
> > more than one reason, it's not guaranteed which error code you'll get.)
> 
> That is quite common problem with LTP testcases. Do you care to send a
> patch or should I fix that?
> 

I'll plan to send a patch.  Also, it looks like the testing that LTP does of
add_key() is very sparse, so I'll try to extend it a bit.

> > In any case, once we have a fix merged, it would be nice for there to be an ltp
> > test added for the "NULL payload with nonzero length" case with one of the key
> > types that crashed the kernel.
> 
> Here as well, feel free to send a patch or at least point us to a
> reproducer that could be turned into a testcase.
> 

I'll plan to send a patch for that as well.

Thanks,

Eric
