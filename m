From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 6 Feb 2021 20:59:32 +0100
Subject: [LTP] [PATCH v2 2/6] zram01.sh: Generate test setup variables
 in setup
In-Reply-To: <CAEemH2f5tJtgcZG8WaAU1qpKwU7yHDdjzGahhL814goL5sAv-g@mail.gmail.com>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-3-pvorel@suse.cz>
 <CAEemH2ffReVSE_210nyRZVZHOwoMMy-F4Cye08RwPa5bh7PZ0w@mail.gmail.com>
 <YBj8bMKfxqvQ6lYt@pevik>
 <CAEemH2f5tJtgcZG8WaAU1qpKwU7yHDdjzGahhL814goL5sAv-g@mail.gmail.com>
Message-ID: <YB71JBi757ong63Y@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

...
> > > > +get_btrfs_size()


> > > What about renaming at_least_1G_mem() or check_space_for_btrfs()?
> > Good point. I'm slightly for check_space_for_btrfs().

> > at_least_1G_mem() is also good, but for that I'd also move tst_res TINFO
> > "not
> > enough space for Btrfs" out of the function and put it into
> > generate_vars(). But
> > since it's used only for btrfs I slightly prefer check_space_for_btrfs().
> > But no
> > strong opinion about it.


> Agree, thanks!

> Btw I suddenly think that we could have a nicer name initialize_vars()
> to replace generate_vars(), because we just use it once to initiate the
> test variables in the setup phase.
Good idea, thanks!

BTW I tested zram on all filesystems including fuse/*fat/ntfs:
zram01 4 TINFO: make ext2 filesystem on /dev/zram0
zram01 4 TINFO: make ext3 filesystem on /dev/zram1
zram01 4 TINFO: make ext4 filesystem on /dev/zram2
zram01 4 TINFO: make xfs filesystem on /dev/zram3
zram01 4 TINFO: make btrfs filesystem on /dev/zram4
zram01 4 TINFO: make vfat filesystem on /dev/zram5
zram01 4 TINFO: make exfat filesystem on /dev/zram6
zram01 4 TINFO: make ntfs filesystem on /dev/zram7

and it's working well, thus I suggest to test everything available:

-       for fs in $(tst_supported_fs | grep -v -e fat -e ntfs -e fuse); do
+       for fs in $(tst_supported_fs); do

Before sending v3 or just merge with fixes I'm also waiting for Cyril's (or
somebody else) review / suggestions on the timeout (whether simply use -1 for
timeout and drop patch "tst_test.sh: Run _tst_setup_timer after $TST_SETUP")

https://patchwork.ozlabs.org/project/ltp/patch/20210129194144.31299-6-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20210129194144.31299-7-pvorel@suse.cz/

Kind regards,
Petr

> Anyway, it's only my feelings and also depends on your preference too.
