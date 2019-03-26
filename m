From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Mar 2019 10:07:07 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] cpuset: Detect missing fts.h
In-Reply-To: <20190324233357.GA1804@x230>
References: <20190321223656.9615-1-petr.vorel@gmail.com>
 <20190322113614.GA20408@rei.lan> <20190324233357.GA1804@x230>
Message-ID: <20190326090707.GA17897@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > diff --git a/configure.ac b/configure.ac
> > > index e002c248e..f05db9d2e 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -235,6 +235,7 @@ LTP_DETECT_HOST_CPU
> > >  LTP_CHECK_PERF_EVENT
> > >  LTP_CHECK_SYNCFS
> > >  LTP_CHECK_SYNC_FILE_RANGE
> > > +LTP_CHECK_FTS_H
> 
> > Any reason why we couldn't simply put the fts.h at the end of the
> > AC_CHECK_HEADERS() list in configure.ac?
> Yes, without AC_SUBST the result is not visible to make (it's just in config.h).
> Or am I wrong? That was the reason, why I didn't take [1] this patch [2].

Ah, my bad, we need AC_SUBST() in this case, I guess that this couldn't
be done simpler then.

-- 
Cyril Hrubis
chrubis@suse.cz
