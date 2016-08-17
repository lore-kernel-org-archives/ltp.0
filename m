From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Aug 2016 09:44:15 +0200
Subject: [LTP] [PATCH] fcntl.2: F_OFD_XXX needs flock64
In-Reply-To: <2c79788f-c74a-49e8-fa81-0e9cf4e2d75f@gmail.com>
References: <20160816115506.GA25201@rei.lan>
 <2c79788f-c74a-49e8-fa81-0e9cf4e2d75f@gmail.com>
Message-ID: <20160817074415.GA5817@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > If we pass struct flock to the F_OFD_XXX fcntl() it will fail with
> > EINVAL with a 32bit binary. That is because glibc uses fcntl64() by
> > default but the struct flock uses 32bit off_t for 32bit binaries (unless
> > _FILE_OFFSET_BITS=64) and kernel always expect flock64 for F_OFD_XXX in
> > fcntl64(). Hence kernel will read some garbage that is a few bytes after
> > the 32bit flock structure in this case which will likely end up with the
> > syscall returning EINVAL.
> 
> Okay -- I confirm the problem you report. I'm just not sure that the
> patch below is the best fix. So, to summarize:

Either we do that or we have to translate the flock{} to flock64{} at
the runtime if F_OFD_XXX was the fcntl() cmd. However the problem is
that we have no idea if _FILE_OFFSET_BITS was set or not once we reach
fcntl.c in glibc. So the whole translation would have been put into the
fcntl.h header into some ugly macro or we would have to do some trickery
like passing down the sizeof(struct flock) as additional fcntl
parameter.

> One solution would be your patch below, but it feels wrong: on 64-bit
> flock{} suffices, and is consistent with the traditional F_* operations.
> An alternative would be a note in the man page that says something along
> the lines that on 32-bit, one must compile with -D_FILE_OFFSET_BITS=64
> when using the F_OFD operations.

That would be solution as well.

-- 
Cyril Hrubis
chrubis@suse.cz
