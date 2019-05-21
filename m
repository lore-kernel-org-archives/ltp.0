From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 21 May 2019 23:27:21 +0530
Subject: [LTP] ext4 regression (was Re: [PATCH 4.19 000/105]
	4.19.45-stable review)
In-Reply-To: <20190521162142.GA2591@mit.edu>
References: <20190520115247.060821231@linuxfoundation.org>
 <20190520222342.wtsjx227c6qbkuua@xps.therub.org>
 <20190521085956.GC31445@kroah.com>
 <CA+G9fYvHmUimtwszwo=9fDQLn+MNh8Vq3UGPaPUdhH=dEKzqxg@mail.gmail.com>
 <20190521093849.GA9806@kroah.com>
 <CA+G9fYveeg_FMsL31aunJ2A9XLYk908Y1nSFw4kwkFk3h3uEiA@mail.gmail.com>
 <20190521162142.GA2591@mit.edu>
Message-ID: <CA+G9fYunxonkqmkhz+zmZYuMTfyRMVBxn6PkTFfjd8tTT+bzHQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 21 May 2019 at 21:52, Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, May 21, 2019 at 03:58:15PM +0530, Naresh Kamboju wrote:
> > > Ted, any ideas here?  Should I drop this from the stable trees, and you
> > > revert it from Linus's?  Or something else?
>
> It's safe to drop this from the stable trees while we investigate.  It
> was always borderline for stable anyway.  (See below).
>
> > >
> > > Note, I do also have 170417c8c7bb ("ext4: fix block validity checks for
> > > journal inodes using indirect blocks") in the trees, which was supposed
> > > to fix the problem with this patch, am I missing another one as well?
> >
> > FYI,
> > I have applied fix patch 170417c8c7bb ("ext4: fix block validity checks for
> >  journal inodes using indirect blocks") but did not fix this problem.
>
> Hmm... are you _sure_?  This bug was reported to me versus the
> mainline, and the person who reported it confirmed that it did fix the
> problem, he was seeing, and the symptoms are identical to yours.  Can
> you double check, please?  I can't reproduce it either with that patch applied.

This bug is specific to x86_64 and i386.

Steps to reproduce is,
running LTP three test cases in sequence on x86 device.
# cd ltp/runtest
# cat syscalls ( only three test case)
open12 open12
madvise06 madvise06
poll02 poll02
#

as Dan referring to,

LTP is run using '/opt/ltp/runltp -d /scratch -f syscalls', where the
syscalls file has been replaced with three test case names, and
/scratch is an ext4 SATA drive. /scratch is created using 'mkfs -t ext4
/dev/disk/by-id/ata-TOSHIBA_MG03ACA100_37O9KGKWF' and mounted to
/scratch.

Please find full test log,
https://lkft.validation.linaro.org/scheduler/job/738661#L1356

And you notice dmesg log,
[   53.897001] EXT4-fs error (device sda): ext4_find_extent:909: inode
#8: comm jbd2/sda-8: pblk 121667583 bad header/extent: invalid extent
entries - magic f30a, entries 8, max 340(340), depth 0(0)
[   53.931430] jbd2_journal_bmap: journal block not found at offset 49 on sda-8
[   53.938480] Aborting journal on device sda-8.
[   55.431382] EXT4-fs error (device sda):
ext4_journal_check_start:61: Detected aborted journal
[   55.439947] EXT4-fs (sda): Remounting filesystem read-only

- Naresh
