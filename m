From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Jul 2019 15:26:27 +0200
Subject: [LTP] 56cbb429d9: ltp.fs_fill.fail
In-Reply-To: <20190725110944.GA22106@shao2-debian>
References: <20190725110944.GA22106@shao2-debian>
Message-ID: <20190725132617.GA23135@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> tst_test.c:1161: INFO: Testing on vfat
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> mkfs.vfat: unable to open /dev/loop0: Device or resource busy
> tst_mkfs.c:101: BROK: mkfs.vfat:1: tst_test.c failed with 741

This looks like mkfs.vfat got EBUSY after the loop device was
succesfully umounted.

We do run the test in a loop for several filesystems and the loop
generally does:

next:
	mkfs
	mount
	test
	umount
	goto next;

-- 
Cyril Hrubis
chrubis@suse.cz
