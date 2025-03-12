Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CAAC28B28
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 05:22:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FE4D3C9365
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 06:22:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33A433C075B
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 06:22:00 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=lists.linux.it)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F117D600624
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 06:21:59 +0100 (CET)
Received: by verein.lst.de (Postfix, from userid 2407)
 id BFAD568AA6; Wed, 12 Mar 2025 06:21:55 +0100 (CET)
Date: Wed, 12 Mar 2025 06:21:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20250312052155.GA11864@lst.de>
References: <20250312050028.1784117-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250312050028.1784117-1-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE
 limit
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
Cc: p.raghav@samsung.com, ritesh.list@gmail.com, brauner@kernel.org,
 lkp@intel.com, kernel@pankajraghav.com, john.g.garry@oracle.com,
 da.gomez@samsung.com, djwong@kernel.org, david@fromorbit.com,
 oe-lkp@lists.linux.dev, willy@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, hare@suse.de, gost.dev@samsung.com,
 kbusch@kernel.org, oliver.sang@intel.com, hch@lst.de, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 11, 2025 at 10:00:28PM -0700, Luis Chamberlain wrote:
> We should take time to validate each block driver before enabling
> support for larger logical block sizes, so that those that didn't
> have support stay that way and don't need modifications.
> 
> Li Wang reported this as a regression on LTP via:
> 
> testcases/kernel/syscalls/ioctl/ioctl_loop06
> 
> Which uses the loopback driver to enable larger logical block sizes
> first with LOOP_CONFIGURE and then LOOP_SET_BLOCK_SIZE. While
> I see no reason why the loopback block driver can't support
> larger logical block sizes than PAGE_SIZE, leave this validation
> step as a secondary effort for each block driver.

This doesn't really make sense.  We don't want a flag that caps driver
controlled values at a arbitrary value (and then not used it at all in
the patch).

If you need extra per-driver validatation, do it in the driver.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
