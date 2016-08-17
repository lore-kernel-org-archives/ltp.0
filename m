From: Jeff Layton <jlayton@poochiereds.net>
Date: Wed, 17 Aug 2016 07:44:14 -0400
Subject: [LTP] [PATCH] fcntl.2: F_OFD_XXX needs flock64
In-Reply-To: <20160817081001.GB5817@rei.lan>
References: <20160816115506.GA25201@rei.lan>
 <2c79788f-c74a-49e8-fa81-0e9cf4e2d75f@gmail.com>
 <1471390910.2680.20.camel@poochiereds.net> <20160817081001.GB5817@rei.lan>
Message-ID: <1471434254.3254.23.camel@poochiereds.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, 2016-08-17 at 10:10 +0200, Cyril Hrubis wrote:
> Hi!
> > 
> > The way the kernel works is that if you call fcntl(), then you need to
> > pass in a struct flock. If you call fcntl64() then you need to pass in
> > a struct flock64. Of course this is only on 32-bit arches. On 64-bit,
> > it's there is no flock64 or fcntl64.
> 
> This does not seem to be the case.
> 
> It looks like kernel expect F_{SET,GET}LK to be 32bit for fcntl64() as
> well. It just calls do_fcntl() that casts the pointer to struct flock
> that seems to be defined with __kernel_off_t in the uapi headers which
> is alias to long.
> 
> And the same in the compat implementation, there the F_{SET,GET}LK works
> with struct compat_flock that has 32bit off_t as well.
> 
> Then we have the F_{SET,GET}LK64 that expect 64bit flock and the
> F_OFD_XXX behaves exactly same. As a matter of the fact they are handled
> mostly in the same branches of the switch() statements which lead me to
> belive that they were intended to be used with flock64 explicitly.
> 
> Glibc does not seem to do much work here. The only thing it does is to
> switch between the F_{SET,GET}LK and F_{SET,GET}LK64 based on
> _FILE_OFFSET_BITS to match the off_t type in the flock structure.
> 

Thanks, I think I understand now. I think there are a couple of
potential fixes...

The simplest thing is to do what you're suggesting and simply document
that F_OFD_* locks require large file offsets. If we do that though,
then I think we also ought to do something to ensure that the build
breaks if you try to use F_OFD_* commands without large offsets.

The simplest way would be to put the F_OFD_* constant definitions under
"#ifdef __USE_FILE_OFFSET64", but I'm open to suggestions that would
make the compiler error out with a more helpful error message.

The other option would be to fix glibc and the kernel to handle legacy
struct flock with F_OFD_ cmd values. That would mean adding F_OFD_*64
command values and fixing glibc to swap them in appropriately. That's
doable, but I'm not sure it's really worth it. We'd also have to think
about how to handle the old kernel/new glibc case (and vice versa), and
that probably won't be trivial.

I'm leaning toward option #1 here. I can cook up a patch for glibc if
you guys agree.

Thoughts?
-- 
Jeff Layton <jlayton@poochiereds.net>
