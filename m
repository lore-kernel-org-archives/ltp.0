From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 Jan 2019 17:59:07 +0530
Subject: [LTP] LTP: '/proc/self/io' for reading at readahead02.c:113:
 ENOENT No such file or directory
In-Reply-To: <3C92119D-9552-42E0-A2D6-1DF028259BDF@linaro.org>
References: <CA+G9fYvA4XWajkvS9pP8vpFjPx=j+3F9TiueUrGjQ2RQ8vJiAQ@mail.gmail.com>
 <1555912299.96157256.1547552179354.JavaMail.zimbra@redhat.com>
 <5870BC5B-530B-49CE-A251-DBF950C1F994@fastmail.com>
 <3C92119D-9552-42E0-A2D6-1DF028259BDF@linaro.org>
Message-ID: <CA+G9fYvSFLaDxe+OFi2MawCHoi9WvStxjSqkwsRne8xqR-DVBw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 15 Jan 2019 at 17:36, Rafael David Tinoco
<rafael.tinoco@linaro.org> wrote:
>
> > On 15 Jan 2019, at 09:36, Jan Stancek <jstancek@redhat.com> wrote:
> >
> > ----- Original Message -----
> >> readahead02 used to pass on arm32 on LTP-20180926 release. Now using
> >> the latest LTP master it is getting FAILED.
> >>
> >> tst_device.c:230: INFO: Using test device LTP_DEV='/dev/loop0'
> >> tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> >> mke2fs 1.43.5 (04-Aug-2017)
> >> [  603.092608] EXT4-fs (loop0): mounting ext2 file system using the
> >> ext4 subsystem
> >> [  603.107967] EXT4-fs (loop0): mounted filesystem without journal. Opts:
> >> (null)
> >> tst_test.c:1085: INFO: Timeout per run is 0h 15m 00s
> >> readahead02.c:359: INFO: overlayfs is not configured in this kernel.
> >> readahead02.c:244: INFO: Test #0: readahead on file
> >> readahead02.c:134: INFO: creating test file of size: 67108864
> >> safe_file_ops.c:202: BROK: Failed to open FILE '/proc/self/io' for
> >> reading at readahead02.c:113: ENOENT
> >
> > We switched from /proc/$pid to /proc/self in December:
> > commit 75506e4f1b52ea6bb63a52afb34035d9dde55d14
> > Date:   Tue Dec 4 14:54:19 2018 +0100
> >   syscalls/readahead02: Simplify reading proc files
> >
> >   Use SAFE_FILE_LINES_SCANF() for parsing multiline /proc/ files
> >    Use /proc/self/io instead of /proc/$pid/io.
> >
> > @Naresh, what is the kernel version you see this fail with?
>
> I missed /proc/$pid/io in my previous e-mail, as Jan stated. So the test
> was likely working because of that.
>
> So, the only thing missing might be CONFIG_TASKSTATS and
> CONFIG_TASK_IO_ACCOUNTING to be set in kernel config for our arm 32-bit
> builds.

This explanation is useful thanks Jan and Rafael.

- Naresh
