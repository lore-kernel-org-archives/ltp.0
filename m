From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 29 Aug 2016 11:44:36 +0200
Subject: [LTP] [PATCH] syscalls/fallocate04: Fix on Btrfs
In-Reply-To: <57C03126.1020609@oracle.com>
References: <20160825165354.GA13281@rei> <57C02561.8000608@oracle.com>
 <57C03126.1020609@oracle.com>
Message-ID: <20160829094436.GA30021@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> The size of a file can double on Btrfs temporarily even when we write
> >> into a preallocated space because of internal Btrfs caches, at least
> >> that is what I've been told by Btrfs devs. The internal caches are then
> >> freed after some time, or can be force freed by syncing the file, which
> >> is what this patch does.
> 
> So if we have available free space x Mb,  we can't allocate more than x 
> / 2 Mb and it's not a bug?

It's the other way around. We preallocate x Mb for the file, then write
into the preallocated space. The file size, as reported by stat(), may
end up > x MB after the write temporarily on Btrfs because of caching.
And this is not a bug since the only guarantee we have is that we don't
get ENOSPC when writing into preallocated file region. There is nothing
that forbids allocating more space temporarily if there is plenty of it.

Another interesting testcase would be doing the same on the LTP loopback
device that would be filled up after the file has been preallocated.
That would likely force different codepath in the FS since there would
be no avaialable free space left...

-- 
Cyril Hrubis
chrubis@suse.cz
