From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Mon, 14 Sep 2020 08:39:31 +0000
Subject: [LTP] Error with fs_fill
In-Reply-To: <20200914083623.GA5524@yuki.lan>
References: <BMXPR01MB23445019F67B128E04B26612EE250@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>,
 <20200914083623.GA5524@yuki.lan>
Message-ID: <BMXPR01MB23441EA1A33E38BF93274ED1EE230@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
how i can resolve it? is there any way that i can find what's exactly happening ??


Thanks!
________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Monday, September 14, 2020 2:06 PM
To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] Error with fs_fill

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
[EXT]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200914/87071899/attachment-0001.htm>
