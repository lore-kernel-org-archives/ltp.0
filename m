From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 12 Mar 2021 12:05:32 +0100
Subject: [LTP] [PATCH] syscalls: Use anonymous .resource_files for
 docparse
In-Reply-To: <YEn0BK8xHVU1e52X@yuki.lan>
References: <20210303023235.431238-1-yangx.jy@cn.fujitsu.com>
 <YEigO2gryF1Kp6Gq@pevik>
 <b11680c3-7878-b06b-e87a-8991bd3cb305@163.com>
 <YEkAH6xJlSK99bp+@pevik> <YEnx4V3Il/VrThv/@pevik>
 <YEn0BK8xHVU1e52X@yuki.lan>
Message-ID: <YEtK/A2mGoEZjF8Q@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > > > we need to do some investigation about it.
> > > gcc -E foo.c would do expansion for us. But not sure if it's worth of runtime.
> > > Because problem of missing definitions will be on other places and we don't want
> > > to get rid of definitions. e.g. I planned to add some tag definitions (for
> > > "linux-git", ...) as Martin Doucha suggested, but this would not work until
> > > we expand macros.

> > I was looking into the output of gcc -E but it brings other problems.
> > Wouldn't be better instead of patching like this to just replace docparse.c with
> > library support to test itself print it's description in json format
> > (e.g. --print-json opt)? I was thinking to use the same for shell tests docparse
> > (which aren't covered at all yet).

> I've been there and tried that that was v1 of the proposal, it did not work.
OK, thanks for info.

> We can add macro expansion to the docparse instead, it shouldn't be that
> hard.
Not sure if I understand what you mean. Using gcc -E or something else?

Kind regards,
Petr
