From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 4 Nov 2020 23:42:21 +0100
Subject: [LTP] [PATCHv2] syscalls/quotactl04: add mkfs.ext4 package
 version check
In-Reply-To: <CAMy_GT-wq+=oYMgyZsVgpZxJ4vU-6PJR2OfWoPx2L=9jDjRo3g@mail.gmail.com>
References: <20201104070405.24044-1-po-hsu.lin@canonical.com>
 <5FA25444.1080008@cn.fujitsu.com>
 <CAMy_GT-wq+=oYMgyZsVgpZxJ4vU-6PJR2OfWoPx2L=9jDjRo3g@mail.gmail.com>
Message-ID: <20201104224221.GA20360@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On Wed, Nov 4, 2020 at 3:12 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:

> > Hi Po-Hsu
> > > The project quota feature was added in e2fsprogs 1.43 [1]:
> > >    E2fsprogs 1.43 (May 17, 2016)
> > >      Add support for the ext4 metadata checksum, checksum seed, inline
> > >      data, encryption, project quota, and read-only features.

> > > The test should be skipped when running with older package, otherwise
> > > it will fail with:
> > >    Invalid filesystem option set: quota,project

> > > Use popen and fscanf to get mkfs.ext4 -V output for version
> > > comparison. This version checking by adding digits together does not
> > > work with alphabets in the number like rc1, but in that case the test
> > > will still be tested.

> > > It will now be skipped with (Tested with Ubuntu Xenial + 4.15 kernel):
> > >    quotactl04.c:118: TCONF: Test needs mkfs.ext4>= 1.43 for encrypt
> > >    option, test skipped
> > Commit message is also wrong. But I think maintainer will correct this
> > and don't need to send a v3.
> My apology for this.
> That would be great.
> Thanks!

Fixed commit message and merged.
Thanks!

Kind regards,
Petr
