Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BCFC282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 14:38:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F57C3CAB0D
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 15:38:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C1583CAB0D
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 15:37:43 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=lists.linux.it)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 59FC21000A46
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 15:37:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=krQ2w5oa/13hMp5s6oxgij/ARPZRgCl2Yz1Oc/B1BiM=; b=dihRr+6GFa0fYkK/zEqisXpphV
 w20Af9RuL7TboUER/FV/IdfJaZ8Uj32O0DPAyNTbB4t739KOQ/+19zOR8+4VGmdtcet6MD5QimEFd
 JSDK8NR44hOStMM/yG9EkSHFYcDnLx+9fIVLXRhDE6koD5km4iuWm+KfrO62Sl3Rh06exJHle/8UM
 jF+Y5e9bQsf5mhZRe7dBLfVzxvMWefg2wmljqR8u/SKW4zSqtMUOBFRdKbXVksD8rEl/K4e4Xppjg
 dPjgsG8Hk8CI6TLB08JsS/MuCq83CrPOlVTrubGWhRnJdVasRZrK/qu1jw3CYee+YesBmdCobz79K
 fPDqTaYw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tuY4Q-0000000FLpE-0DTl; Tue, 18 Mar 2025 14:37:30 +0000
Date: Tue, 18 Mar 2025 14:37:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>, Jan Kara <jack@suse.cz>
Message-ID: <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>,
 Christian Brauner <brauner@kernel.org>, lkp@intel.com,
 David Hildenbrand <david@redhat.com>, Alistair Popple <apopple@nvidia.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Oliver Sang <oliver.sang@intel.com>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 18, 2025 at 01:15:33AM -0700, Luis Chamberlain wrote:
> I also can't see how the patch ("("block/bdev: enable large folio
> support for large logical block sizes") would trigger this.

Easy enough to see by checking the backtrace.

> [  218.454517][   T51]  folio_mc_copy+0xca/0x1f0
> [  218.454532][   T51]  __migrate_folio+0x11a/0x2d0
> [  218.454541][   T51]  __buffer_migrate_folio+0x558/0x660

folio_mc_copy() calls cond_resched() for large folios only.
__buffer_migrate_folio() calls spin_lock(&mapping->i_private_lock)

so for folios without buffer heads attached, we never take the spinlock,
and for small folios we never call cond_resched().  It's only the
compaction path for large folios with buffer_heads attached that
calls cond_resched() while holding a spinlock.

Jan was the one who extended the spinlock to be held over the copy
in ebdf4de5642f so adding him for thoughts.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
