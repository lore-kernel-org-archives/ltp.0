From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 2 Aug 2019 15:03:02 +0200
Subject: [LTP] [RFC PATCH 3/3] make: Add
 -Werror-implicit-function-declaration for all targets
In-Reply-To: <20190712134833.GA21258@dell5510>
References: <20190411233115.32744-1-pvorel@suse.cz>
 <20190411233115.32744-4-pvorel@suse.cz>
 <20190712134833.GA21258@dell5510>
Message-ID: <20190802130301.GC27727@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
> > index 913bdf5d1..3ffdd0b7f 100644
> > --- a/include/mk/env_post.mk
> > +++ b/include/mk/env_post.mk
> > @@ -41,11 +41,9 @@ ifeq ($(UCLINUX),1)
> >  CPPFLAGS			+= -D__UCLIBC__ -DUCLINUX
> >  endif
> 
> > -ifeq ($(ANDROID),1)
> > -# There are many undeclared functions, it's best not to accidentally overlook
> > -# them.
> >  CFLAGS				+= -Werror-implicit-function-declaration
> 
> > +ifeq ($(ANDROID),1)
> >  LDFLAGS				+= -L$(top_builddir)/lib/android_libpthread
> >  LDFLAGS				+= -L$(top_builddir)/lib/android_librt
> >  endif
> 
> Ping, please. Drop it or merge?

My opinion on Werror flags is that they should be on for development but
disabled for releases and production. The question is how to implement
something like this.

On the other hand we do have a CI so most problems would be caught
there...

-- 
Cyril Hrubis
chrubis@suse.cz
