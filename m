From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Sep 2020 20:11:52 +0200
Subject: [LTP] [PATCH] utimensat01: Test all available FS and handle FS
 with no attributes
In-Reply-To: <20200929144635.28874-1-rpalethorpe@suse.com>
References: <20200929144635.28874-1-rpalethorpe@suse.com>
Message-ID: <20200929181152.GD15188@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richie,

LGTM.

Although this fails on NTFS and exfat and FUSE.
I don't remember which flag removes these filesystems, there was some
workaround. Cyril, Li, Jan, do you remember?

Kind regards,
Petr

tst_test.c:1248: TINFO: Timeout per run is 0h 05m 00s
utimensat01.c:298: TINFO: Testing variant: syscall with old kernel spec
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:282: TPASS:  0: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:282: TPASS:  1: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:274: TFAIL:  2: atime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:278: TFAIL:  3: mtime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:274: TFAIL:  4: atime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:282: TPASS:  5: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:282: TPASS:  6: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:282: TPASS:  7: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:274: TFAIL:  8: atime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:278: TFAIL:  9: mtime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:274: TFAIL: 10: atime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:282: TPASS: 11: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315525600: 315525600)
utimensat01.c:188: TCONF: Attributes not supported by FS: ENOTTY (25)
tst_test.c:1316: TINFO: Testing on exfat
tst_mkfs.c:89: TINFO: Formatting /dev/loop1 with exfat opts='' extra opts=''
tst_test.c:1248: TINFO: Timeout per run is 0h 05m 00s
utimensat01.c:298: TINFO: Testing variant: syscall with old kernel spec
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:282: TPASS:  0: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:282: TPASS:  1: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:274: TFAIL:  2: atime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:278: TFAIL:  3: mtime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:274: TFAIL:  4: atime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:282: TPASS:  5: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:282: TPASS:  6: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:282: TPASS:  7: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:274: TFAIL:  8: atime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:278: TFAIL:  9: mtime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:274: TFAIL: 10: atime shouldn't have changed but did
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:282: TPASS: 11: utimensat() passed
utimensat01.c:213: TFAIL: Failed to reset access and modification time (315532800: 315532800)
utimensat01.c:188: TCONF: Attributes not supported by FS: ENOTTY (25)
tst_test.c:1316: TINFO: Testing on ntfs
tst_mkfs.c:89: TINFO: Formatting /dev/loop1 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop1 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop1 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop1 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
safe_macros.c:755: TINFO: Trying FUSE...
tst_test.c:1248: TINFO: Timeout per run is 0h 05m 00s
utimensat01.c:298: TINFO: Testing variant: syscall with old kernel spec
utimensat01.c:282: TPASS:  0: utimensat() passed
utimensat01.c:282: TPASS:  1: utimensat() passed
utimensat01.c:282: TPASS:  2: utimensat() passed
utimensat01.c:274: TFAIL:  3: atime should have changed but didn't
utimensat01.c:278: TFAIL:  4: mtime should have changed but didn't
utimensat01.c:282: TPASS:  5: utimensat() passed
utimensat01.c:282: TPASS:  6: utimensat() passed
utimensat01.c:282: TPASS:  7: utimensat() passed
utimensat01.c:282: TPASS:  8: utimensat() passed
utimensat01.c:274: TFAIL:  9: atime should have changed but didn't
utimensat01.c:278: TFAIL: 10: mtime should have changed but didn't
utimensat01.c:282: TPASS: 11: utimensat() passed
utimensat01.c:190: TBROK: ioctl(fd, FS_IOC_GETFLAGS, &attr) failed: EINVAL (22)
