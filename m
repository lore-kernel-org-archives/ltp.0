From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 3 Jul 2019 18:01:53 +0200
Subject: [LTP] [PATCH v2] syscalls/ioctl08: add file deduplication
 testcases
In-Reply-To: <CAOQ4uxhT_BwUA=3sFdhdKfYhMeBqMPwe1sHvXR5jLaDu8u+2zQ@mail.gmail.com>
References: <20190322133228.18901-1-camann@suse.com>
 <20190325101404.GA20297@dell5510>
 <CAOQ4uxhT_BwUA=3sFdhdKfYhMeBqMPwe1sHvXR5jLaDu8u+2zQ@mail.gmail.com>
Message-ID: <20190703160153.GA24202@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> FYI, This test fails on kernel without btrfs support.

> WARNING: failed to open /dev/btrfs-control, skipping device
> registration: No such file or directory
> safe_macros.c:757: BROK: tst_test.c:752: mount(/dev/loop0, mnt_point,
> btrfs, 0, (nil)) failed: ENODEV

FYI: patch sent
https://patchwork.ozlabs.org/patch/1126923/

> Thanks,
> Amir.

Kind regards,
Petr
