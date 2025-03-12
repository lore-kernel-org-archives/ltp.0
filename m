Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89467C28B2F
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 13:59:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B3A33CA46E
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 14:59:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 464483CA2DB
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 14:59:18 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=lists.linux.it)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 345DE1A004A4
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 14:59:16 +0100 (CET)
Received: by verein.lst.de (Postfix, from userid 2407)
 id EF23C68BFE; Wed, 12 Mar 2025 14:59:12 +0100 (CET)
Date: Wed, 12 Mar 2025 14:59:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250312135912.GB12488@lst.de>
References: <20250312050028.1784117-1-mcgrof@kernel.org>
 <20250312052155.GA11864@lst.de> <Z9Edl05uSrNfgasu@bombadil.infradead.org>
 <20250312054053.GA12234@lst.de> <Z9EfKXH6w8C0arzb@bombadil.infradead.org>
 <CAEemH2du_ULgnX19YnCiAJnCNzAURW0R17Tgxpdy9tg-XzisHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2du_ULgnX19YnCiAJnCNzAURW0R17Tgxpdy9tg-XzisHQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
 lkp@intel.com, john.g.garry@oracle.com, da.gomez@samsung.com,
 djwong@kernel.org, david@fromorbit.com, oe-lkp@lists.linux.dev,
 willy@infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
 oliver.sang@intel.com, hare@suse.de, gost.dev@samsung.com, kbusch@kernel.org,
 kernel@pankajraghav.com, Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 12, 2025 at 05:19:36PM +0800, Li Wang wrote:
> Well, does that patch for ioctl_loop06 still make sense?
> Or any other workaround?
> https://lists.linux.it/pipermail/ltp/2025-March/042599.html

The real question is what block sizes we want to support for the
loop driver.  Because if it is larger than the physical block size
it can lead to torn writes.  But I guess no one cared about those
on loop so far, so why care about this now..

But if we don't want any limit on the block size that patch looks
right.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
