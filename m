From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 May 2021 15:56:45 +0200
Subject: [LTP] [Automated-testing] [RFC PATCH 1/1] doc: Add supported
 kernel, libc versions
In-Reply-To: <YJ6SDSAsLoXHgnOc@pevik>
References: <20210514132639.4181-1-pvorel@suse.cz> <YJ6A0gcR9L+P9IXm@yuki>
 <YJ6SDSAsLoXHgnOc@pevik>
Message-ID: <YKJ2HQ0gUN2rQtEi@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I'm not sure that this is a good suggestion.
> 
> > I would write something as:
> 
> > Older distributions are not officially supported, which means that it
> > may or may not work. It all depends on your luck. It should be possible
> > to compile latest LTP even on slightly older distributions than we
> > support with a few manual tweaks, e.g. disabling manually tests for
> > newly added syscalls manually, etc.
> 
> > If latest LTP cannot be compiled even with some amount of workarounds,
> > you may result to older LTP releases, however these are _not_ supported
> > in any way. Also if you are trying to run LTP on more than 10 years old
> > distribution you may as well reconsider you life choices.
> +1 (although not sure about the latest sentence :))

Sure, we can be nicer and the last sentence could be:

Also if you are trying to run LTP on more than 10 years old distribution
you should really consider updating to a more recent one.

-- 
Cyril Hrubis
chrubis@suse.cz
