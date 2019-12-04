From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 4 Dec 2019 11:38:18 +0100
Subject: [LTP] [PATCH 1/1] Use real FS block size in fallocate05
In-Reply-To: <1057914729.14405454.1575044248773.JavaMail.zimbra@redhat.com>
References: <20191128093610.6903-1-mdoucha@suse.cz>
 <20191128093610.6903-2-mdoucha@suse.cz>
 <26933665.14359191.1575028896043.JavaMail.zimbra@redhat.com>
 <0e1a3d0e-a154-8469-6e04-a954740a4a61@suse.cz>
 <1057914729.14405454.1575044248773.JavaMail.zimbra@redhat.com>
Message-ID: <0c8a52b4-0c71-4efa-f58a-66524055e32a@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/29/19 5:17 PM, Jan Stancek wrote:
>> No. tst_brk() will terminate the whole test on the first usual test case
>> (Ext2) and skip all the other file systems that do support fallocate().
> 
> It shouldn't. tst_brk() does call exit() for test process, but
> .all_filesystems spawns new process for each fs.

You're right, I'll use tst_brk(TCONF, ...) then.

>> I don't like to blindly rely on the assumption that block size is always
>> a power of 2 and smaller than some magic number. Getting the real block
>> size is trivial. The only real question is how many free blocks do we
>> allow on a "full" file system in our tests. 1MB is just 16 blocks on
>> PPC64 so the magic number isn't particularly big anyway.
> 
> OK, let's assume 16 is enough. Can we use that value also for ENOSPC check?
>   TEST(fallocate(fd, 0, bufsize, 2 * statbuf.st_blksize));

I think it might be better to change the test scenario a bit:
1. fallocate(FALLOCATE_BLOCKS * blocksize)
2. tst_fill_fs()
3. write(FALLOCATE_BLOCKS * blocksize)
4. repeat fallocate(blocksize) until we get ENOSPC
5. write() into all blocks allocated in step 4
6. check that another write() will get ENOSPC
7. test fallocate(PUNCH_HOLE | KEEP_SIZE)

This should get us around the issue with tst_fill_fs() and still
properly validate that fallocate() handles full FS gracefully.

The only remaining issue is whether it's correct for Btrfs to only
release blocks when you deallocate the whole file. I still haven't heard
back from our Btrfs dev.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
