From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 8 Feb 2021 08:11:07 +0100
Subject: [LTP] [PATCH v2 2/6] zram01.sh: Generate test setup variables
 in setup
In-Reply-To: <YB71JBi757ong63Y@pevik>
References: <20210129194144.31299-1-pvorel@suse.cz>
 <20210129194144.31299-3-pvorel@suse.cz>
 <CAEemH2ffReVSE_210nyRZVZHOwoMMy-F4Cye08RwPa5bh7PZ0w@mail.gmail.com>
 <YBj8bMKfxqvQ6lYt@pevik>
 <CAEemH2f5tJtgcZG8WaAU1qpKwU7yHDdjzGahhL814goL5sAv-g@mail.gmail.com>
 <YB71JBi757ong63Y@pevik>
Message-ID: <YCDkC2YG22X+OOFs@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> BTW I tested zram on all filesystems including fuse/*fat/ntfs:
> zram01 4 TINFO: make ext2 filesystem on /dev/zram0
> zram01 4 TINFO: make ext3 filesystem on /dev/zram1
> zram01 4 TINFO: make ext4 filesystem on /dev/zram2
> zram01 4 TINFO: make xfs filesystem on /dev/zram3
> zram01 4 TINFO: make btrfs filesystem on /dev/zram4
> zram01 4 TINFO: make vfat filesystem on /dev/zram5
> zram01 4 TINFO: make exfat filesystem on /dev/zram6
> zram01 4 TINFO: make ntfs filesystem on /dev/zram7

> and it's working well, thus I suggest to test everything available:

> -       for fs in $(tst_supported_fs | grep -v -e fat -e ntfs -e fuse); do
> +       for fs in $(tst_supported_fs); do

Although running all 8 filesystems run takes more than 10 min. If it's too long,
it might be better to keep grep and also limit number of tested filesystems.

Kind regards,
Petr
