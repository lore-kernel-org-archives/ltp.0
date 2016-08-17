From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Aug 2016 10:10:02 +0200
Subject: [LTP] [PATCH] fcntl.2: F_OFD_XXX needs flock64
In-Reply-To: <1471390910.2680.20.camel@poochiereds.net>
References: <20160816115506.GA25201@rei.lan>
 <2c79788f-c74a-49e8-fa81-0e9cf4e2d75f@gmail.com>
 <1471390910.2680.20.camel@poochiereds.net>
Message-ID: <20160817081001.GB5817@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The way the kernel works is that if you call fcntl(), then you need to
> pass in a struct flock. If you call fcntl64() then you need to pass in
> a struct flock64. Of course this is only on 32-bit arches. On 64-bit,
> it's there is no flock64 or fcntl64.

This does not seem to be the case.

It looks like kernel expect F_{SET,GET}LK to be 32bit for fcntl64() as
well. It just calls do_fcntl() that casts the pointer to struct flock
that seems to be defined with __kernel_off_t in the uapi headers which
is alias to long.

And the same in the compat implementation, there the F_{SET,GET}LK works
with struct compat_flock that has 32bit off_t as well.

Then we have the F_{SET,GET}LK64 that expect 64bit flock and the
F_OFD_XXX behaves exactly same. As a matter of the fact they are handled
mostly in the same branches of the switch() statements which lead me to
belive that they were intended to be used with flock64 explicitly.

Glibc does not seem to do much work here. The only thing it does is to
switch between the F_{SET,GET}LK and F_{SET,GET}LK64 based on
_FILE_OFFSET_BITS to match the off_t type in the flock structure.

-- 
Cyril Hrubis
chrubis@suse.cz
