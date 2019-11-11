From: Darrick J. Wong <darrick.wong@oracle.com>
Date: Sun, 10 Nov 2019 17:26:14 -0800
Subject: [LTP] LTP: diotest4.c:476: read to read-only space. returns 0:
 Success
In-Reply-To: <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com>
References: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
 <852514139.11036267.1573172443439.JavaMail.zimbra@redhat.com>
Message-ID: <20191111012614.GC6235@magnolia>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

[add the other iomap maintainer to cc]
[add the ext4 list to cc since they just added iomap directio support]
[add the ext4 maintainer for the same reason]

On Thu, Nov 07, 2019 at 07:20:43PM -0500, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
> > LTP test case dio04 test failed on 32bit kernel running linux next
> > 20191107 kernel.
> > Linux version 5.4.0-rc6-next-20191107.
> > 
> > diotest4    1  TPASS  :  Negative Offset
> > diotest4    2  TPASS  :  removed
> > diotest4    3  TPASS  :  Odd count of read and write
> > diotest4    4  TPASS  :  Read beyond the file size
> > diotest4    5  TPASS  :  Invalid file descriptor
> > diotest4    6  TPASS  :  Out of range file descriptor
> > diotest4    7  TPASS  :  Closed file descriptor
> > diotest4    8  TPASS  :  removed
> > diotest4    9  TCONF  :  diotest4.c:345: Direct I/O on /dev/null is
> > not supported
> > diotest4   10  TPASS  :  read, write to a mmaped file
> > diotest4   11  TPASS  :  read, write to an unmapped file
> > diotest4   12  TPASS  :  read from file not open for reading
> > diotest4   13  TPASS  :  write to file not open for writing
> > diotest4   14  TPASS  :  read, write with non-aligned buffer
> > diotest4   15  TFAIL  :  diotest4.c:476: read to read-only space.
> > returns 0: Success
> > diotest4   16  TFAIL  :  diotest4.c:180: read, write buffer in read-only
> > space
> > diotest4   17  TFAIL  :  diotest4.c:114: read allows  nonexistant
> > space. returns 0: Success
> > diotest4   18  TFAIL  :  diotest4.c:129: write allows  nonexistant
> > space.returns -1: Invalid argument
> > diotest4   19  TFAIL  :  diotest4.c:180: read, write in non-existant space
> > diotest4   20  TPASS  :  read, write for file with O_SYNC
> > diotest4    0  TINFO  :  2/15 test blocks failed
> 
> Smaller reproducer for 32-bit system and ext4 is:
>   openat(AT_FDCWD, "testdata-4.5918", O_RDWR|O_DIRECT) = 4
>   mmap2(NULL, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f7b000
>   read(4, 0xb7f7b000, 4096)              = 0 // expects -EFAULT
> 
> Problem appears to be conversion in ternary operator at
> iomap_dio_bio_actor() return. Test passes for me with
> following tweak:

I can't do a whole lot with a code snippet that lacks a proper SOB
header.

> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 2f88d64c2a4d..8615b1f78389 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -318,7 +318,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>                 if (pad)
>                         iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
>         }
> -       return copied ? copied : ret;
> +       return copied ? (loff_t) copied : ret;

I'm a little confused on this proposed fix -- why does casting size_t
(aka unsigned long) to loff_t (long long) on a 32-bit system change the
test outcome?  Does this same diotest4 failure happen with XFS?  I ask
because XFS has been using iomap for directio for ages.

AFAICT @copied is a simple byte counter, and the other variable @n that
gets added to @copied is also a simple byte counter -- nobody should
ever be trying to stuff a negative value in there?

(Or is this a bug with the ext4 code that calls iomap_dio_rw?)

--D

>  }
> 
>  static loff_t
> 
