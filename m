Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4FAC83F17
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 11:00:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 639F03CAECA
	for <ltp@archiver.kernel.org>; Thu, 10 Jul 2025 13:00:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BCC23CA855
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 12:59:53 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9F12B6EEEAB
 for <ltp@lists.linux.it>; Thu, 10 Jul 2025 12:59:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=WvqIPEfWD9uD4rQga0dMwrnfQPe1vBwSUrMxLgce8Pk=; b=F31DW1Wa5Nx5SLpLnoAlmgXvTt
 wF+bfPNY37kl4oiz+KPTroEs3Fzg0GaJYS1pxWOkc4wQ7D0DDxiDm6vKrh7M+nSlrbof4Vcp/azDN
 bIkeFcgl3G7/C+LN9W2mzy6vupqXsn2VnU37yqV+JaqTbRwAfZBZVJdevQI/KBx2G4PI4pL8ONeOw
 VgPcDKTEQo3zVNTRihed1GniZOlEh7K+2UlD9y4SgIIsFGgW/UwYu7GQiXaEnHYiGLimKRcs1P9Wi
 cwsNw+G46LRmrdpXjSLtjP7jHXd1cma1CDTFyJCDiGL+xw/RlMwFCbxekawE6JdHt7P2BhClCn34B
 boPWe5aw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1uZp0F-0000000BYbt-1Zv1;
 Thu, 10 Jul 2025 10:59:47 +0000
Date: Thu, 10 Jul 2025 03:59:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <aG-dI2wJDl-HfzFG@infradead.org>
References: <20250709181030.236190-1-arnd@kernel.org>
 <20250710-passen-petersilie-32f6f1e9a1fc@brauner>
 <aG92abpCeyML01E1@infradead.org>
 <14865b4a-dfad-4336-9113-b70d65c9ad52@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <14865b4a-dfad-4336-9113-b70d65c9ad52@app.fastmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Arnd Bergmann <arnd@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Eric Biggers <ebiggers@google.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Anuj Gupta <anuj20.g@samsung.com>, linux-kernel@vger.kernel.org,
 Pavel Begunkov <asml.silence@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 linux-block@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 rbm@suse.com, linux-fsdevel@vger.kernel.org,
 Benjamin Copeland <benjamin.copeland@linaro.org>,
 LTP List <ltp@lists.linux.it>, Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jul 10, 2025 at 12:50:44PM +0200, Arnd Bergmann wrote:
> There are multiple methods we've used to do this in the past,
> but I don't think any of them are great, including the version
> that Christian is trying to push now:
> 
> The most common variant is to leave extra room at the end of
> a structure and use that as in your 1fd8159e7ca4 ("xfs: export zoned
> geometry via XFS_FSOP_GEOM") and many other examples.

That's using the space.  I had that discussion before in context of
this API, and I still think that reserving a small amount of space
that can be used for extensions is usually good practice.  Often
we get some of that for free by 64-bit aligning anyway, and adding
a bit more tends to also be useful.

> This is probably the easiest and it only fails once you run out of
> spare room and have to pick a new command number. A common mistake
> here is to forget checking the padding in the input data against
> zero, so old kernels just ignore whatever new userspace tried
> to pass.
> 
> I think the variant from commit 1b6d968de22b ("xfs: bump
> XFS_IOC_FSGEOMETRY to v5 structures") where the old structure
> gets renamed and the existing macro refers to a different
> command code is more problematic. We used to always require
> userspace to be built against the oldest kernel headers it could run
> on. This worked fine in the past but it appears that userspace
> (in particular glibc) has increasingly expected to also work
> on older kernels when building against new headers.

This is what I meant.  Note that the userspace in this case also keeps a
case trying the old structure, but that does indeed require keeping the
userspace somewhat in lockstep if you do the renaming as in this example.
The better example would be one using a new new for the extended
structure, or requiring a feature macro to get the larger structure.

> Christian's version using the copy_struct_{from,to}_user()
> aims to avoid most of the problems. The main downside I see
> here is the extra complexity in the kernel. As far as I can
> tell, this has mainly led to extra kernel bugs but has not
> actually resulted in any structure getting seamlessly
> extended.

That is my (non-scientific) impression as well.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
