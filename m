From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Nov 2019 18:47:33 +0100
Subject: [LTP] [PATCH 1/1] Use real FS block size in fallocate05
In-Reply-To: <20191128093610.6903-2-mdoucha@suse.cz>
References: <20191128093610.6903-1-mdoucha@suse.cz>
 <20191128093610.6903-2-mdoucha@suse.cz>
Message-ID: <20191128174733.GA5202@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

Looks ok to me.

BTW there is change on results on some of my VM:

Old version:
tst_test.c:1169: INFO: Testing on ext4
tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.43.8 (1-Jan-2018)
tst_test.c:1106: INFO: Timeout per run is 0h 05m 00s
tst_fill_fs.c:29: INFO: Creating file mntpoint/file0 size 21710183
tst_fill_fs.c:29: INFO: Creating file mntpoint/file1 size 8070086
tst_fill_fs.c:29: INFO: Creating file mntpoint/file2 size 3971177
tst_fill_fs.c:29: INFO: Creating file mntpoint/file3 size 36915315
tst_fill_fs.c:29: INFO: Creating file mntpoint/file4 size 70310993
tst_fill_fs.c:29: INFO: Creating file mntpoint/file5 size 4807935
tst_fill_fs.c:29: INFO: Creating file mntpoint/file6 size 90739786
tst_fill_fs.c:29: INFO: Creating file mntpoint/file7 size 76896492
tst_fill_fs.c:49: INFO: write(): ENOSPC
fallocate05.c:50: PASS: write() wrote 8192 bytes
fallocate05.c:59: PASS: fallocate() on full FS: ENOSPC
fallocate05.c:68: PASS: fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
fallocate05.c:74: PASS: write()

With your patch:
...
tst_fill_fs.c:49: INFO: write(): ENOSPC (28)
fallocate05.c:67: PASS: write() wrote 16384 bytes
fallocate05.c:73: FAIL: fallocate() succeeded unexpectedly

Maybe it's correct (previous version didn't catch a problem),
not really sure.

+ there are few simple warnings:
../../../../include/tst_test.h:70:41: warning: format ?%i? expects argument of type ?int?, but argument 5 has type ?size_t? {aka ?long unsigned int?} [-Wformat=]
   70 |   tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
      |                                         ^~~~~~~~~
fallocate05.c:53:3: note: in expansion of macro ?tst_brk?
   53 |   tst_brk(TBROK | TTERRNO, "fallocate(fd, 0, 0, %i)", bufsize);
      |   ^~~~~~~
fallocate05.c:62:19: warning: comparison of integer expressions of different signedness: ?long int? and ?size_t? {aka ?long unsigned int?} [-Wsign-compare]
   62 |  else if (TST_RET != bufsize)
      |                   ^~
fallocate05.c:27:18: warning: unused variable ?i? [-Wunused-variable]
   27 |  size_t bufsize, i;
      |                  ^

Kind regards,
Petr
