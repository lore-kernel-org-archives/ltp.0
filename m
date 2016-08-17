From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Aug 2016 15:34:06 +0200
Subject: [LTP] [PATCH] fcntl.2: F_OFD_XXX needs flock64
In-Reply-To: <1471440855.3196.26.camel@poochiereds.net>
References: <20160816115506.GA25201@rei.lan>
 <2c79788f-c74a-49e8-fa81-0e9cf4e2d75f@gmail.com>
 <1471390910.2680.20.camel@poochiereds.net>
 <20160817081001.GB5817@rei.lan>
 <1471434254.3254.23.camel@poochiereds.net>
 <20160817115318.GB10343@rei.lan>
 <1471439675.3196.8.camel@poochiereds.net>
 <20160817131920.GE10343@rei.lan>
 <1471440855.3196.26.camel@poochiereds.net>
Message-ID: <20160817133406.GF10343@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > You probably misunderstand what I was trying to say. If you look at the
> > > sources out there (for instance at https://codesearch.debian.net/) most
> > of it has fallback definitions for F_OFD_* constants included in its own
> > header files since these flags are relatively new. Not defining these
> > would not accomplish anything.
> > 
> > One option would be to define them to something invalid such as INT_MAX
> > so that it's rejected by kernel on runtime. But I do not think this is
> > very good idea either.
> > 
> 
> Yeah, not much we can do about people that define them on their own. If
> you do that, then you're basically saying "I know what I'm doing".
> 
> Still, I think it's worthwhile to do this in glibc since we _can_
> prevent this problem for folks who aren't doing that.

Ok.

Then this should be also paired with patch for the manual page that
explains that these locks are only available with the
_FILE_OFFSET_BITS=64.

-- 
Cyril Hrubis
chrubis@suse.cz
