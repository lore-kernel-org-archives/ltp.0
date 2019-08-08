From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Aug 2019 11:27:32 +0200
Subject: [LTP] [RFC PATCH 2/9] lib: Add a canary for guarded buffers
In-Reply-To: <CAEemH2d8dEe0km7FA43S2eQYHE00m9advsAbUbmFfixcV0-qhw@mail.gmail.com>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-3-chrubis@suse.cz>
 <CAEemH2d8dEe0km7FA43S2eQYHE00m9advsAbUbmFfixcV0-qhw@mail.gmail.com>
Message-ID: <20190808092732.GB11500@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +static void check_canary(struct map *map)
> > +{
> > +       size_t i;
> > +       char *buf = map->addr;
> > +
> > +       for (i = 0; i < map->buf_shift/2; i++) {
> > +               if (buf[map->buf_shift - i - 1] != buf[i]) {
> > +                       tst_res(TWARN,
> > +                               "pid %i: buffer modified before address %p %zu",
> > +                               (char*)map->addr + map->buf_shift, i);
> 
> Here you probably missed the getpid() for printing %i match :).

Ah, right, I guess that this is unfinished last minute modification.

Actually as it is the canaries are checked only for the main library pid
becuase the tst_free_all() is hooked up in the do_test_cleanup().

I guess that we should call it in the run_tests() function before we
call exit(0) for the child processes as well as in the tst_vbrk_() and
after that changes printing pid in the warning makes sense.

-- 
Cyril Hrubis
chrubis@suse.cz
