Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838EBC48BEB
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 03:56:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E39BC3D11B2
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 04:56:14 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E50223D018A
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 04:56:00 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=lists.linux.it)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0A99514002C8
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 04:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YjmVoGrH3NTj6e8OOlyRDduZNWEtTAuI/cfYREosE2I=; b=FUkXK6xenP/WwXGTFSY8g8oMOM
 kwt6CKjSWezMIKkj1AuIg/S4MApsDp3bLm/dah+8hAJRij+n677qBlbN8jxzHsNlx4Ae9uga7uqrp
 gZZ9AYaTTEzuLpIOpSIb8JPDbJip18pc0Pg6TZAfQXXDROk68N75nhEt+ifxVSF1ILQKJryXzWZzn
 RZ40oYCdzfU3BK5hJt9o3ALqnxVuYf/ZGbpduC5daG/DprpS2MqDSbP6XOTp5UAGVOtF4DWEiCCgM
 nsqKJmMdIWHY0GgxaB7uJ5E3lS0ivim4ai7Mj0MqqOWxzEhIfCaJZmQSmDrXaLV2qPkFiXRCUmpL/
 cgVt4H6A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rd0Bc-00000002Vak-2wMk;
 Thu, 22 Feb 2024 03:55:52 +0000
Date: Thu, 22 Feb 2024 03:55:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Message-ID: <ZdbFyC6HPr6oKrM-@casper.infradead.org>
References: <20240221234732.187629-1-vishal.moola@gmail.com>
 <20240221234732.187629-6-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240221234732.187629-6-vishal.moola@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] hugetlb: Allow faults to be handled under
 the VMA lock
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
Cc: muchun.song@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Feb 21, 2024 at 03:47:32PM -0800, Vishal Moola (Oracle) wrote:
> Hugetlb can now safely handle faults under the VMA lock, so allow it to
> do so.
> 
> This patch may cause ltp hugemmap10 to "fail". Hugemmap10 tests hugetlb
> counters, and expects the counters to remain unchanged on failure to
> handle a fault.
> 
> In hugetlb_no_page(), vmf_anon_prepare() may bailout with no anon_vma
> under the VMA lock after allocating a folio for the hugepage. In
> free_huge_folio(), this folio is completely freed on bailout iff there
> is a surplus of hugetlb pages. This will remove a folio off the freelist
> and decrement the number of hugepages while ltp expects these counters
> to remain unchanged on failure.
> 
> Originally this could only happen due to OOM failures, but now it may
> also occur after we allocate a hugetlb folio without a suitable anon_vma
> under the VMA lock. This should only happen for the first freshly
> allocated hugepage in this vma.

Hmm, so it's a bug in LTP.  Have you talked to the LTP people about it
(cc's added)?

Also, did you try moving the anon_vma check befor the folio allocation
so that you can bail out without disturbing the counters?

> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
