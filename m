From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jan 2020 17:15:18 +0100
Subject: [LTP] LTP Release plans
In-Reply-To: <20200115161510.GA6523@rei.lan>
References: <20191213125435.GB20795@rei.lan> <20200115161510.GA6523@rei.lan>
Message-ID: <CAEemH2fzc4___xYFQTca0MD5gNLxVuOJzFSQqKLiL9L+3Eg1WQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Wed, Jan 15, 2020 at 5:15 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> I've just finished patchwork queue review and I think that we are fine
> and that we should freeze the git for anything but bugfixes at this
> point.
>
> I will do a bit more pre-release testing, however the results so far
> looks good to me.
>

FYI:

I did a round of testing against RHEL6/7/8 and upstream kernel, the test
result looks good except only below tiny issues:

- RHEL6 x86_64 (it is a kernel bug that in old distro)
sysctl02 1 TFAIL: /proc/sys/fs/file-max overflows and is set to 0
sysctl02 2 TINFO: trying to set fs.file-max=18446744073709551615
sysctl02 2 TFAIL: /proc/sys/fs/file-max overflows and is set to
18446744073709551615
sysctl02 3 TINFO: trying to set fs.file-max=9223372036854775808
sysctl02 3 TFAIL: /proc/sys/fs/file-max overflows and is set to
9223372036854775808

fallocate04, fallocate05, fsetxattr01, fdatasync03, fgetxattr01 have the
same issue as:
tst_test.c:1278: INFO: Testing on vfat
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
mkfs.vfat: unable to open /dev/loop0
tst_mkfs.c:101: BROK: mkfs.vfat:1: tst_test.c failed with 831

- RHEL7.8 x86_64
  copy_file_range02 failed as a known kernel bug

- RHEL7.8 ppc64le (I have confirmed the latest rhel7 kernel has fixed this
bug)
timer_delete01.c:47: FAIL: Aborting test -
timer_create(CLOCK_BOOTTIME_ALARM) failed: ??? (524)
timer_delete01.c:36: INFO: Testing CLOCK_REALTIME_ALARM
timer_delete01.c:47: FAIL: Aborting test -
timer_create(CLOCK_REALTIME_ALARM) failed: ??? (524)
timer_delete01.c:36: INFO: Testing CLOCK_TAI
timer_delete01.c:54: PASS: Timer deleted successfully!

- Upstream kernel-5.5.0-rc5 x86_64/aarch64
system hang at fs_fill, it more like the unstable kernel issue but not LTP

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200116/650951c5/attachment.htm>
