From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 9 Jan 2018 01:02:41 +0100
Subject: [LTP] [RFC PATCH 0/2] Allow to compile on archs without atomic
 support
In-Reply-To: <754978231.4598218.1515424172751.JavaMail.zimbra@redhat.com>
References: <20180104204250.7032-1-pvorel@suse.cz>
 <754978231.4598218.1515424172751.JavaMail.zimbra@redhat.com>
Message-ID: <20180109000241.GA20748@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

thanks for your comments.

> > I know as this has quite low priority (benefit only people with old
> > compilers and archs), but why not to give a chance them to have at least
> > something from LTP?

> Compiler shouldn't matter, we have fallbacks.
> So I assume this concerns only some architectures we currently don't support.
Yes.

> > Quite a lot of tests it's working, affected are only tests using threads
> > on new API or fuzzy synchronization and counting results for tests using
> > new api.

> What if we made general implementation with some locking? It would be
> slower, but I think we don't use atomics that much for it to matter.
Makes sense. I'll implement it.


> Regards,
> Jan


Kind regards,
Petr
