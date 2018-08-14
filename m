From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Aug 2018 17:55:10 +0200
Subject: [LTP] [PATCH] Move getcwd05 to realpath01 and fix for old distro
In-Reply-To: <20180814141725.GA20278@rei>
References: <20180801134717.29909-1-mmoese@suse.de>
 <20180813134152.GA7239@dell5510> <20180813142631.GA4374@rei>
 <20180814071356.GA8012@dell5510> <20180814141725.GA20278@rei>
Message-ID: <20180814155510.GA12736@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > We usually keep just the names short and simple, so I would keep it as
> > > it is.
> > I think CVE related are the only exception (see Eric Biggers's post [1]), but
> > I'm ok with keeping it only realpath01.c.

> Let's keep the names short, we do have a bunch of regression tests named
> as syscallXY.c anyways. And the CVE was in realpath() implementation
> anyways, so it's not like we named wrongly to begin with.
OK, pushed with the original name.
Thanks for your patch, Michael.

I did tiny changes:
Fixed copyright in Makefile and state reproducer info ("cve-2018-1000001
realpath buffer underflow") in source file. This should have been done by me in
the original post (when renaming it form cve-2018-1000001.c to getcwd05.c in
later versions of my original post).


Kind regards,
Petr

> > [1] http://lists.linux.it/pipermail/ltp/2018-March/007388.html
