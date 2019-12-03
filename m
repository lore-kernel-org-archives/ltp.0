From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 3 Dec 2019 05:07:57 -0800
Subject: [LTP] [bug] userspace hitting sporadic SIGBUS on xfs (Power9,
 ppc64le), v4.19 and later
In-Reply-To: <1766807082.14812757.1575377439007.JavaMail.zimbra@redhat.com>
References: <cki.6C6A189643.3T2ZUWEMOI@redhat.com>
 <1738119916.14437244.1575151003345.JavaMail.zimbra@redhat.com>
 <8736e3ffen.fsf@mpe.ellerman.id.au>
 <1420623640.14527843.1575289859701.JavaMail.zimbra@redhat.com>
 <1766807082.14812757.1575377439007.JavaMail.zimbra@redhat.com>
Message-ID: <20191203130757.GA2267@infradead.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Dec 03, 2019 at 07:50:39AM -0500, Jan Stancek wrote:
> My theory is that there's a race in iomap. There appear to be
> interleaved calls to iomap_set_range_uptodate() for same page
> with varying offset and length. Each call sees bitmap as _not_
> entirely "uptodate" and hence doesn't call SetPageUptodate().
> Even though each bit in bitmap ends up uptodate by the time
> all calls finish.

Weird.  That should be prevented by the page lock that all callers
of iomap_set_range_uptodate.  But in case I miss something, does
the patch below trigger?  If not it is not jut a race, but might
be some weird ordering problem with the bitops, especially if it
only triggers on ppc, which is very weakly ordered.

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d33c7bc5ee92..25e942c71590 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -148,6 +148,8 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	unsigned int i;
 	bool uptodate = true;
 
+	WARN_ON_ONCE(!PageLocked(page));
+
 	if (iop) {
 		for (i = 0; i < PAGE_SIZE / i_blocksize(inode); i++) {
 			if (i >= first && i <= last)
