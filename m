From: Jeff Layton <jlayton@poochiereds.net>
Date: Wed, 17 Aug 2016 09:14:35 -0400
Subject: [LTP] [PATCH] fcntl.2: F_OFD_XXX needs flock64
In-Reply-To: <20160817115318.GB10343@rei.lan>
References: <20160816115506.GA25201@rei.lan>
 <2c79788f-c74a-49e8-fa81-0e9cf4e2d75f@gmail.com>
 <1471390910.2680.20.camel@poochiereds.net> <20160817081001.GB5817@rei.lan>
 <1471434254.3254.23.camel@poochiereds.net> <20160817115318.GB10343@rei.lan>
Message-ID: <1471439675.3196.8.camel@poochiereds.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2016-08-17 at 13:53 +0200, Cyril Hrubis wrote:
> Hi!
> > 
> > Thanks, I think I understand now. I think there are a couple of
> > potential fixes...
> > 
> > The simplest thing is to do what you're suggesting and simply
> > document
> > that F_OFD_* locks require large file offsets. If we do that
> > though,
> > then I think we also ought to do something to ensure that the build
> > breaks if you try to use F_OFD_* commands without large offsets.
> > 
> > The simplest way would be to put the F_OFD_* constant definitions
> > under
> > "#ifdef??__USE_FILE_OFFSET64", but I'm open to suggestions that
> > would
> > make the compiler error out with a more helpful error message.
> 
> Hmm, I do not think that this is a good idea. The usuall way how to
> handle missing constants are fallback definitions such as:
> 
> #ifndef F_OFD_FOO
> # define F_OFD_FOO xyz
> #endif
> 
> This wouldn't do much.
> 
> Also these should be only disable on 32bit if __USE_FILE_OFFSET64 is
> not
> defined. But you likely meant that here.
> 

That's the usual way, but in this case we wouldn't have a fallback
constant. You'd just get an error about F_OFD_* being undefined at
build time, which I think is what we'd want here. It's better to fail
to compile than to build a binary that passes a bogus struct into the
kernel.

> > The other option would be to fix glibc and the kernel to handle
> > legacy
> > struct flock with F_OFD_ cmd values. That would mean adding
> > F_OFD_*64
> > command values and fixing glibc to swap them in appropriately.
> > That's
> > doable, but I'm not sure it's really worth it. We'd also have to
> > think
> > about how to handle the old kernel/new glibc case (and vice versa),
> > and
> > that probably won't be trivial.
> 
> I do not think that this is worth the work either.
> 

-- 
Jeff Layton <jlayton@poochiereds.net>
