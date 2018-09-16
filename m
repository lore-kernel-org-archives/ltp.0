From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Sun, 16 Sep 2018 13:26:04 -0300
Subject: [LTP] statx04.c:53: FAIL: STATX_ATTR_COMPRESSED flag is not set
 - Testing on ext2
In-Reply-To: <CA+G9fYsr=iYgaaepEnJOOu_-bR0p=3gCxAhcw6adQWPUnPfiYA@mail.gmail.com>
References: <CA+G9fYsr=iYgaaepEnJOOu_-bR0p=3gCxAhcw6adQWPUnPfiYA@mail.gmail.com>
Message-ID: <CABdQkv-VBcEUx=mat_F-eUg9a-3Z95Z44zcWGmdGkP0kBeGB0w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Naresh,

I could not reproduce this result, after 200 iterations, in KVM ARM64,
nor in Hikey960, using v4.18.8-0-gdfba61ec760e and latest LTP. I have
also compiled the same kernel as this LKFT test (94710cac0e) and
couldn't reproduce this issue. My config file is a merge in between
LKFT hikey config and some Debian options.

I have downloaded and booted my Hikey960 with kernel from:
http://snapshots.linaro.org/openembedded/ltp/rocko/hikey/300/rpb/

And noticed that:

inaddy@hikey:~$ zcat /proc/config.gz | grep EXT
...
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
...

And just to confirm I tried:

tst_test.c:1124: INFO: Testing on ext2
tst_mkfs.c:90: INFO: Formatting /dev/loop1 with ext2 opts='' extra opts=''
mke2fs 1.44.3 (10-July-2018)
tst_test.c:1063: INFO: Timeout per run is 0h 05m 00s
fsetxattr01.c:186: PASS: fsetxattr(2) failed: EINVAL
fsetxattr01.c:150: CONF: fsetxattr(2) not supported

Then I tried the same xattr04 test and:

tst_test.c:1124: INFO: Testing on ext2
tst_mkfs.c:90: INFO: Formatting /dev/loop1 with ext2 opts='' extra opts=''
mke2fs 1.44.3 (10-July-2018)
tst_test.c:1063: INFO: Timeout per run is 0h 05m 00s
statx04.c:45: PASS: sys_statx(AT_FDCWD, mntpoint/test_dir1, 0, 0, &buf)
statx04.c:53: FAIL: STATX_ATTR_COMPRESSED flag is not set
statx04.c:58: FAIL: STATX_ATTR_APPEND flag is not set
statx04.c:63: FAIL: STATX_ATTR_IMMUTABLE flag is not set
statx04.c:68: FAIL: STATX_ATTR_NODUMP flag is not set

and it failed like yours.

Doing same thing, by hand, I had:

inaddy@hikey:~$ dd if=/dev/zero of=./teste bs=1M count=100
100+0 records in
100+0 records out
104857600 bytes (105 MB, 100 MiB) copied, 1.30856 s, 80.1 MB/s
inaddy@hikey:~$ sudo losetup -P /dev/loop0 /home/inaddy/teste
inaddy@hikey:~$ sudo mkfs.ext2 /dev/loop0
mke2fs 1.44.3 (10-July-2018)
Discarding device blocks: done
Creating filesystem with 102400 1k blocks and 25688 inodes
...

inaddy@hikey:/mnt$ sudo touch file
inaddy@hikey:/mnt$ sudo mkdir directory
inaddy@hikey:/mnt$ sudo chattr +acid ./file
inaddy@hikey:/mnt$ sudo chattr +acid ./directory
inaddy@hikey:/mnt$ sudo lsattr ./file
----iad-c--------- ./file
inaddy@hikey:/mnt$ sudo lsattr ./directory
inaddy@hikey:/mnt$

which indicates that directory attributes did not work.

Checking differences from my build to LKFT build:

$ zcat /proc/config.gz | grep EXT2
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set

$ cat /boot/config-4.18.0 | grep EXT2
# CONFIG_EXT2_FS is not set
CONFIG_EXT4_USE_FOR_EXT2=y

And checking behaviour in an environment with CONFIG_EXT4_USE_FOR_EXT2:

inaddy@statx04bug:~$ cd /mnt
inaddy@statx04bug:/mnt$ sudo touch file
inaddy@statx04bug:/mnt$ sudo touch directory
inaddy@statx04bug:/mnt$ sudo chattr +acid ./file
inaddy@statx04bug:/mnt$ sudo chattr +acid ./directory
inaddy@statx04bug:/mnt$ sudo lsattr file
----iad-c---------- file
inaddy@statx04bug:/mnt$ sudo lsattr directory
----iad-c---------- directory

I suppose this error is because Hikey builds are actually using EXT2
code and not EXT4 as EXT2 compatible code.

Now, the REAL QUESTION, should EXT2 old code support attributes for
directories ?
Is this a regression or a feature that never existed for EXT2 old code ?
