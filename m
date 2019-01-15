From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 15 Jan 2019 09:33:58 -0200
Subject: [LTP] LTP: '/proc/self/io' for reading at readahead02.c:113:
 ENOENT No such file or directory
In-Reply-To: <CA+G9fYvA4XWajkvS9pP8vpFjPx=j+3F9TiueUrGjQ2RQ8vJiAQ@mail.gmail.com>
References: <CA+G9fYvA4XWajkvS9pP8vpFjPx=j+3F9TiueUrGjQ2RQ8vJiAQ@mail.gmail.com>
Message-ID: <012C4B00-3BFA-4322-8D16-FE4736B63DBE@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> readahead02 used to pass on arm32 on LTP-20180926 release. Now using
> the latest LTP master it is getting FAILED.
> 
> tst_device.c:230: INFO: Using test device LTP_DEV='/dev/loop0'
> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.43.5 (04-Aug-2017)
> [  603.092608] EXT4-fs (loop0): mounting ext2 file system using the
> ext4 subsystem
> [  603.107967] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
> tst_test.c:1085: INFO: Timeout per run is 0h 15m 00s
> readahead02.c:359: INFO: overlayfs is not configured in this kernel.
> readahead02.c:244: INFO: Test #0: readahead on file
> readahead02.c:134: INFO: creating test file of size: 67108864
> safe_file_ops.c:202: BROK: Failed to open FILE '/proc/self/io' for
> reading at readahead02.c:113: ENOENT
> 
> Best regards
> Naresh Kamboju

Naresh,

Commit 75506e4f1b52ea6bb63a52afb34035d9dde55d14 (syscalls/readahead02:
Simplify reading proc files) has added SAFE_FILE_LINES_SCANF() macro,
that is causing test to be BROKEN because it can’t find “/proc/self/io”.
IIRC, proc/self/io needs CONFIG_TASKSTATS to be enabled in kernel config
(looks like we are not enabling CONFIG_TASKSTATS in our config files for
beagle board, for example).

Looks like this test was passing by accident before, since there was no
/proc/self/io to be read in function get_bytes_read().

Cheers o/

Rafael
—
Rafael D. Tinoco
Linaro Kernel Validation
