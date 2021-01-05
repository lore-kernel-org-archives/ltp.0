From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jan 2021 14:08:45 +0100
Subject: [LTP] [PATCH 5/5] syscalls/move_pages12: Add one more kernel
 git hash
In-Reply-To: <X9t8ZjwhY+Db7nRq@pevik>
References: <20201216101012.14644-1-chrubis@suse.cz>
 <20201216101012.14644-6-chrubis@suse.cz> <X9t8ZjwhY+Db7nRq@pevik>
Message-ID: <X/Rk3ZOu8gVb9+Ur@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Patchset pushed, thanks for the review.

> ...
> > -/*
> > - * Description:
> > +/*\
> > + * [DESCRIPTION]
> > + *
> > + * *Test 1*
> >   *
> > - * Test #1:
> > - *  This is a regression test for the race condition between move_pages()
> > - *  and freeing hugepages, where move_pages() calls follow_page(FOLL_GET)
> > - *  for hugepages internally and tries to get its refcount without
> > - *  preventing concurrent freeing.
> > + * This is a regression test for the race condition between move_pages()
> > + * and freeing hugepages, where move_pages() calls follow_page(FOLL_GET)
> > + * for hugepages internally and tries to get its refcount without
> > + * preventing concurrent freeing.
> >   *
> > - *  This test can crash the buggy kernel, and the bug was fixed in:
> > + * This test can crash the buggy kernel, and the bug was fixed in:
> >   *
> >   *   commit e66f17ff71772b209eed39de35aaa99ba819c93d
> >   *   Author: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> I wonder if we should format "commit XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" as
> link to Linus' tree (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX).

Well we do have links in the tags anyways so I think that it's a bit
more readable as it is.

-- 
Cyril Hrubis
chrubis@suse.cz
