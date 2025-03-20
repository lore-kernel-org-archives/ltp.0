Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9059C28B30
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742473144; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=k7v+KcwJy5+rQ84d9JDEgMN6a5uMuHzxiv4GezWoHPI=;
 b=HFWuELMTmH/qXo7LqZGOWs+wK49kU0UYKFNt4Tz4YdHjs7Oc94yTSRlPcTiyn+xgC9XKG
 gZXb/yPIRL+8yrJnoAKzdH/mcArOX2NCc/6tsBmVrfWltrdrOA1sq83qQ9Fy6vu9FLwZbs1
 Rxt2P9nT/QKTCEKfZ0yBOPr2Ojo86EE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6710E3CAE13
	for <ltp@archiver.kernel.org>; Thu, 20 Mar 2025 13:19:04 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C4E13CAD41
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 13:18:43 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org;
 envelope-from=mcgrof@kernel.org; receiver=lists.linux.it)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E7F7A600429
 for <ltp@lists.linux.it>; Thu, 20 Mar 2025 13:18:42 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9239843457;
 Thu, 20 Mar 2025 12:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BC0C4CEDD;
 Thu, 20 Mar 2025 12:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742473120;
 bh=K2/BZGoFSC6TQw/cxXRdYTP8MwP9Rvb39XqZtWmojH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KF9CPQbajSzxspd6Xf8MQjoIk/2zRdL0CkWtpTdjhjG9V/wXbGEQQhelwh5bgKFXG
 uv09BvTPRO5L5cts+sXTbrNpMSt+4Qx/u5eN3id3xX9P8CkN8GpOK+SYh3NvxPbxHJ
 B14QyMiQ6ls8/0PvZvXiOaEHDzDbUp6llc9qGbuybchomC5MEJel2ly0WtNmy/uVpn
 n/1yl6iUY4rH3FLZOYJFTVlY0ZU51Ozov7TNI7+fOEU6sC1OobSH3nQD3u2mS+wuXh
 UkGG6eQqeIwWQwOY38Twpuo8VXR5mvuch7EmOBqzsjAYvMKgGKFyg0TBH/VfyWEp1r
 kGaZpJg7Izy7g==
Date: Thu, 20 Mar 2025 05:18:39 -0700
To: Matthew Wilcox <willy@infradead.org>, Johannes Weiner <hannes@cmpxchg.org>
Message-ID: <Z9wHnw4qE_6rjpxh@bombadil.infradead.org>
References: <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9wF57eEBR-42K9a@bombadil.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>,
 Christian Brauner <brauner@kernel.org>, David Bueso <dave@stgolabs.net>,
 Jan Kara <jack@suse.cz>, lkp@intel.com, David Hildenbrand <david@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, Oliver Sang <oliver.sang@intel.com>,
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 20, 2025 at 05:11:21AM -0700, Luis Chamberlain wrote:
> Sure, the culprit is the patch titled:
> 
> mm: page_alloc: trace type pollution from compaction capturing

Sorry.. that's incorrect, the right title is:

mm: compaction: push watermark into compaction_suitable() callers

  Luis

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
