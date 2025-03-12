Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40855C28B2E
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 05:41:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 706CB3CA3F4
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 06:41:15 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 975463C1B7F
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 06:40:58 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=lists.linux.it)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DA77C60063D
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 06:40:57 +0100 (CET)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 11CD668C7B; Wed, 12 Mar 2025 06:40:54 +0100 (CET)
Date: Wed, 12 Mar 2025 06:40:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20250312054053.GA12234@lst.de>
References: <20250312050028.1784117-1-mcgrof@kernel.org>
 <20250312052155.GA11864@lst.de> <Z9Edl05uSrNfgasu@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9Edl05uSrNfgasu@bombadil.infradead.org>
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
 kbusch@kernel.org, oliver.sang@intel.com, Christoph Hellwig <hch@lst.de>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 11, 2025 at 10:37:27PM -0700, Luis Chamberlain wrote:
> > If you need extra per-driver validatation, do it in the driver.
> 
> Are you suggesting we just move back the PAGE_SIZE check,

PAGE_SIZE now is a consumer (i.e. file system) limitation.  Having
a flag in the provider (driver) does not make sense.

> or to keep
> the checks for the block driver limits into each driver?

Most drivers probably don't have a limit other than than that implicit
by the field width used for reporting.  So in general the driver should
not need any checks.  The only exceptions might be for virtual drivers
where the value comes from userspace, but even then it is a bit doubtful.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
