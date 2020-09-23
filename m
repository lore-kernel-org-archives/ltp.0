From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 23 Sep 2020 20:23:49 +0800
Subject: [LTP] LTP release
In-Reply-To: <CAEemH2cxf2RQz5psmsaUsBHRrtayLJUVTfCo+NvevSyu7bLmvA@mail.gmail.com>
References: <20200908073138.GB2475@yuki.lan> <20200922182102.GB12980@yuki.lan>
 <CAEemH2dFqYRNNSyhQ1bJ_L+wHFUQkOVBgdnm-_6Nqr4rP7UbBg@mail.gmail.com>
 <CAEemH2cxf2RQz5psmsaUsBHRrtayLJUVTfCo+NvevSyu7bLmvA@mail.gmail.com>
Message-ID: <5F6B3E55.7020700@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

? 2020/9/23 14:58, Li Wang ??:
>
> CC' people who touched the patches maybe give a hand.
>
> On Wed, Sep 23, 2020 at 2:50 PM Li Wang <liwang@redhat.com 
> <mailto:liwang@redhat.com>> wrote:
>
>
>
>     On Wed, Sep 23, 2020 at 2:20 AM Cyril Hrubis <chrubis@suse.cz
>     <mailto:chrubis@suse.cz>> wrote:
>
>         Hi!
>         As far as I can tell I've pushed the last patch that should
>         have been in
>         the release just now. With that we should have a week worth of
>         pre-release testing since we are aiming for a release at the
>         end of the
>         September. If you haven't tried LTP git HEAD yet, please do so
>         now and
>         report any problems you find.
>
>
>     We still got this persistent fail on some kernels(RHEL8,
>     kernel-v5.9-rc4):
>
>     ---
>     send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>     send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>     send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>     send02.c:86: FAIL: recv() error: EAGAIN/EWOULDBLOCK (11)
>
>     ---
>     fanotify10.c:404: TFAIL: group 0 (4) got event: mask 1020
>     (expected 1000) pid=95067 fd=12
>     fanotify10.c:404: TFAIL: group 1 (4) got event: mask 1020
>     (expected 1000) pid=95067 fd=12
>     fanotify10.c:404: TFAIL: group 2 (4) got event: mask 1020
>     (expected 1000) pid=95067 fd=12
>     fanotify10.c:404: TFAIL: group 0 (0) got event: mask 1020
>     (expected 1000) pid=95067 fd=12
>     fanotify10.c:404: TFAIL: group 1 (0) got event: mask 1020
>     (expected 1000) pid=95067 fd=12
>     fanotify10.c:404: TFAIL: group 2 (0) got event: mask 1020
>     (expected 1000) pid=95067 fd=12
>
Hi Li,

I didn't reproduce the issue about fanotify10 on the lastest 
kernel(kernel-v5.9-rc6+):
-------------------------
[root@Fedora-30 fanotify]# ./fanotify10
tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
tst_mkfs.c:89: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.46-WIP (20-Mar-2020)
tst_test.c:1248: TINFO: Timeout per run is 0h 05m 00s
fanotify10.c:452: TINFO: Test #0: ignore mount events created on a 
specific file
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=1981 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=1981 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=1981 fd=15
fanotify10.c:523: TPASS: group 0 (4) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (4) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (4) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (0) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (0) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (0) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (e00) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (e00) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (e00) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:452: TINFO: Test #1: ignore exec mount events created on a 
specific file
fanotify10.c:411: TPASS: group 0 (8) got event: mask 1020 pid=1983 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 1020 pid=1983 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 1020 pid=1983 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 1000 pid=1983 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 1000 pid=1983 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 1000 pid=1983 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 1000 pid=1983 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 1000 pid=1983 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 1000 pid=1983 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 1000 pid=1983 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 1000 pid=1983 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 1000 pid=1983 
fd=4294967295
fanotify10.c:452: TINFO: Test #2: don't ignore mount events created on 
another file
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=1984 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=1984 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=1984 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 20 pid=1984 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 20 pid=1984 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 20 pid=1984 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 20 pid=1984 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 20 pid=1984 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 20 pid=1984 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 20 pid=1984 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 20 pid=1984 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 20 pid=1984 
fd=4294967295
fanotify10.c:452: TINFO: Test #3: don't ignore exec mount events created 
on another file
fanotify10.c:411: TPASS: group 0 (8) got event: mask 1020 pid=1985 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 1020 pid=1985 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 1020 pid=1985 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 1020 pid=1985 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 1020 pid=1985 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 1020 pid=1985 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 1020 pid=1985 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 1020 pid=1985 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 1020 pid=1985 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 1020 pid=1985 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 1020 pid=1985 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 1020 pid=1985 
fd=4294967295
fanotify10.c:452: TINFO: Test #4: ignore inode events created on a 
specific mount point
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=1986 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=1986 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=1986 fd=15
fanotify10.c:523: TPASS: group 0 (4) with FAN_MARK_INODE and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 1 (4) with FAN_MARK_INODE and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 2 (4) with FAN_MARK_INODE and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 0 (0) with FAN_MARK_INODE and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 1 (0) with FAN_MARK_INODE and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 2 (0) with FAN_MARK_INODE and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 0 (e00) with FAN_MARK_INODE and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 1 (e00) with FAN_MARK_INODE and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 2 (e00) with FAN_MARK_INODE and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:452: TINFO: Test #5: ignore exec inode events created on a 
specific mount point
fanotify10.c:411: TPASS: group 0 (8) got event: mask 1020 pid=1987 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 1020 pid=1987 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 1020 pid=1987 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 1000 pid=1987 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 1000 pid=1987 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 1000 pid=1987 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 1000 pid=1987 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 1000 pid=1987 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 1000 pid=1987 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 1000 pid=1987 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 1000 pid=1987 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 1000 pid=1987 
fd=4294967295
fanotify10.c:452: TINFO: Test #6: don't ignore inode events created on 
another mount point
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=1988 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=1988 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=1988 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 20 pid=1988 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 20 pid=1988 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 20 pid=1988 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 20 pid=1988 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 20 pid=1988 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 20 pid=1988 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 20 pid=1988 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 20 pid=1988 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 20 pid=1988 
fd=4294967295
fanotify10.c:452: TINFO: Test #7: don't ignore exec inode events created 
on another mount point
fanotify10.c:411: TPASS: group 0 (8) got event: mask 1020 pid=1989 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 1020 pid=1989 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 1020 pid=1989 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 1020 pid=1989 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 1020 pid=1989 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 1020 pid=1989 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 1020 pid=1989 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 1020 pid=1989 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 1020 pid=1989 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 1020 pid=1989 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 1020 pid=1989 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 1020 pid=1989 
fd=4294967295
fanotify10.c:452: TINFO: Test #8: ignore fs events created on a specific 
file
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=1990 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=1990 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=1990 fd=15
fanotify10.c:523: TPASS: group 0 (4) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (4) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (4) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (0) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (0) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (0) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (e00) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (e00) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (e00) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:452: TINFO: Test #9: ignore exec fs events created on a 
specific file
fanotify10.c:411: TPASS: group 0 (8) got event: mask 1020 pid=1991 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 1020 pid=1991 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 1020 pid=1991 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 1000 pid=1991 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 1000 pid=1991 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 1000 pid=1991 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 1000 pid=1991 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 1000 pid=1991 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 1000 pid=1991 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 1000 pid=1991 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 1000 pid=1991 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 1000 pid=1991 
fd=4294967295
fanotify10.c:452: TINFO: Test #10: don't ignore mount events created on 
another file
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=1992 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=1992 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=1992 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 20 pid=1992 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 20 pid=1992 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 20 pid=1992 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 20 pid=1992 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 20 pid=1992 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 20 pid=1992 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 20 pid=1992 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 20 pid=1992 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 20 pid=1992 
fd=4294967295
fanotify10.c:452: TINFO: Test #11: don't ignore exec mount events 
created on another file
fanotify10.c:411: TPASS: group 0 (8) got event: mask 1020 pid=1993 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 1020 pid=1993 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 1020 pid=1993 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 1020 pid=1993 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 1020 pid=1993 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 1020 pid=1993 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 1020 pid=1993 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 1020 pid=1993 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 1020 pid=1993 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 1020 pid=1993 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 1020 pid=1993 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 1020 pid=1993 
fd=4294967295
fanotify10.c:452: TINFO: Test #12: ignore fs events created on a 
specific mount point
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=1994 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=1994 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=1994 fd=15
fanotify10.c:523: TPASS: group 0 (4) with FAN_MARK_FILESYSTEM and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 1 (4) with FAN_MARK_FILESYSTEM and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 2 (4) with FAN_MARK_FILESYSTEM and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 0 (0) with FAN_MARK_FILESYSTEM and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 1 (0) with FAN_MARK_FILESYSTEM and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 2 (0) with FAN_MARK_FILESYSTEM and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 0 (e00) with FAN_MARK_FILESYSTEM and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 1 (e00) with FAN_MARK_FILESYSTEM and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:523: TPASS: group 2 (e00) with FAN_MARK_FILESYSTEM and 
FAN_MARK_MOUNT ignore mask got no event
fanotify10.c:452: TINFO: Test #13: ignore exec fs events created on a 
specific mount point
fanotify10.c:411: TPASS: group 0 (8) got event: mask 1020 pid=1995 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 1020 pid=1995 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 1020 pid=1995 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 1000 pid=1995 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 1000 pid=1995 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 1000 pid=1995 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 1000 pid=1995 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 1000 pid=1995 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 1000 pid=1995 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 1000 pid=1995 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 1000 pid=1995 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 1000 pid=1995 
fd=4294967295
fanotify10.c:452: TINFO: Test #14: don't ignore fs events created on 
another mount point
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=1996 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=1996 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=1996 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 20 pid=1996 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 20 pid=1996 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 20 pid=1996 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 20 pid=1996 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 20 pid=1996 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 20 pid=1996 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 20 pid=1996 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 20 pid=1996 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 20 pid=1996 
fd=4294967295
fanotify10.c:452: TINFO: Test #15: don't ignore exec fs events created 
on another mount point
fanotify10.c:411: TPASS: group 0 (8) got event: mask 1020 pid=1997 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 1020 pid=1997 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 1020 pid=1997 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 1020 pid=1997 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 1020 pid=1997 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 1020 pid=1997 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 1020 pid=1997 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 1020 pid=1997 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 1020 pid=1997 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 1020 pid=1997 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 1020 pid=1997 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 1020 pid=1997 
fd=4294967295
fanotify10.c:452: TINFO: Test #16: ignore child exec events created on a 
specific mount point
fanotify10.c:411: TPASS: group 0 (8) got event: mask 1020 pid=1998 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 1020 pid=1998 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 1020 pid=1998 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 1000 pid=1998 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 1000 pid=1998 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 1000 pid=1998 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 1000 pid=1998 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 1000 pid=1998 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 1000 pid=1998 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 1000 pid=1998 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 1000 pid=1998 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 1000 pid=1998 
fd=4294967295
fanotify10.c:452: TINFO: Test #17: ignore events on children of 
directory created on a specific file
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=1999 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=1999 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=1999 fd=15
fanotify10.c:523: TPASS: group 0 (4) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (4) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (4) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (0) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (0) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (0) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (e00) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (e00) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (e00) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:452: TINFO: Test #18: ignore events on file created inside 
a parent watching children
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=2000 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=2000 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=2000 fd=15
fanotify10.c:523: TPASS: group 0 (4) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (4) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (4) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (0) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (0) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (0) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (e00) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (e00) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (e00) with FAN_MARK_INODE and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:452: TINFO: Test #19: don't ignore events on file created 
inside a parent not watching children
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=2001 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=2001 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=2001 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 20 pid=2001 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 20 pid=2001 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 20 pid=2001 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 20 pid=2001 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 20 pid=2001 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 20 pid=2001 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 20 pid=2001 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 20 pid=2001 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 20 pid=2001 
fd=4294967295
fanotify10.c:452: TINFO: Test #20: ignore mount events created inside a 
parent watching children
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=2002 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=2002 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=2002 fd=15
fanotify10.c:523: TPASS: group 0 (4) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (4) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (4) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (0) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (0) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (0) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (e00) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (e00) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (e00) with FAN_MARK_MOUNT and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:452: TINFO: Test #21: don't ignore mount events created 
inside a parent not watching children
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=2003 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=2003 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=2003 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 20 pid=2003 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 20 pid=2003 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 20 pid=2003 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 20 pid=2003 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 20 pid=2003 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 20 pid=2003 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 20 pid=2003 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 20 pid=2003 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 20 pid=2003 
fd=4294967295
fanotify10.c:452: TINFO: Test #22: ignore fs events created inside a 
parent watching children
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=2004 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=2004 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=2004 fd=15
fanotify10.c:523: TPASS: group 0 (4) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (4) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (4) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (0) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (0) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (0) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 0 (e00) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 1 (e00) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:523: TPASS: group 2 (e00) with FAN_MARK_FILESYSTEM and 
FAN_MARK_INODE ignore mask got no event
fanotify10.c:452: TINFO: Test #23: don't ignore fs events created inside 
a parent not watching children
fanotify10.c:411: TPASS: group 0 (8) got event: mask 20 pid=2005 fd=15
fanotify10.c:411: TPASS: group 1 (8) got event: mask 20 pid=2005 fd=15
fanotify10.c:411: TPASS: group 2 (8) got event: mask 20 pid=2005 fd=15
fanotify10.c:411: TPASS: group 0 (4) got event: mask 20 pid=2005 fd=15
fanotify10.c:411: TPASS: group 1 (4) got event: mask 20 pid=2005 fd=15
fanotify10.c:411: TPASS: group 2 (4) got event: mask 20 pid=2005 fd=15
fanotify10.c:411: TPASS: group 0 (0) got event: mask 20 pid=2005 fd=15
fanotify10.c:411: TPASS: group 1 (0) got event: mask 20 pid=2005 fd=15
fanotify10.c:411: TPASS: group 2 (0) got event: mask 20 pid=2005 fd=15
fanotify10.c:411: TPASS: group 0 (e00) got event: mask 20 pid=2005 
fd=4294967295
fanotify10.c:411: TPASS: group 1 (e00) got event: mask 20 pid=2005 
fd=4294967295
fanotify10.c:411: TPASS: group 2 (e00) got event: mask 20 pid=2005 
fd=4294967295

Summary:
passed   288
failed   0
skipped  0
warnings 0
-------------------------
Is the issue fixed recently? :-)

Best Regards,
Xiao Yang
>
>
>     ---
>     recvmmsg01.c:86:9: error: request for member ?type? in something
>     not a structure or union
>       timeout.type = tv->ts_type;
>
>     Otherwise, the latest LTP test good from my side(RHEL8,
>     mainline-kernel).
>
>     -- 
>     Regards,
>     Li Wang
>
>
>
> -- 
> Regards,
> Li Wang
>
>
>



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200923/dc403799/attachment-0001.htm>
