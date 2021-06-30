From: Li Wang <liwang@redhat.com>
Date: Wed, 30 Jun 2021 16:08:35 +0800
Subject: [LTP] [RFC] Limit the tmpfs size on mounting
Message-ID: <CAEemH2da0dOeKpnZZ6+A696gFL+nDAiP7UL9tqm68JH8KO-Qkw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

LTP mount and make use of the whole tmpfs of the test system,
generally, it's fine. But if a test (e.g fallocate06) try to fill full in
the
filesystem, it takes too long to complete testing on a large memory
system.

I'm thinking whether we should limit the mount tmpfs size for the
LTP test, maybe only give 512MB?  but the tricky part for me is to
add options like "-o size=512M" to prepare_device(), or do some
additional work for tmpfs mounting.

and any else way can speed up is also welcome. I'd like to hear
more advice. Thanks!


   120 tst_test.c:1379: TINFO: Testing on tmpfs
   121 tst_test.c:889: TINFO: Skipping mkfs for TMPFS filesystem
   122 tst_test.c:1313: TINFO: Timeout per run is 0h 05m 00s
   123 fallocate06.c:126: TINFO: Copy-on-write is not supported
   124 fallocate06.c:177: TINFO: Case 1. Fill FS: no; Use copy on write: no
   125 fallocate06.c:166: TPASS: write() successful
   126 fallocate06.c:210: TPASS: Misaligned allocation works as expected
   127 fallocate06.c:166: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE |
FALLOC_FL_KEEP_SIZE) successful
   128 fallocate06.c:246: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE |
FALLOC_FL_KEEP_SIZE) cleared the correct file range
   129 fallocate06.c:177: TINFO: Case 2. Fill FS: yes; Use copy on write: no
   130 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
   131 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
   132 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
   133 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
   134 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
   135 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935
   136 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786
   137 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file7 size 76896492
   ...
  2382 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2252 size
57793556
  2383 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2253 size
44128200
  2384 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2254 size
31600129
  2385 tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2255 size 1865251
 <------- create too many files
  2386 tst_fill_fs.c:59: TINFO: write(): ENOSPC (28)
  2387 fallocate06.c:166: TPASS: write() successful
  2388 fallocate06.c:210: TPASS: Misaligned allocation works as expected
  2389 fallocate06.c:166: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE |
FALLOC_FL_KEEP_SIZE) successful
  2390 fallocate06.c:246: TPASS: fallocate(FALLOC_FL_PUNCH_HOLE |
FALLOC_FL_KEEP_SIZE) cleared the correct file range
  2391 Test timeouted, sending SIGKILL!    <------- looks like takes too
much time on purge dirs


# df -Th | grep tmpfs
Filesystem                             Type      Size  Used Avail Use%
Mounted on
devtmpfs                               devtmpfs  126G     0  126G   0% /dev
tmpfs                                  tmpfs     126G  4.0K  126G   1%
/dev/shm
tmpfs                                  tmpfs     126G   18M  126G   1% /run
tmpfs                                  tmpfs     126G     0  126G   0%
/sys/fs/cgroup
/dev/loop0                             tmpfs     126G   23G  104G  18%
/tmp/falywSTkc/mntpoint

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210630/4c277cb1/attachment.htm>
