From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Apr 2021 21:14:59 +0200
Subject: [LTP] [PATCH] Ignore ntfs file system
In-Reply-To: <53b80b9e-42f6-90f7-1199-3592b4e5fcaa@uniontech.com>
References: <20210425030440.12762-1-zhanglianjie@uniontech.com>
 <YIcTuE34yq8KISC5@pevik>
 <726f49eb-a185-6637-44e3-232d5e9b6fab@uniontech.com>
 <YIgRWZFymSmCKFyS@pevik>
 <53b80b9e-42f6-90f7-1199-3592b4e5fcaa@uniontech.com>
Message-ID: <YIhis6EzwnuBEKO5@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > > Shouldn't "ntfs" *replace* "fuse"?
> > > Can't replace fuse.
> > Not sure if we understand each other: I mean add "ntfs" and *remove* "fuse",
> > as "fuse" is now redundant when we whitelist ntfs (see
> > tst_get_supported_fs_types()), unless there is problem with other fuse
> > filesystems. I tested with CONFIG_FUSE_FS=m CONFIG_EXFAT_FS=m.

> > But maybe removing "fuse" should be a separate step.

> I can understand what you mean, but I can't remove the fuse. If the fuse is
> removed and the kernel is not configured with CONFIG_EXFAT_FS=m, it will
> cause the test exfat to fail.

You're right, I didn't notice I tested it without mount.exfat. Sorry for being
slow. Interesting that while NTFS kernel module does not work on the test, exfat
from Samsung does.

Anyway merged. Thanks!

Kind regards,
Petr
