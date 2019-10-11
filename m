From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 11 Oct 2019 10:36:14 +0200
Subject: [LTP] [PATCH 2/2] tst_test.sh: Add public tst_test_root command
In-Reply-To: <20191009122802.GB7677@rei.lan>
References: <20191009061619.48677-1-lkml@jv-coder.de>
 <20191009061619.48677-3-lkml@jv-coder.de>
 <20191009113919.GB7561@rei.lan>
 <64bb824c-d577-86e5-bfa5-17a8cfbf4174@jv-coder.de>
 <20191009114854.GC7561@rei.lan>
 <22bc4865-295c-3147-8e26-f258fac472f8@jv-coder.de>
 <20191009122802.GB7677@rei.lan>
Message-ID: <20191011083612.GA1315@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > >> 2. I wanted to make it consistent with other functions, that do similar
> > >> stuff like
> > >>   ???? tst_test_drivers and tst_test_cmds. Both also call tst_brk in case
> > >> of unsuccessful tests.
> > > Well I do not like these names either, it's less descriptive that it
> > > would have been with tst_require_cmds and tst_require_drivers, so if
> > > anything I would be for renaming the tst_test_* ones.
> > Fair enough, that makes sense. But then we require a change to 
> > tst_test_* first,
> > otherwise the api names are inconsistent. And I'm not sure if changing the
> > other functions is really worth it.

> Should be easy for tst_test_drivers, that one is only used to implement
> the NEEDS_DRIVERS variable. And for the second one, we would have to
> change a few tests and one line of documentation, but that would be just
> a simple script. I can do that if we agree on the change.

> @Jan @Peter what do you think?
We already did rename once (0567a8958 shell: Rename
s/tst_check_cmds/tst_test_cmds/), but even if we didn't;
I'm for renaming tst_test_* to tst_require_* - clear names are important
(consistency with names as well).

Kind regards,
Petr
