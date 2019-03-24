From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 25 Mar 2019 00:33:58 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] cpuset: Detect missing fts.h
In-Reply-To: <20190322113614.GA20408@rei.lan>
References: <20190321223656.9615-1-petr.vorel@gmail.com>
 <20190322113614.GA20408@rei.lan>
Message-ID: <20190324233357.GA1804@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > diff --git a/configure.ac b/configure.ac
> > index e002c248e..f05db9d2e 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -235,6 +235,7 @@ LTP_DETECT_HOST_CPU
> >  LTP_CHECK_PERF_EVENT
> >  LTP_CHECK_SYNCFS
> >  LTP_CHECK_SYNC_FILE_RANGE
> > +LTP_CHECK_FTS_H

> Any reason why we couldn't simply put the fts.h at the end of the
> AC_CHECK_HEADERS() list in configure.ac?
Yes, without AC_SUBST the result is not visible to make (it's just in config.h).
Or am I wrong? That was the reason, why I didn't take [1] this patch [2].

Anyway, I'm sorry, I thought it's simple enough not to be reviewed, but next
time I'll send it to ML.


Kind regards,
Petr

[1] http://lists.linux.it/pipermail/ltp/2019-March/011428.html
[2] https://patchwork.ozlabs.org/patch/1058067/
