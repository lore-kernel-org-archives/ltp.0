From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Feb 2021 17:00:49 +0800
Subject: [LTP] [PATCH v2 2/6] zram01.sh: Generate test setup variables
 in setup
In-Reply-To: <YCDkC2YG22X+OOFs@pevik>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-3-pvorel@suse.cz>
 <CAEemH2ffReVSE_210nyRZVZHOwoMMy-F4Cye08RwPa5bh7PZ0w@mail.gmail.com>
 <YBj8bMKfxqvQ6lYt@pevik>
 <CAEemH2f5tJtgcZG8WaAU1qpKwU7yHDdjzGahhL814goL5sAv-g@mail.gmail.com>
 <YB71JBi757ong63Y@pevik> <YCDkC2YG22X+OOFs@pevik>
Message-ID: <CAEemH2ekz6Vw_QwZKj75ugop8r2Qjtu4XDf2=2ZXTZj7y4AU_Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

Sorry for the late reply, I was on the Spring Festival holidays last two
weeks.

On Mon, Feb 8, 2021 at 3:11 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > BTW I tested zram on all filesystems including fuse/*fat/ntfs:
> > zram01 4 TINFO: make ext2 filesystem on /dev/zram0
> > zram01 4 TINFO: make ext3 filesystem on /dev/zram1
> > zram01 4 TINFO: make ext4 filesystem on /dev/zram2
> > zram01 4 TINFO: make xfs filesystem on /dev/zram3
> > zram01 4 TINFO: make btrfs filesystem on /dev/zram4
> > zram01 4 TINFO: make vfat filesystem on /dev/zram5
> > zram01 4 TINFO: make exfat filesystem on /dev/zram6
> > zram01 4 TINFO: make ntfs filesystem on /dev/zram7
>
> > and it's working well, thus I suggest to test everything available:
>
> > -       for fs in $(tst_supported_fs | grep -v -e fat -e ntfs -e fuse);
> do
> > +       for fs in $(tst_supported_fs); do
>
> Although running all 8 filesystems run takes more than 10 min. If it's too
> long,
> it might be better to keep grep and also limit number of tested
> filesystems.
>

+1
I tend to keep grep there cause Linux users might rarely use fat/ntfs.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210218/79c358ac/attachment.htm>
