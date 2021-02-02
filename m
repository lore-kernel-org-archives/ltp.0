From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 2 Feb 2021 08:17:00 +0100
Subject: [LTP] [PATCH v2 2/6] zram01.sh: Generate test setup variables
 in setup
In-Reply-To: <CAEemH2ffReVSE_210nyRZVZHOwoMMy-F4Cye08RwPa5bh7PZ0w@mail.gmail.com>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-3-pvorel@suse.cz>
 <CAEemH2ffReVSE_210nyRZVZHOwoMMy-F4Cye08RwPa5bh7PZ0w@mail.gmail.com>
Message-ID: <YBj8bMKfxqvQ6lYt@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Hi Petr,

> Petr Vorel <pvorel@suse.cz> wrote:

> > ...

> > diff --git a/testcases/kernel/device-drivers/zram/zram01.sh
> > b/testcases/kernel/device-drivers/zram/zram01.sh
> > index a795ff89f..c5d4a3e51 100755
> > --- a/testcases/kernel/device-drivers/zram/zram01.sh
> > +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> > @@ -8,23 +8,25 @@

> >  TST_CNT=7
> >  TST_TESTFUNC="do_test"
> > -TST_NEEDS_CMDS="awk bc dd"
> > +TST_NEEDS_CMDS="awk bc dd grep"
> >  . zram_lib.sh
> > +TST_SETUP="setup"

> > -# List of parameters for zram devices.
> > -# For each number the test creates own zram device.
> > -zram_max_streams="2 3 5 8"
> > -
> > -FS_SIZE="402653184"
> > -FS_TYPE="btrfs"
> > +get_btrfs_size()


> What about renaming at_least_1G_mem() or check_space_for_btrfs()?
Good point. I'm slightly for check_space_for_btrfs().

at_least_1G_mem() is also good, but for that I'd also move tst_res TINFO "not
enough space for Btrfs" out of the function and put it into generate_vars(). But
since it's used only for btrfs I slightly prefer check_space_for_btrfs(). But no
strong opinion about it.

Thanks for your review!

Kind regards,
Petr
