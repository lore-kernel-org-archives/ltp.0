From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 29 Nov 2019 11:17:28 -0500 (EST)
Subject: [LTP] [PATCH 1/1] Use real FS block size in fallocate05
In-Reply-To: <0e1a3d0e-a154-8469-6e04-a954740a4a61@suse.cz>
References: <20191128093610.6903-1-mdoucha@suse.cz>
 <20191128093610.6903-2-mdoucha@suse.cz>
 <26933665.14359191.1575028896043.JavaMail.zimbra@redhat.com>
 <0e1a3d0e-a154-8469-6e04-a954740a4a61@suse.cz>
Message-ID: <1057914729.14405454.1575044248773.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On 11/29/19 1:01 PM, Jan Stancek wrote:
> >> +			tst_res(TCONF | TTERRNO, "fallocate() not supported");
> > 
> > tst_brk would make more sense here. If we fail here we can end the test.
> 
> No. tst_brk() will terminate the whole test on the first usual test case
> (Ext2) and skip all the other file systems that do support fallocate().

It shouldn't. tst_brk() does call exit() for test process, but
.all_filesystems spawns new process for each fs.

If I add:
   tst_brk(TCONF, "STOP");
to run(), I get STOP for each fs:
  $ sudo ./fallocate05 2>&1 | grep STOP
  fallocate05.c:30: CONF: STOP
  fallocate05.c:30: CONF: STOP
  fallocate05.c:30: CONF: STOP
  fallocate05.c:30: CONF: STOP
  fallocate05.c:30: CONF: STOP
  fallocate05.c:30: CONF: STOP

> 
> > I don't understand why there is need to find minimum value that can
> > satisfy this check. It looks like we are testing tst_fill_fs() more
> > than fallocate().
> > 
> > In other words, what is wrong with current test? Is the problem that
> > FALLOCATE_SIZE (1M) is not aligned on all platforms? Or is the test
> > invalid with FALLOCATE_SIZE that big? Or both?
> 
> I don't like to blindly rely on the assumption that block size is always
> a power of 2 and smaller than some magic number. Getting the real block
> size is trivial. The only real question is how many free blocks do we
> allow on a "full" file system in our tests. 1MB is just 16 blocks on
> PPC64 so the magic number isn't particularly big anyway.

OK, let's assume 16 is enough. Can we use that value also for ENOSPC check?
  TEST(fallocate(fd, 0, bufsize, 2 * statbuf.st_blksize));


