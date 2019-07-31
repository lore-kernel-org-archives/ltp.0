From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Jul 2019 22:51:31 +0200
Subject: [LTP] [PATCH 1/1] syscalls/ioctl08: Require btrfs
In-Reply-To: <20190729141920.GA4040@dell5510>
References: <20190703154709.20863-1-pvorel@suse.cz>
 <20190729141920.GA4040@dell5510>
Message-ID: <20190731205131.GA26660@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> > Test requires btrfs otherwise it fails:
> > WARNING: failed to open /dev/btrfs-control, skipping device
> > registration: No such file or directory
> > safe_macros.c:757: BROK: tst_test.c:752: mount(/dev/loop0, mnt_point,
> > btrfs, 0, (nil)) failed: ENODEV
> could you please test it?

I tested it on kernel without btrfs and it works as expected, thus pushed.
Thanks again for your report.

Kind regards,
Petr
