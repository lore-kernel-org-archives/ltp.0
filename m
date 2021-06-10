From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Jun 2021 16:08:46 +0200
Subject: [LTP] [PATCH 1/1] newlib_tests: Fix build dependency on lib
In-Reply-To: <YMINpZkS4j3bhN9O@yuki>
References: <20210610125229.24140-1-pvorel@suse.cz>
 <YMINpZkS4j3bhN9O@yuki>
Message-ID: <YMIc7lb+Zs4C1bMr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> > -include $(top_srcdir)/include/mk/env_pre.mk
> > +include $(top_srcdir)/include/mk/testcases.mk

> Ah right, this adds dependency on the library and builds it if needed.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> Btw the lib/tests/ subdirectory has the same problem, but I'm not sure
> if we care enough to fix that...
Good catch, I fixed it here and merged.

Kind regards,
Petr
