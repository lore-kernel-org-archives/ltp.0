From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Aug 2016 15:19:20 +0200
Subject: [LTP] [PATCH] fcntl.2: F_OFD_XXX needs flock64
In-Reply-To: <1471439675.3196.8.camel@poochiereds.net>
References: <20160816115506.GA25201@rei.lan>
 <2c79788f-c74a-49e8-fa81-0e9cf4e2d75f@gmail.com>
 <1471390910.2680.20.camel@poochiereds.net>
 <20160817081001.GB5817@rei.lan>
 <1471434254.3254.23.camel@poochiereds.net>
 <20160817115318.GB10343@rei.lan>
 <1471439675.3196.8.camel@poochiereds.net>
Message-ID: <20160817131920.GE10343@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hmm, I do not think that this is a good idea. The usuall way how to
> > handle missing constants are fallback definitions such as:
> > 
> > #ifndef F_OFD_FOO
> > # define F_OFD_FOO xyz
> > #endif
> > 
> > This wouldn't do much.
> > 
> > Also these should be only disable on 32bit if __USE_FILE_OFFSET64 is
> > not
> > defined. But you likely meant that here.
> > 
> 
> That's the usual way, but in this case we wouldn't have a fallback
> constant. You'd just get an error about F_OFD_* being undefined at
> build time, which I think is what we'd want here. It's better to fail
> to compile than to build a binary that passes a bogus struct into the
> kernel.

You probably misunderstand what I was trying to say. If you look at the
sources out there (for instance at https://codesearch.debian.net/) most
of it has fallback definitions for F_OFD_* constants included in its own
header files since these flags are relatively new. Not defining these
would not accomplish anything.

One option would be to define them to something invalid such as INT_MAX
so that it's rejected by kernel on runtime. But I do not think this is
very good idea either.

-- 
Cyril Hrubis
chrubis@suse.cz
