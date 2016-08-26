From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 26 Aug 2016 14:17:53 +0300
Subject: [LTP] [PATCH] syscalls/fallocate04: Fix on Btrfs
In-Reply-To: <20160825165354.GA13281@rei>
References: <20160825165354.GA13281@rei>
Message-ID: <57C02561.8000608@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 08/25/2016 07:53 PM, Cyril Hrubis wrote:
> The size of a file can double on Btrfs temporarily even when we write
> into a preallocated space because of internal Btrfs caches, at least
> that is what I've been told by Btrfs devs. The internal caches are then
> freed after some time, or can be force freed by syncing the file, which
> is what this patch does.
> 
> Technically we are not guaranteed that the file size will not change after
> writing to preallocated space. We are only guaranteed that subsequent writes to
> the region will not fail with ENOSPC. So this behavior, while uncommon, is not
> really a bug.
> 
> Before the patch the test fails with:
> 
> fallocate04    0  TINFO  :  allocate '12288' bytes
> fallocate04    1  TPASS  :  test-case succeeded
> fallocate04    0  TINFO  :  read allocated file size '24576'
> fallocate04    0  TINFO  :  make a hole with FALLOC_FL_PUNCH_HOLE
> fallocate04    0  TINFO  :  check that file has a hole with lseek(,,SEEK_HOLE)
> fallocate04    0  TINFO  :  found a hole at '4096' offset
> fallocate04    0  TINFO  :  allocated file size before '24576' and after '12288'
> fallocate04    2  TFAIL  :  fallocate04.c:184: not expected allocated size
> 

Tested this on SPARC:

* without the patch

a 2.6.39-based kernel:

[root@skholman-m7 fallocate]# TMPDIR=/mnt ./fallocate04
fallocate04 0 TINFO : allocate '24576' bytes
fallocate04 1 TPASS : test-case succeeded
fallocate04 0 TINFO : read allocated file size '49152'
fallocate04 0 TINFO : make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04 0 TINFO : check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04 0 TINFO : lseek() doesn't support SEEK_HOLE, this is
expected for < 3.1 kernels
fallocate04 0 TINFO : allocated file size before '49152' and after '24576'
fallocate04 2 TFAIL : fallocate04.c:184: not expected allocated size
[root@skholman-m7 fallocate]#

a 4.1-based kernel:

[root@skholman-m7 fallocate]# TMPDIR=/mnt ./fallocate04
fallocate04 0 TINFO : allocate '24576' bytes
fallocate04 1 TPASS : test-case succeeded
fallocate04 0 TINFO : read allocated file size '49152'
fallocate04 0 TINFO : make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04 0 TINFO : check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04 0 TINFO : found a hole at '8192' offset
fallocate04 0 TINFO : allocated file size before '49152' and after '24576'
fallocate04 2 TFAIL : fallocate04.c:184: not expected allocated size
[root@skholman-m7 fallocate]#

* with your patch

a 2.6.39-based kernel:

[root@skholman-m7 fallocate]# TMPDIR=/mnt ./fallocate04
fallocate04 0 TINFO : allocate '24576' bytes
fallocate04 1 TPASS : test-case succeeded
fallocate04 0 TINFO : read allocated file size '24576'
fallocate04 0 TINFO : make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04 0 TINFO : check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04 0 TINFO : lseek() doesn't support SEEK_HOLE, this is
expected for < 3.1 kernels
fallocate04 0 TINFO : allocated file size before '24576' and after '16384'
fallocate04 0 TINFO : reading the file, compare with expected buffer
fallocate04 2 TPASS : test-case succeeded
fallocate04 0 TINFO : zeroing file space with FALLOC_FL_ZERO_RANGE
fallocate04 3 TCONF : fallocate04.c:204: FALLOC_FL_ZERO_RANGE needs
Linux 3.15 or newer
fallocate04 4 TCONF : fallocate04.c:204: Remaining cases not appropriate
for configuration
[root@skholman-m7 fallocate]#

a 4.1-based kernel:

[root@skholman-m7 fallocate]# TMPDIR=/mnt ./fallocate04
fallocate04 0 TINFO : allocate '24576' bytes
fallocate04 1 TPASS : test-case succeeded
fallocate04 0 TINFO : read allocated file size '24576'
fallocate04 0 TINFO : make a hole with FALLOC_FL_PUNCH_HOLE
fallocate04 0 TINFO : check that file has a hole with lseek(,,SEEK_HOLE)
fallocate04 0 TINFO : found a hole@'8192' offset
fallocate04 0 TINFO : allocated file size before '24576' and after '16384'
fallocate04 0 TINFO : reading the file, compare with expected buffer
fallocate04 2 TPASS : test-case succeeded
fallocate04 0 TINFO : zeroing file space with FALLOC_FL_ZERO_RANGE
fallocate04 0 TINFO : read current allocated file size '16384'
fallocate04 3 TCONF : fallocate04.c:215: FALLOC_FL_ZERO_RANGE not supported
fallocate04 4 TCONF : fallocate04.c:215: Remaining cases not appropriate
for configuration
[root@skholman-m7 fallocate]#

Thanks for solving this problem.


> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/fallocate/fallocate04.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate04.c b/testcases/kernel/syscalls/fallocate/fallocate04.c
> index 2b904e4..f204188 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate04.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate04.c
> @@ -75,6 +75,8 @@ static size_t get_allocsize(void)
>  {
>  	struct stat file_stat;
>  
> +	fsync(fd);
> +
>  	SAFE_FSTAT(cleanup, fd, &file_stat);
>  
>  	return file_stat.st_blocks * 512;
> 
