From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Feb 2019 16:33:08 +0100
Subject: [LTP] [PATCH v2 2/2] aio_tio: determine alignment based on
 target filesystem
In-Reply-To: <20190111085326.171826-2-maennich@google.com>
References: <20190111085326.171826-1-maennich@google.com>
 <20190111085326.171826-2-maennich@google.com>
Message-ID: <20190222153308.GC23713@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The alignment for O_DIRECT operations has to match the blocksize of the
> underlying filesystem. Determine the alignment from the target file's
> file system.
> 
> aio_tio test cases 1 and 2 failed (nondeterministic) on aarch64 when run
> on a 4096 byte blocksize filesystem and with an alignment of 512 bytes.

Is this really about the filesystem? Citing man open:

       Under Linux 2.4, transfer sizes, and the alignment of the  user  buffer
       and  the file offset must all be multiples of the logical block size of
       the filesystem.  Since Linux 2.6.0, alignment to the logical block size
       of  the underlying storage (typically 512 bytes) suffices.  The logical
       block size can be determined using the ioctl(2) BLKSSZGET operation  or
       from the shell using the command:

       blockdev --getss

So unless you are running ancient 2.4 kernel the aligment restrictions should
be result of the blocksize of the device rather than of the filesystem.

What does the blockdev command return on the particular system?

-- 
Cyril Hrubis
chrubis@suse.cz
