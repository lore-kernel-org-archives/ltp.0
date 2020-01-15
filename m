From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 15 Jan 2020 15:32:07 +0100
Subject: [LTP] mkfs.vfat: Device partition expected,
 not making filesystem on entire device '/dev/vdb' (use -I to
 override)
In-Reply-To: <20200115124044.GC14046@rei.lan>
References: <20200115110922.GB26763@dell5510> <20200115124044.GC14046@rei.lan>
Message-ID: <20200115143207.GB28253@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> > there is a problem with mkfs.vfat, when LTP_DEV is full block device:

> > # ltp_dev=/dev/vdb fsync04
> > ...
> > tst_test.c:1278: INFO: Testing on vfat
> > tst_mkfs.c:92: INFO: Formatting /dev/vdb with vfat opts='' extra opts=''
> > mkfs.vfat: Device partition expected, not making filesystem on entire device '/dev/vdb' (use -I to override)
> > tst_mkfs.c:103: BROK: mkfs.vfat:1: tst_test.c failed with 830

> > Do we want to add permanently -I to vfat?
> > Or is it too hacky to trying to workaround tool's problem in the code?

> I would say that you are supposed to create partition on a real device
> without creating a partition first, but you can always outvote me.
No, I don't want to outvote you :). I'm just missing something as the device is
just /dev/vdb without any partition.

Kind regards,
Petr
