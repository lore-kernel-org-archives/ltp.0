From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Jan 2021 19:16:46 +0100
Subject: [LTP] [PATCH 5/5] syscalls/move_pages12: Add one more kernel
 git hash
In-Reply-To: <X/Rk3ZOu8gVb9+Ur@yuki.lan>
References: <20201216101012.14644-1-chrubis@suse.cz>
 <20201216101012.14644-6-chrubis@suse.cz> <X9t8ZjwhY+Db7nRq@pevik>
 <X/Rk3ZOu8gVb9+Ur@yuki.lan>
Message-ID: <X/StDvQcbuLsmuRC@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Patchset pushed, thanks for the review.
Great, thanks!

> > ...
> > > -/*
> > > - * Description:
> > > +/*\
> > > + * [DESCRIPTION]
> > > + *
> > > + * *Test 1*
> > >   *
> > > - * Test #1:
> > > - *  This is a regression test for the race condition between move_pages()
> > > - *  and freeing hugepages, where move_pages() calls follow_page(FOLL_GET)
> > > - *  for hugepages internally and tries to get its refcount without
> > > - *  preventing concurrent freeing.
> > > + * This is a regression test for the race condition between move_pages()
> > > + * and freeing hugepages, where move_pages() calls follow_page(FOLL_GET)
> > > + * for hugepages internally and tries to get its refcount without
> > > + * preventing concurrent freeing.
> > >   *
> > > - *  This test can crash the buggy kernel, and the bug was fixed in:
> > > + * This test can crash the buggy kernel, and the bug was fixed in:
> > >   *
> > >   *   commit e66f17ff71772b209eed39de35aaa99ba819c93d
> > >   *   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> > I wonder if we should format "commit XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" as
> > link to Linus' tree (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX).

> Well we do have links in the tags anyways so I think that it's a bit
> more readable as it is.

I meant in the output (pdf, html) the text would be the same but become link to
Linus' tree (instead of being a plain text).

But that's really minor.

Kind regards,
Petr
