From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Aug 2019 11:06:35 +0200
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <871rxyd5tc.fsf@rpws.prws.suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz>
 <871rxyd5tc.fsf@rpws.prws.suse.cz>
Message-ID: <20190808090635.GA11500@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +void tst_free_all(void)
> > +{
> > +	struct map *i = maps;
> > +
> > +	while (i) {
> > +		struct map *j = i;
> > +		tst_res(TINFO, "Freeing %p %zu", i->addr, i->size);
> 
> This seems like debug info to me. Not really useful most of the time.

Yes, this is a leftover.

I do wonder if we should print a message first time the tst_alloc() is
called so that it's clear that the test is using guarded buffers.

> > +		SAFE_MUNMAP(i->addr, i->size);
> > +		i = i->next;
> > +		free(j);
> > +	}
> > +
> > +	maps = NULL;
> > +}
> 
> -- 
> Thank you,
> Richard.
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
