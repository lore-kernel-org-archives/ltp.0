From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Aug 2018 17:46:08 +0200
Subject: [LTP] [PATCH 2/5] lib: Add LTP_ATTRIBUTE_FALLTHROUGH for case
 statements
In-Reply-To: <20180821120809.GC20217@dell5510>
References: <20180820064257.17974-1-rpalethorpe@suse.com>
 <20180820064257.17974-3-rpalethorpe@suse.com>
 <20180821120809.GC20217@dell5510>
Message-ID: <20180830154608.GB22454@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +++ b/include/tst_common.h
> > @@ -24,6 +24,7 @@
> >  #define LTP_ATTRIBUTE_NORETURN		__attribute__((noreturn))
> >  #define LTP_ATTRIBUTE_UNUSED		__attribute__((unused))
> >  #define LTP_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
> > +#define LTP_ATTRIBUTE_FALLTHROUGH	__attribute__((fallthrough))
> This does not work on old GCC versions, it was added in GCC 7
> 
> * GCC < 7
> fcntl33.c: In function ???do_test???:
> fcntl33.c:160:3: warning: empty declaration
>    LTP_ATTRIBUTE_FALLTHROUGH;
> 
> IMHO the most portable way is to use comment /* Fall through */, but maybe we
> don't care much about.

And the comment actually stops the warning from being produced, nice.

-- 
Cyril Hrubis
chrubis@suse.cz
