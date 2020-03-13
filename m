From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 13 Mar 2020 12:31:37 +0800
Subject: [LTP] [PATCH v5] Add test for misaligned fallocate()
In-Reply-To: <20200227141356.GA29089@rei>
References: <20200224100932.10349-1-mdoucha@suse.cz>
 <20200226135748.GD24080@rei> <0d875613-07a4-b9fe-9c83-76c2e403d6dc@suse.cz>
 <20200227141356.GA29089@rei>
Message-ID: <f3cbdd28-e89c-02e1-7f4b-0b62278b6edb@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Martin

When I test this case by using btrfs, this case failed as below:

fallocate06.c:174: CONF: File system does not support copy-on-write
tst_test.c:1290: INFO: Testing on btrfs
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
tst_test.c:1229: INFO: Timeout per run is 0h 05m 00s
fallocate06.c:117: INFO: Copy-on-write is supported
fallocate06.c:168: INFO: Case 1. Fill FS: no; Use copy on write: no
fallocate06.c:157: PASS: write() successful
fallocate06.c:201: PASS: Misaligned allocation works as expected
fallocate06.c:157: PASS: fallocate(FALLOC_FL_PUNCH_HOLE | 
FALLOC_FL_KEEP_SIZE) successful
fallocate06.c:237: PASS: fallocate(FALLOC_FL_PUNCH_HOLE | 
FALLOC_FL_KEEP_SIZE) cleared the correct file range
fallocate06.c:168: INFO: Case 2. Fill FS: yes; Use copy on write: no
tst_fill_fs.c:32: INFO: Creating file mntpoint/file0 size 21710183
tst_fill_fs.c:32: INFO: Creating file mntpoint/file1 size 8070086
tst_fill_fs.c:32: INFO: Creating file mntpoint/file2 size 3971177
tst_fill_fs.c:32: INFO: Creating file mntpoint/file3 size 36915315
tst_fill_fs.c:32: INFO: Creating file mntpoint/file4 size 70310993
tst_fill_fs.c:32: INFO: Creating file mntpoint/file5 size 4807935
tst_fill_fs.c:32: INFO: Creating file mntpoint/file6 size 90739786
tst_fill_fs.c:32: INFO: Creating file mntpoint/file7 size 76896492
tst_fill_fs.c:32: INFO: Creating file mntpoint/file8 size 72228649
tst_fill_fs.c:32: INFO: Creating file mntpoint/file9 size 36207821
tst_fill_fs.c:32: INFO: Creating file mntpoint/file10 size 81483962
tst_fill_fs.c:59: INFO: write(): ENOSPC (28)
fallocate06.c:157: PASS: write() successful
fallocate06.c:201: PASS: Misaligned allocation works as expected
fallocate06.c:146: FAIL: fallocate(FALLOC_FL_PUNCH_HOLE | 
FALLOC_FL_KEEP_SIZE) failed unexpectedly: ENOSPC (28)

It failed when we fill fs and not using cow. Is it a known issue(I see 
the previous eamils, but found nothing)?
I also used 5.6-rc3 kernel to test, it still failed.

Best Regards
Yang Xu

> Hi!
>>> Are the failures on xfs fixed by now?
>>>
>>> Do we have a upstrem kernel commit we can add to the test as a tag?
>>>
>>
>> Anthony Iliopoulos says in the BSC that the upstream fix is
>> commit e093c4be760e ("xfs: Fix tail rounding in xfs_alloc_file_space()")
> 
> I've added this as a tag and commend and also added a .gitignore entry
> and pushed. Thanks.
> 


