From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 Mar 2021 11:33:05 +0100
Subject: [LTP] [PATCH] syscalls: Use anonymous .resource_files for
 docparse
In-Reply-To: <YEkAH6xJlSK99bp+@pevik>
References: <20210303023235.431238-1-yangx.jy@cn.fujitsu.com>
 <YEigO2gryF1Kp6Gq@pevik>
 <b11680c3-7878-b06b-e87a-8991bd3cb305@163.com>
 <YEkAH6xJlSK99bp+@pevik>
Message-ID: <YEnx4V3Il/VrThv/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> > Hi Petr,

> > I can use file name directly in v2 patch.
> OK. I'd like to know the others opinion (precedent).

> > Do you agree to use anonymous .resource_files for now? or is it better to
> > keep it?
> I guess yes, we've already started to use it.

> > > Not sure how far we should go with moving everything into inline anonymous
> > > definitions (it'd be nice if docparse was able to just expand macros, but that
> > > would be way too slow).

> > I agree that expanding macros or structs is the nicer way but

> > we need to do some investigation about it.
> gcc -E foo.c would do expansion for us. But not sure if it's worth of runtime.
> Because problem of missing definitions will be on other places and we don't want
> to get rid of definitions. e.g. I planned to add some tag definitions (for
> "linux-git", ...) as Martin Doucha suggested, but this would not work until
> we expand macros.

I was looking into the output of gcc -E but it brings other problems.
Wouldn't be better instead of patching like this to just replace docparse.c with
library support to test itself print it's description in json format
(e.g. --print-json opt)? I was thinking to use the same for shell tests docparse
(which aren't covered at all yet).

The downside would be that generation would be much slower and require native
build.

> Kind regards,
> Petr

> > Best Regards,

> > Xiao Yang
