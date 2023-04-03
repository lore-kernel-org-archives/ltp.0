Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218EDC761A6
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 17:04:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9520A3CC87C
	for <ltp@archiver.kernel.org>; Mon,  3 Apr 2023 19:04:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 35F073CC81A
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 19:04:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6EE101A001B9
 for <ltp@lists.linux.it>; Mon,  3 Apr 2023 19:04:46 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 66D2161347;
 Mon,  3 Apr 2023 17:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D31C433EF;
 Mon,  3 Apr 2023 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680541483;
 bh=xZh0Eu5pO1R7ND0msox6nrDzIsZ7MWK/s65DTJY7KX8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GjPmPRyVVQ6PS6UU3Yq2h/jNTFKNV+iupuBCEb7toIGHkirJkfe6eVxxuO6CkXjia
 1EITsw7PlBc7ISGw9W4eApcqhAwDqzgwtlLMBBELA668WzT85WgrnkIBxtTJtNqOXi
 baWzd+8fmt8uQMa2lw6OwowtDouVX6QZOK1ppzH8gsYV7l48rC0O/3yHe7j9sSiWSv
 P0wtqYxUEpyQhfl9DZNhg57uBaNsQzIZ1HdFjATJ4IPnclSGb7zK/hYiT3C7Y1Ay6j
 PGfY8UTX3rSi3EmG8HS7bnYLqpilRymfBINTnTMYsD8GisRihKjfHEREITO9MD2RsG
 SKMAaC+tNNNJA==
Date: Mon, 3 Apr 2023 17:04:42 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZCsHKmFrUdBw3xEw@gmail.com>
References: <7f06d661-cb57-cb8b-481b-cafafa92009b@fujitsu.com>
 <1680518676-2863-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680518676-2863-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1680518676-2863-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on blockdev
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Apr 03, 2023 at 06:44:35PM +0800, Yang Xu wrote:
> +	TST_ASSERT_ULONG(sys_bdev_dma_path, buf.stx_dio_mem_align - 1);
> +	TST_ASSERT_ULONG(sys_bdev_lgs_path, buf.stx_dio_offset_align);

This test is tightly coupled to the kernel's current DIO restrictions on block
devices.  These changed in v6.0, and they are subject to further change in the
future.

I guess that is fine for now because STATX_DIOALIGN is only in v6.1 and later
anyway.  But, please leave a super clear comment that documents the assumptions
this test is making.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
