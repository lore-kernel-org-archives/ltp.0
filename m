From: Zorro Lang <zlang@redhat.com>
Date: Wed, 15 Jan 2020 17:01:26 +0800
Subject: [LTP] [PATCH v3] syscalls/newmount: new test case for new mount
 API
In-Reply-To: <20200114095804.GA9211@dell5510>
References: <20191209160227.16125-1-zlang@redhat.com>
 <20191226072338.GH14328@dhcp-12-102.nay.redhat.com>
 <20200113153141.GA14282@dhcp-12-102.nay.redhat.com>
 <20200114081449.GB3468@dell5510>
 <20200114093633.GD14282@dhcp-12-102.nay.redhat.com>
 <20200114095804.GA9211@dell5510>
Message-ID: <20200115090125.GE14282@dhcp-12-102.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 14, 2020 at 10:58:04AM +0100, Petr Vorel wrote:
> Hi Zorro,
> 
> > > > ping again ... is there anything block this patch review?
> > > Here are my comments to your v3 review [1]. Some of them are now irrelevant
> > > as you're fixed them in v3 (Cyril ones from v1).
> 
> > Wow, now I know why I didn't get any response for such long time. The emails
> > from you and Cyril were all sent to mail list, not to/cc me. I didn't pay so
> > much attention to the mail list. Sorry about that.
> OK good :). I'm sorry to forget to Cc you in some of my replies (I usually pay
> attention to Cc people). It's also safer to look at ML or patchwork as this
> sometimes happen :).
> 
> > > So it might be just .dev_fs_flags = TST_FS_SKIP_FUSE and tiny style fixes like

Hi,

About the TST_FS_SKIP_FUSE flag I have below questions:

1) About ntfs and vfat test
You said below content in [1]:

  I like you use .all_filesystems = 1 as I suggested in [1], but I warned that it
  breaks nfs.
  newmount01.c:58: FAIL: fsopen ntfs: ENODEV (19)

  Fortunately this does not need any patch for filtering nfs as TST_FS_SKIP_FUSE
  is enough for it - add this to struct tst_test:
  .dev_fs_flags = TST_FS_SKIP_FUSE

  Not sure if just fsopen() is affected, but it probably does not make sense to test
  just fsopen() and fsconfig().

Actually if you fsopen("ntfs", ...), it doesn't test FUSE. It's testing linux
kernel ntfs:
  # lsmod |grep ntfs
  ntfs                  819200  0

Similar for vfat:
  # lsmod |grep fat
  vfat                   45056  0
  fat                   274432  1 vfat

And from my test on linux 5.5-rc4, the ntfs and vfat can test passed:
  ...
  tst_test.c:1278: INFO: Testing on vfat
  tst_mkfs.c:90: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
  tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
  newmount01.c:62: PASS: fsopen vfat
  newmount01.c:69: PASS: fsconfig set source to /dev/loop0
  newmount01.c:77: PASS: fsconfig create superblock
  newmount01.c:84: PASS: fsmount
  newmount01.c:92: PASS: move_mount attach to mount point
  newmount01.c:96: PASS: new mount works
  tst_test.c:1278: INFO: Testing on ntfs
  tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
  The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
  The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
  The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
  To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
  Windows will not be able to boot from this device.
  tst_test.c:1217: INFO: Timeout per run is 0h 05m 00s
  newmount01.c:62: PASS: fsopen ntfs
  newmount01.c:69: PASS: fsconfig set source to /dev/loop0
  newmount01.c:77: PASS: fsconfig create superblock
  newmount01.c:84: PASS: fsmount
  newmount01.c:92: PASS: move_mount attach to mount point
  newmount01.c:96: PASS: new mount works

You hit that error, maybe due to your current kernel didn't build these fs
modules, but your system has mkfs.ntfs* tool.

2) About if this case supports FUSE:

This current code of this case can't do a FUSE mount, due to if we want to mount
a fs through FUSE, we need to do more things, something likes:
  fd = open(/dev/fuse, ...)
  fsfd = fsopen("fuse", ...);
  ...
  fsconfig(fsfd, FSCONFIG_SET_FD, "fd", NULL, fd);
  ...
  (more)
  ...

It's not a simple mount as general localfs mount does. So I didn't do that.
If need, I'd like to write another case to cover that.

3) About the TST_FS_SKIP_FUSE flag:

If you want to skip ntfs and vfat test by set .dev_fs_flags = TST_FS_SKIP_FUSE
for this case. I think it doesn't work. The reason as I said above. Actually
if the current kernel support ntfs and vfat (build them), and we have mkfs.ntfs
and mkfs.vfat tools, then this case can test it.

But if we have the tools, but don't have the kernel support. The case will fail
as you hit.

Thanks,
Zorro


[1] https://patchwork.ozlabs.org/patch/1206389/#2333978

> > > is_mounted = 0. I wanted to fix them myself and merge, but didn't find a time.
> > > Sending v4 where you fix/implement suggestions generally helps speedup merging
> > > (as I already told you) :).
> 
> > I'll read your review points, and send a V4 tonight.
> Thanks a lot!
> 
> Kind regards,
> Petr
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

