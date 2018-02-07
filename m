From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 7 Feb 2018 17:54:43 +0100
Subject: [LTP] [RFC PATCH 1/1] numa: Fix TCONF message when numa
 disabled with --without-numa
In-Reply-To: <20180207154452.GD31084@rei>
References: <20180207153650.15095-1-pvorel@suse.cz>
 <20180207154452.GD31084@rei>
Message-ID: <20180207165443.bmh4sqkix66sxq5p@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> >  AC_OUTPUT
> > diff --git a/include/mk/config.mk.in b/include/mk/config.mk.in
> > index 01f178bff..b564c1cea 100644
> > --- a/include/mk/config.mk.in
> > +++ b/include/mk/config.mk.in
> > @@ -82,6 +82,7 @@ LINUX_VERSION_PATCH	:= @LINUX_VERSION_PATCH@
> >  WITH_MODULES		:= @WITH_MODULES@

> >  HOST_CPU		:= @HOST_CPU@
> > +NUMA_ERROR_MSG	:= @NUMA_ERROR_MSG@

> Huh, why do we need this in config.mk ?

> Otherwise it looks good.
Thanks for review. Fixed, rebased with changes from Xiao Yang and merged.


Kind regards,
Petr
