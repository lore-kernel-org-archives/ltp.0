From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 May 2021 08:42:54 +0200
Subject: [LTP] [RFC PATCH 1/1] doc: Add supported kernel, libc versions
In-Reply-To: <CAASaF6ytbCjwOSOywR4JUToJb_u9fOe2a2y4zE7_n99cgre5TQ@mail.gmail.com>
References: <20210514132639.4181-1-pvorel@suse.cz> <YJ6A0gcR9L+P9IXm@yuki>
 <CAASaF6ytbCjwOSOywR4JUToJb_u9fOe2a2y4zE7_n99cgre5TQ@mail.gmail.com>
Message-ID: <YKIQbr8nI0VhFmUg@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
> > Older distributions are not officially supported, which means that it
> > may or may not work. It all depends on your luck. It should be possible
> > to compile latest LTP even on slightly older distributions than we
> > support with a few manual tweaks, e.g. disabling manually tests for
> > newly added syscalls manually, etc.

> > If latest LTP cannot be compiled even with some amount of workarounds,
> > you may result to older LTP releases, however these are _not_ supported
> > in any way. Also if you are trying to run LTP on more than 10 years old
> > distribution you may as well reconsider you life choices.

> Should we also give some hint about accepting patches/wokrarounds for
> very old distros?
> For example: "Trivial fixes/workarounds may be accepted, but users are
> encouraged to move to newer distro."

+1. I'd add it at the end of first paragraph. Or anyone feel free to express it
differently.

Kind regards,
Petr
