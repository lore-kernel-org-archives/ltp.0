From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 4 Feb 2020 15:19:22 +0100
Subject: [LTP] [RFC PATCH 1/1] autotools: Move simple definitions out of
 m4/* to configure.ac
In-Reply-To: <20200204132152.GC16090@rei>
References: <20200130110753.20459-1-pvorel@suse.cz>
 <20200204132152.GC16090@rei>
Message-ID: <20200204141922.GA18759@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > +AC_CHECK_HEADERS(fts.h, [have_fts=1])
> > +AC_SUBST(HAVE_FTS_H, $have_fts)

> How is that different from simple AC_CHECK_HEADERS() ?

> Can't we just put the hader into the call above?

AC_SUBST(HAVE_FTS_H, $have_fts) is needed as HAVE_FTS_H
is used in testcases/kernel/controllers/Makefile to filter out cpuset.

> Other than this the changes looks fine.
OK, I'll push it with your ack, unless you have idea, how to avoid using
AC_SUBST(HAVE_FTS_H, $have_fts).

Kind regards,
Petr
