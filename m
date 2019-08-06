From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Aug 2019 18:27:03 +0200
Subject: [LTP] [PATCH v7 3/3] syscalls/copy_file_range02: increase
 coverage and remove EXDEV test
In-Reply-To: <20190805102211.pvyufepn6xywi7vm@XZHOUW.usersys.redhat.com>
References: <20190730110555.GB7528@rei.lan>
 <1564569629-2358-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1564569629-2358-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190805065832.ti6vpoviykfaxcj7@XZHOUW.usersys.redhat.com>
 <5D47D6B9.9090306@cn.fujitsu.com>
 <20190805102211.pvyufepn6xywi7vm@XZHOUW.usersys.redhat.com>
Message-ID: <20190806162703.GA1333@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Murphy,

> On Mon, Aug 05, 2019 at 03:11:53PM +0800, Yang Xu wrote:
> > on 2019/08/05 14:58, Murphy Zhou  wrote:

> > > > + * 13) Try to copy contents to a file with target file range
> > > > >  + *     beyond maximum supported file size ->EFBIG
> > > Test 13) fails on latest Linus tree. Is there any report or working on this?
> > Hi Murphy

> >    Test 13)  passed on my system(64bit, 5.2.0+, ext4,vfat,btrfs,xfs ).
> >    Do you provide more infomation(filesystem, 32bit or 64bit)?

> All of them, ext234 xfs and vfat. 64bit
Hi, I can confirm that. Also fails on btrfs.

> copy_file_range02.c:127: FAIL: copy_file_range returned wrong value: 32
I got this one as well. I tested it today again with 5.3.0-rc3+ 0eb0ce0 ("Merge
tag 'spi-fix-v5.3-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi")
and got this error:

copy_file_range02.c:130: FAIL: copy_file_range failed unexpectedly; expected EFBIG, but got: EINVAL

But that is caused by tmpfs used as TMPDIR, going to send a patch fixing it.

Kind regards,
Petr
