From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 29 Nov 2019 10:54:54 +0100
Subject: [LTP] [PATCH 1/1] Use real FS block size in fallocate05
In-Reply-To: <20191128174733.GA5202@dell5510>
References: <20191128093610.6903-1-mdoucha@suse.cz>
 <20191128093610.6903-2-mdoucha@suse.cz> <20191128174733.GA5202@dell5510>
Message-ID: <a0d815a5-ef91-d982-b660-623b0316c98a@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/28/19 6:47 PM, Petr Vorel wrote:
> Hi Martin,
> 
> Looks ok to me.
> 
> BTW there is change on results on some of my VM:
> 
> Old version:
> tst_test.c:1169: INFO: Testing on ext4
> tst_mkfs.c:89: INFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> mke2fs 1.43.8 (1-Jan-2018)
> tst_test.c:1106: INFO: Timeout per run is 0h 05m 00s
> tst_fill_fs.c:29: INFO: Creating file mntpoint/file0 size 21710183
> tst_fill_fs.c:29: INFO: Creating file mntpoint/file1 size 8070086
> tst_fill_fs.c:29: INFO: Creating file mntpoint/file2 size 3971177
> tst_fill_fs.c:29: INFO: Creating file mntpoint/file3 size 36915315
> tst_fill_fs.c:29: INFO: Creating file mntpoint/file4 size 70310993
> tst_fill_fs.c:29: INFO: Creating file mntpoint/file5 size 4807935
> tst_fill_fs.c:29: INFO: Creating file mntpoint/file6 size 90739786
> tst_fill_fs.c:29: INFO: Creating file mntpoint/file7 size 76896492
> tst_fill_fs.c:49: INFO: write(): ENOSPC
> fallocate05.c:50: PASS: write() wrote 8192 bytes
> fallocate05.c:59: PASS: fallocate() on full FS: ENOSPC
> fallocate05.c:68: PASS: fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)
> fallocate05.c:74: PASS: write()
> 
> With your patch:
> ...
> tst_fill_fs.c:49: INFO: write(): ENOSPC (28)
> fallocate05.c:67: PASS: write() wrote 16384 bytes
> fallocate05.c:73: FAIL: fallocate() succeeded unexpectedly
> 
> Maybe it's correct (previous version didn't catch a problem),
> not really sure.

Your VM seems to use 1KB blocks in the ext4 test partition. It's
probably the same quirk as I've documented for XFS in the patch. I'd
like some more opinions on how to deal with it:
- improve tst_fill_fs() and make sure that fallocate(1 block) always
fails after it?
- set some reasonable minimum size where fallocate() must fail on full
FS but allow fallocate() to pass with smaller allocation requests?
- drop that one fallocate() fail check entirely because it's too unreliable?

> + there are few simple warnings:

I'll resubmit after we agree on a solution to the above problem.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
