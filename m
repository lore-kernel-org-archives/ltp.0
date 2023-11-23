Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DF9C5AD4C
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 09:43:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B73CD3CDF90
	for <ltp@archiver.kernel.org>; Thu, 23 Nov 2023 10:42:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85BC63CCD61
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 10:42:47 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6F6A814098BF
 for <ltp@lists.linux.it>; Thu, 23 Nov 2023 10:42:45 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id B155FB82A6C;
 Thu, 23 Nov 2023 09:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CA7C433C8;
 Thu, 23 Nov 2023 09:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700732563;
 bh=XWJmuCp9du/zghnFvUsp7fKkmUN2FPd9k58fxsSs6LI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S+e4ByITPLx8hURcrQGIKyFOFbP7LVTb//3FNj7W4fKdS+jbnFU+a2tjQoDGWB3/u
 wIxZ0ETvzdYyrp6J1YrqQKwVG96fkQTQjzJYWX0qTVRf8+g3WLWes/Mo9EsaYz+Mq5
 SjoH81Ebjro61XfUQQKldGvAzc4CJzoqQRQWiyBiDiqQiPNsP/Oouwb4w8IrOjCof8
 CC5waA51YGgmtUEoOLNF5buYbUpWfr6I5fCKZkiLs9u3p8+x1epNTrTRAQjgtywXRz
 GHwP5RUvYWP82nNPIesX5HHxJZmdT8/Te4sY5cDTWNaSXCLh5fUbaS6KaTTfDXF7LK
 wwDulxzPN37Bg==
Date: Thu, 23 Nov 2023 10:42:38 +0100
From: Christian Brauner <brauner@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20231123-okkupieren-vorurteil-3ae308cb8f73@brauner>
References: <20231122211318.31358-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231122211318.31358-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] diotest4: Skip test 3 and 14 for tmpfs
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
Cc: Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
 Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Nov 22, 2023 at 10:13:18PM +0100, Petr Vorel wrote:
> tmpfs in kernel v6.6 got support for O_DIRECT in e88e0d366f9c ("tmpfs:
> trivial support for direct IO"). There is no reason for tmpfs to reject
> direct IO of any size therefore follow the approach already used for
> Btrfs, NFS and FUSE: skipping test 3 (odd count of read and write)
> and 14 (read, write with non-aligned buffer).
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
