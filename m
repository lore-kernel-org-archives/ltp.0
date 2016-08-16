From: Jeff Layton <jlayton@poochiereds.net>
Date: Tue, 16 Aug 2016 19:41:50 -0400
Subject: [LTP] [PATCH] fcntl.2: F_OFD_XXX needs flock64
In-Reply-To: <2c79788f-c74a-49e8-fa81-0e9cf4e2d75f@gmail.com>
References: <20160816115506.GA25201@rei.lan>
 <2c79788f-c74a-49e8-fa81-0e9cf4e2d75f@gmail.com>
Message-ID: <1471390910.2680.20.camel@poochiereds.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, 2016-08-17 at 08:04 +1200, Michael Kerrisk (man-pages) wrote:
> [Jeff, can you comment?]
> 
> Hi Cyril,
> 
> On 08/16/2016 11:55 PM, Cyril Hrubis wrote:
> > 
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
> 
> * On 64-bit, flock{} and flock64{} are the same structure.
> * On 32-bit, flock{} and flock64{} are different.
> * On 32-bit, F_OFD operations require flock64{}, but the traditional
>   F_* lock operations do not.
> * To use flock64{} with F_OFD operations, we can either explicitly use
>   flock64{} or we can compile with -D_FILE_OFFSET_BITS=64
> 
> One solution would be your patch below, but it feels wrong: on 64-bit
> flock{} suffices, and is consistent with the traditional F_* operations.
> An alternative would be a note in the man page that says something along
> the lines that on 32-bit, one must compile with -D_FILE_OFFSET_BITS=64
> when using the F_OFD operations.
> 
> Your thoughts?
> 
> Cheers,
> 
> Michael
> 

This sounds like a regular old bug, rather than a documentation issue. 

The way the kernel works is that if you call fcntl(), then you need to
pass in a struct flock. If you call fcntl64() then you need to pass in
a struct flock64. Of course this is only on 32-bit arches. On 64-bit,
it's there is no flock64 or fcntl64.

Typically, glibc papers over all of this by deciding which syscall it's
going to use based on -D_FILE_OFFSET_BITS. IIRC, it basically redefines
the fields in struct flock to be like the one in struct flock64, so you
shouldn't need to do anything special here.

It sounds here like you got a mismatch, somehow and were calling
fcntl64() with the smaller struct flock? Or was it vice versa?

What would be ideal would be a small reproducer program, and
instructions on how to build it. With that we should be able to nail
down why this is happening.

Also, what arch are you using here?

> > > > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > > > CC: Yuriy Kolerov <Yuriy.Kolerov@synopsys.com>
> > ---
> >  man2/fcntl.2 | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/man2/fcntl.2 b/man2/fcntl.2
> > index f0c1acf..4606709 100644
> > --- a/man2/fcntl.2
> > +++ b/man2/fcntl.2
> > @@ -533,7 +533,7 @@ As with traditional advisory locks, the third argument to
> >  .BR fcntl (),
> >  .IR lock ,
> >  is a pointer to an
> > -.IR flock
> > +.IR flock64
> >  structure.
> >  By contrast with traditional record locks, the
> >  .I l_pid
> > @@ -543,7 +543,7 @@ when using the commands described below.
> >  The commands for working with open file description locks are analogous
> >  to those used with traditional locks:
> >  .TP
> > -.BR F_OFD_SETLK " (\fIstruct flock *\fP)"
> > +.BR F_OFD_SETLK " (\fIstruct flock64 *\fP)"
> >  Acquire an open file description lock (when
> >  .I l_type
> >  is
> > @@ -564,7 +564,7 @@ this call returns \-1 and sets
> >  to
> >  .BR EAGAIN .
> >  .TP
> > -.BR F_OFD_SETLKW " (\fIstruct flock *\fP)"
> > +.BR F_OFD_SETLKW " (\fIstruct flock64 *\fP)"
> >  As for
> >  .BR F_OFD_SETLK ,
> >  but if a conflicting lock is held on the file, then wait for that lock to be
> > @@ -578,7 +578,7 @@ set to
> >  see
> >  .BR signal (7)).
> >  .TP
> > -.BR F_OFD_GETLK " (\fIstruct flock *\fP)"
> > +.BR F_OFD_GETLK " (\fIstruct flock64 *\fP)"
> >  On input to this call,
> >  .I lock
> >  describes an open file description lock we would like to place on the file.
> > 
> 
> 

-- 
Jeff Layton <jlayton@poochiereds.net>
