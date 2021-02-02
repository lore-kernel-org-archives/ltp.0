From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Feb 2021 19:16:52 +0800
Subject: [LTP] [PATCH v2 2/6] zram01.sh: Generate test setup variables
 in setup
In-Reply-To: <YBj8bMKfxqvQ6lYt@pevik>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-3-pvorel@suse.cz>
 <CAEemH2ffReVSE_210nyRZVZHOwoMMy-F4Cye08RwPa5bh7PZ0w@mail.gmail.com>
 <YBj8bMKfxqvQ6lYt@pevik>
Message-ID: <CAEemH2f5tJtgcZG8WaAU1qpKwU7yHDdjzGahhL814goL5sAv-g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Petr Vorel <pvorel@suse.cz> wrote:

...
> > > +get_btrfs_size()
>
>
> > What about renaming at_least_1G_mem() or check_space_for_btrfs()?
> Good point. I'm slightly for check_space_for_btrfs().
>
> at_least_1G_mem() is also good, but for that I'd also move tst_res TINFO
> "not
> enough space for Btrfs" out of the function and put it into
> generate_vars(). But
> since it's used only for btrfs I slightly prefer check_space_for_btrfs().
> But no
> strong opinion about it.
>

Agree, thanks!

Btw I suddenly think that we could have a nicer name initialize_vars()
to replace generate_vars(), because we just use it once to initiate the
test variables in the setup phase.

Anyway, it's only my feelings and also depends on your preference too.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210202/64014556/attachment.htm>
