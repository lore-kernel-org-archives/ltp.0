From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Jul 2018 11:17:00 +0200
Subject: [LTP] [PATCH v2] Testing statx syscall
In-Reply-To: <1331af4eba3f2858595365072179e60d.squirrel@pike.zilogic.com>
References: <20180716134147.25232-1-tarun@zilogic.com>
 <20180718122252.GA7117@rei>
 <1331af4eba3f2858595365072179e60d.squirrel@pike.zilogic.com>
Message-ID: <20180719091700.GA1646@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for the review comments. We are working on resolving those issues.
> But, we have doubts regarding two comments.
> 
> Regarding block size, looking at the behaviour of statx, we observed that
> statx automatically upscales the size value to the nearest blocksize of
> that file system.
> 
> For instance,
> Case 1:
> size = 10 and stx_blocksize = 4096
> Blocks = 8
> 
> Case 2:
> size = 5012 and stx_blocksize = 4096
> Blocks = 16
> 
> blocks = ((5012 / 4096) + 1) * (4096 / 512)
>        = 16
> 
> So, that is why we are incrementing (SIZE/stx_blksize) by 1 an mutiplying
> it by (stx_blksize/512) to get number of blocks.

There are some assumptions that may not holt true here. The stx_blksize
is supposed to be optimal block size for I/O, it may match the blocksize
used by the filesystem but I doubt that it's guaranteed.

And while it's likely that the stx_blocksize would be divideable by 512
that one is not guaranteed either.

However even if we decide to use it the way you compute the number of
blocks based on size is unnecessarily complex, we just need to round the
size to be nearest multiple of stx_blocksize and then divide it with
512, that is easily done with:

(size + stx_blocksize - 1) / stx_blocksize * (stx_blocksize / 512);

> Also, since only ext4 supports these attribute flags for now, we have used
> that alone in our test case.

Okay then, if it's supported only by ext4 then we should go with that
for now, but we should make sure that mkfs.ext4 is present and that the
kernel supports ext4. We do have a functions for that in the C test
library.

> Also we have used script because we don't have any equivalent for tune2fs
> and e4crypt.

Looking closer, the tune2fs writes some bytes to the device, indeed that
is something we do not want to replicate in our tests. But we can call
the binary easily from the C test as well.

The e4crypt seems to be doing add_key() syscall with the pasphrase but
does some magic with sha512 and salt so it would be easier to run the
e4crypt tool as well.

BTW you can actually get a device formatted with ext4 in the C testcase
by setting only single flag in the test library and it will correctly
exit the test if ext4 is not supported...

-- 
Cyril Hrubis
chrubis@suse.cz
