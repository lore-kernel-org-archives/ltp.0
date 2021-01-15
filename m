From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Jan 2021 15:58:49 +0800
Subject: [LTP] [PATCH 1/1] zram: Check properly command dependencies
In-Reply-To: <YAE9Lkgj09qVupsN@pevik>
References: <20210114183226.794-1-pvorel@suse.cz>
 <CAEemH2cQRNQ3_sko-rBSNf4hgR0p3a5sp1qXgpyXoY1T4aOf7Q@mail.gmail.com>
 <YAE9Lkgj09qVupsN@pevik>
Message-ID: <CAEemH2cmyKFuL9=OWFB-PcpvCmCa2v6BPSijeEqaV6626EmsJQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Fri, Jan 15, 2021 at 2:59 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> ...
> > > diff --git a/testcases/kernel/device-drivers/zram/zram_lib.sh
> > > b/testcases/kernel/device-drivers/zram/zram_lib.sh
> > > index 3f4d1d55f..1a611b974 100755
> > > --- a/testcases/kernel/device-drivers/zram/zram_lib.sh
> > > +++ b/testcases/kernel/device-drivers/zram/zram_lib.sh
> > > @@ -178,13 +178,30 @@ zram_swapoff()
> > >  zram_makefs()
> > >  {
> > >         tst_require_cmds mkfs
> > > +
> > > +       local default_fs fs
> > >         local i=0
>
> > > +       for fs in $zram_filesystems ext2; do
> > > +               if tst_supported_fs $fs 2> /dev/null; then
> > > +                       default_fs="$fs"
> > > +                       break
> > > +               fi
> > > +       done
>
>
> > This workaround makes some sense but a bit overlap to traverse
> >  $zram_filesystems.
> Not sure if I understand you.


> > Maybe we can remove the unsupported filesystems from $zram_filesystems
> > list via tst_supported_fs and tst_cmd_available, to avoid involving that
> > additional
> > variable 'default_fs', then in following test if $zram_filesystems is a
> > null string
> > just exit with TCONF directly?
>
> I understood, that there must be 4 runs, because 4 /dev/zram* has been used
> (dev_num=4). Do you mean to check supported systems in the setup (it'd be
> safer
> to move the calculation to the setup) and lower dev_num if needed?
>

My fault, seems I ignored the dev_num in the previous review, I just looked
into
the zram_makefs() and suggest pruning the $zram_filesystems.

You are right, we could have two ways now:
1. check supported filesystems and recalculate relative parameters in the
setup
(I prefer this, but needs more work/time to refactor code)

2. add variable default_fs as what you did
(the cons side might have duplicated test, but I'm not against it because
of the coming LTP release date)


>
> And tst_cmd_available is not needed, because tst_supported_fs checks also
> for
> mkfs.foo presence.
>
Great.


>
> Also further cleanup after release: it'd make sense to move zram_makefs and
> zram_mount to zram01.sh, which is the only test which use them. And
> zram_makefs
> uses $zram_filesystems.
> Or keep them in zram_lib.sh, but pass $zram_filesystems to zram_makefs as a
> parameter. Current state is confusing a bit.
>

Yes, or let's do the refactoring after release.


>
> Kind regards,
> Petr
>
> > > +
> > > +       if [ -z "$default_fs" ]; then
> > > +               tst_res TINFO "supported filesystems"
> > > +               tst_supported_fs > /dev/null
> > > +               tst_brk TCONF "missing kernel support or mkfs for all
> of
> > > these filesystems: $zram_filesystems"
> > > +       fi
> > > +
> > >         for fs in $zram_filesystems; do
> > > -               # if requested fs not supported default it to ext2
> > > -               tst_supported_fs $fs 2> /dev/null || fs=ext2
> > > +               # use default if requested fs not supported or missing
> mkfs
> > > +               tst_supported_fs $fs 2> /dev/null && tst_cmd_available
> > > mkfs.$fs \
> > > +                       || fs=$default_fs
>
> > >                 tst_res TINFO "make $fs filesystem on /dev/zram$i"
> > > +
> > >                 mkfs.$fs /dev/zram$i > err.log 2>&1
> > >                 if [ $? -ne 0 ]; then
> > >                         cat err.log
> > > --
> > > 2.29.2
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210115/dd6cdaa2/attachment.htm>
