From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Nov 2018 10:46:06 +0100
Subject: [LTP] [PATCH v4] Testing statx syscall Timestamp fields
In-Reply-To: <33a19bb69841c667ce537998c3396bc5.squirrel@pike.zilogic.com>
References: <20181109103057.4473-1-subash@zilogic.com>
 <20181113155546.GC11121@rei.lan>
 <33a19bb69841c667ce537998c3396bc5.squirrel@pike.zilogic.com>
Message-ID: <20181115094606.GB14165@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +	rval = clock_getres(clk_id, res);
> >> +	if (rval == -1)
> >                ^
> > 	       rval != 0 is a bit more robust
> >
> >> +		tst_brk(TBROK | TERRNO,
> >> +			"%s:%d:, clock_getres() failed", file, lineno);
> >                                ^              ^
> >                                |              We should print the
> > parameters here
> > 			       No comma here please.
> >> +
> >> +}
> >> +
> 
> Since file and lineno are error indicating parameters and not the actual
> function arguments we preferred printing it before the actual error
> message.

Well the clk_id could be computed on the fly and passed to the function,
hence it would be better to print it here.

> Also as the second parameter is a structure we weren't sure if it is
> necessary to print individual structure members. That is why we preferred
> printing a plain error message with just the lineno and file name.

We usually print structure pointers passed just as %p. There is no point
in printing out the structure members here becaues if the call fails the
structure will not be initialized and will likely contain random
garbage.

> > Again do we really need 512MB for the test?
> >
> > I doubt so.
> >
> >> +	.mnt_flags = MS_STRICTATIME,
> >> +};
> >
> > Otherwise it's good.
> >
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> >
> 
> 
> 
> For the ext4 to provide nanosecond precision to the timestamp fields the
> INODE size has to be atleast 256bytes.
> 
> If the file system size is smaller than 512MB then by default the INODE
> size will be only 128bytes and hence will not support birth time and nano
> second precision.

Here we are assuming something that may change in the future, shouldn't
we rather pass "-I 256" to the mkfs the same way we pass "-b $PAGESIZE"
in statx05.c? Then we can go with whatever the default filesystem size
is.

-- 
Cyril Hrubis
chrubis@suse.cz
