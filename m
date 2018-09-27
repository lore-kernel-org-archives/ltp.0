From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Sep 2018 14:24:32 +0200
Subject: [LTP] [PATCH] aiodio: Remove dirty freeblocks
In-Reply-To: <20180910093621.21622-1-rpalethorpe@suse.com>
References: <20180910093621.21622-1-rpalethorpe@suse.com>
Message-ID: <20180927122432.GA11658@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> At the beginning of the test it attempts to write some junk data to disk in
> order to increase the chance that the blocks allocated are not filled with
> zeroes.
> 
> It does this by memory mapping a new file and writing 0xaa to the mapped
> memory, then syncs and unlinks the file. This uses buffered I/O which should
> not be mixed with direct I/O.

I do not follow here. Direct and buffered I/O should not be mixed for a
given file, that can lead to strange artifacts. But in this case we do
open a file, fill it with data, sync it, and then close it and we do
that before the test even starts. No direct and buffered I/O is being
mixed here or do I miss something?

> Possibly we could use direct I/O to create the dirty blocks or ensure the
> buffers have been completely flushed and any writes finalised before
> continuing. However it seems unlikely that this is either effective or
> necessary. It seems much simpler and thorough to run the test many times,
> which we do.

I do agree that the value of such function is indeed questionable but I
fail to see where is this actually hurting anything.

-- 
Cyril Hrubis
chrubis@suse.cz
