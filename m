From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Jul 2019 13:57:35 +0200
Subject: [LTP] [PATCH] syscalls/statx01: loosen the stx_blocks check
In-Reply-To: <1be1f0b8-170a-ac92-b86f-924e2d7f2295@google.com>
References: <20190722194439.161904-1-smuckle@google.com>
 <20190723110306.GB22630@rei.lan>
 <1be1f0b8-170a-ac92-b86f-924e2d7f2295@google.com>
Message-ID: <20190724115735.GC17426@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Why 128?
> 
> Was just restoring it to what it was previously.
> 
> > Can't we rather multiply the buff.stx_blksize/512 by 16?
> 
> That would work for ext4, but should this be loosened further to give 
> some headroom in case some FS preallocates more? Or is it preferable to 
> keep the test as strict as possible and loosen it when/if failures happen?

That is hard to decide. I would go for the lowest limit that works for
everybody.

Also for me ext4 allocates only one block for the file no matter what I
do, something has to be tuned differently in your setup.

Isn't it just a difference in the block size and inode size?

-- 
Cyril Hrubis
chrubis@suse.cz
