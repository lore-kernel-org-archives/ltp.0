From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 6 Nov 2018 14:06:41 +0100
Subject: [LTP] [PATCH 1/1] syscalls/fanotify10: Require kernel v4.19
In-Reply-To: <CAOQ4uxhd9XZj=zvkm1j8mZBkBRw0qhvfwcaRQKzs24bVjsfUZw@mail.gmail.com>
References: <20181106124802.27170-1-pvorel@suse.cz>
 <20181106125015.GB4834@rei.lan> <20181106125556.GA28469@dell5510>
 <CAOQ4uxhd9XZj=zvkm1j8mZBkBRw0qhvfwcaRQKzs24bVjsfUZw@mail.gmail.com>
Message-ID: <20181106130641.GB28469@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> There must be some confusion.
> FAN_MARK_MOUNT was NOT added in v4.19-rc2.
> It has been there from the start.
> FAN_MARK_INODE was NOT added either
> the define FAN_MARK_INODE  0 is just a convenience readability define
> it does not change the API.
I'm sorry, you're right.

> You may be confusing with FAN_MARK_FILESYSTEM
> just was just added in kernel v4.20-rc1.
> The extension of tests to cover FAN_MARK_FILESYSTEM
> is waiting in my queue:
> https://github.com/amir73il/ltp/commits/fanotify_sb

> And it already includes runtime checks for FAN_MARK_FILESYSTEM
> support.

> Did I miss anything?
Testing your branch on older kernel, fanotify10 fails earlier than new TCONF
checks:

tst_device.c:83: INFO: Found free device '/dev/loop0'
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.44.2 (14-May-2018)
tst_test.c:1085: INFO: Timeout per run is 0h 05m 00s
fanotify10.c:233: INFO: Test #0: ignore mount events created on a specific file
fanotify10.c:221: PASS: group 0 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 1 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 2 got event: mask 20 pid=6942 fd=12
fanotify10.c:299: PASS: group 0 (prio 1) with FAN_MARK_MOUNT and FAN_MARK_INODE ignore mask got no event
fanotify10.c:299: PASS: group 1 (prio 1) with FAN_MARK_MOUNT and FAN_MARK_INODE ignore mask got no event
fanotify10.c:299: PASS: group 2 (prio 1) with FAN_MARK_MOUNT and FAN_MARK_INODE ignore mask got no event
fanotify10.c:299: PASS: group 0 (prio 2) with FAN_MARK_MOUNT and FAN_MARK_INODE ignore mask got no event
fanotify10.c:299: PASS: group 1 (prio 2) with FAN_MARK_MOUNT and FAN_MARK_INODE ignore mask got no event
fanotify10.c:299: PASS: group 2 (prio 2) with FAN_MARK_MOUNT and FAN_MARK_INODE ignore mask got no event
fanotify10.c:233: INFO: Test #1: don't ignore mount events created on another file
fanotify10.c:221: PASS: group 0 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 1 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 2 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 0 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 1 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 2 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 0 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 1 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 2 got event: mask 20 pid=6942 fd=12
fanotify10.c:233: INFO: Test #2: ignore inode events created on a specific mount point
fanotify10.c:221: PASS: group 0 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 1 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 2 got event: mask 20 pid=6942 fd=12
fanotify10.c:293: FAIL: group 0 (prio 1) with FAN_MARK_INODE and FAN_MARK_MOUNT ignore mask got event
fanotify10.c:293: FAIL: group 1 (prio 1) with FAN_MARK_INODE and FAN_MARK_MOUNT ignore mask got event
fanotify10.c:293: FAIL: group 2 (prio 1) with FAN_MARK_INODE and FAN_MARK_MOUNT ignore mask got event
fanotify10.c:293: FAIL: group 0 (prio 2) with FAN_MARK_INODE and FAN_MARK_MOUNT ignore mask got event
fanotify10.c:293: FAIL: group 1 (prio 2) with FAN_MARK_INODE and FAN_MARK_MOUNT ignore mask got event
fanotify10.c:293: FAIL: group 2 (prio 2) with FAN_MARK_INODE and FAN_MARK_MOUNT ignore mask got event
fanotify10.c:233: INFO: Test #3: don't ignore inode events created on another mount point
fanotify10.c:221: PASS: group 0 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 1 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 2 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 0 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 1 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 2 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 0 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 1 got event: mask 20 pid=6942 fd=12
fanotify10.c:221: PASS: group 2 got event: mask 20 pid=6942 fd=12
fanotify10.c:233: INFO: Test #4: ignore fs events created on a specific file
fanotify10.c:162: CONF: FAN_MARK_FILESYSTEM not supported in kernel?
fanotify10.c:233: INFO: Test #5: don't ignore mount events created on another file
fanotify10.c:162: CONF: FAN_MARK_FILESYSTEM not supported in kernel?
fanotify10.c:233: INFO: Test #6: ignore fs events created on a specific mount point
fanotify10.c:162: CONF: FAN_MARK_FILESYSTEM not supported in kernel?
fanotify10.c:233: INFO: Test #7: don't ignore fs events created on another mount point
fanotify10.c:162: CONF: FAN_MARK_FILESYSTEM not supported in kernel?

Summary:
passed   30
failed   6
skipped  4
warnings 0


Kind regards,
Petr
