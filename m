From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Sep 2020 10:36:23 +0200
Subject: [LTP] Error with fs_fill
In-Reply-To: <BMXPR01MB23445019F67B128E04B26612EE250@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB23445019F67B128E04B26612EE250@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20200914083623.GA5524@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> tst_test.c:1250: INFO: Timeout per run is 0h 05m 00s
> fs_fill.c:103: INFO: Running 6 writer threads
>      tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread1/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread5/file0
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> tst_fill_fs.c:39: INFO: open(): ENOSPC (28)
> fs_fill.c:53: INFO: Unlinking mntpoint/thread4/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread6/file0
> fs_fill.c:53: INFO: Unlinking mntpoint/thread2/file0
> safe_macros.c:366: BROK: fs_fill.c:55: unlink(mntpoint/thread4/file0) failed: ENOSPC (28)

This is a bug in Btrfs deallocation metadata reservation.

-- 
Cyril Hrubis
chrubis@suse.cz
