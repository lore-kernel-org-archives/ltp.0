From: Jan Stancek <jstancek@redhat.com>
Date: Sun, 27 Oct 2019 05:32:23 -0400 (EDT)
Subject: [LTP] =?utf-8?b?4p2MIEZBSUw6IFN0YWJsZSBxdWV1ZTogcXVldWUtNS4z?=
In-Reply-To: <CA+G9fYurG8gSO+xFc5LJvLMrqTyHG85oxH9=pSQ1LmPCa6PkqQ@mail.gmail.com>
References: <cki.61C56EFD16.AR8ITWHB7P@redhat.com>
 <CA+G9fYurG8gSO+xFc5LJvLMrqTyHG85oxH9=pSQ1LmPCa6PkqQ@mail.gmail.com>
Message-ID: <2111263587.9218283.1572168743324.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> On Sun, 27 Oct 2019 at 04:04, CKI Project <cki-project@redhat.com> wrote:
> >
> >
> > Hello,
> >
> > We ran automated tests on a patchset that was proposed for merging into
> > this
> > kernel tree. The patches were applied to:
> >
> >        Kernel repo:
> >        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> >             Commit: 365dab61f74e - Linux 5.3.7
> >
> > The results of these automated tests are provided below.
> >
> >     Overall result: FAILED (see details below)
> >              Merge: OK
> >            Compile: OK
> >              Tests: FAILED
> >
> > All kernel binaries, config files, and logs are available for download
> > here:
> >
> >   https://artifacts.cki-project.org/pipelines/249576
> >
> > One or more kernel tests failed:
> >
> >     x86_64:
> >      ? LTP lite
> 
> I see these three failures from the logs,

[CC LTP list]

> 
> LTP syscalls:
> fallocate05                                        FAIL       1

tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.45.3 (14-Jul-2019)
tst_test.c:1116: INFO: Timeout per run is 0h 05m 00s
tst_fill_fs.c:29: INFO: Creating file mntpoint/file0 size 21710183
tst_fill_fs.c:29: INFO: Creating file mntpoint/file1 size 8070086
tst_fill_fs.c:29: INFO: Creating file mntpoint/file2 size 3971177
tst_fill_fs.c:29: INFO: Creating file mntpoint/file3 size 36915315
tst_fill_fs.c:29: INFO: Creating file mntpoint/file4 size 70310993
tst_fill_fs.c:29: INFO: Creating file mntpoint/file5 size 4807935
tst_fill_fs.c:29: INFO: Creating file mntpoint/file6 size 90739786
tst_fill_fs.c:29: INFO: Creating file mntpoint/file7 size 76896492
tst_fill_fs.c:49: INFO: write(): ENOSPC (28)
fallocate05.c:50: PASS: write() wrote 8192 bytes
fallocate05.c:54: FAIL: fallocate() succeeded unexpectedly

So, test filled filesystem and fallocate() succeeded anyway.

> 
> LTP mm:
> oom03                                              FAIL       2
> oom05                                              FAIL       2

This looks like test issue. systemd on Fedora31 started using cgroup2 exclusively:
  cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,seclabel,nsdelegate)

Tests are trying to mount single hierarchy on cgroup1:
[pid 283933] 04:57:26 mkdir("/dev/cgroup", 0777) = 0
[pid 283933] 04:57:26 mount("memcg", "/dev/cgroup", "cgroup", 0, "memory") = -1 EBUSY (Device or resource busy)

