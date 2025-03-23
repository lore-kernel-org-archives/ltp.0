Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420B7C35FFC
	for <ltp@archiver.kernel.org>; Sun, 23 Mar 2025 01:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742691759; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kHM7GdS9o3x44B5HlL84TtK6F/Virjmg6SnttevcrYw=;
 b=JCfwnSNd+KJrVorXIKzNl9AAxjocz59nvFLAKD9LRZL2VHQstdZ52YJTJj67sAZOWdIUe
 yUBHIusrOPH0SIBtzwgqhpgVnkxabEvzaaX8IFYyAzeYsAEpERXcRZbFLIi8YAPM1qv5MeP
 N4aW/4pJUZe/8yZOfLnFgMxFGJAOcD4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 511613C2869
	for <ltp@archiver.kernel.org>; Sun, 23 Mar 2025 02:02:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD1D43C1C8D
 for <ltp@lists.linux.it>; Sun, 23 Mar 2025 02:02:16 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org;
 envelope-from=mcgrof@kernel.org; receiver=lists.linux.it)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F03B4200274
 for <ltp@lists.linux.it>; Sun, 23 Mar 2025 02:02:15 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AA17E61138;
 Sun, 23 Mar 2025 01:02:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8769CC4CEDD;
 Sun, 23 Mar 2025 01:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742691733;
 bh=Ksj6kRjx99oAfhdgnyVT4Uj8dlQB6UBKFAwF5s+xPlg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CoBLcu/jy/tQoEJPKu4zMxzpXJQK+xwszeEO/+RObGT7IVe41R4YLh7oM/1WbG2+C
 RCu6SXeajWsTP5VqnQ3NDK9v/zYKtWM2bn9az2UWxngflbCe0Si4BJMRfMcJRVJim/
 gHVVGEf7cgaKVzBApnrnzpMXK6vzQztobCpuUjrW5RbvxU8ZoKKpN+jIXU+qPWgqHv
 A4Lw7of4DJ6Ury7X0esaOC62ZhTk5rlpVeQhx6iAhxxDLhuK06CsBmldeLuYufN4PZ
 gEWzErqKBdElrxe5P+ToGo99IHs8/IXf81ppfcCZYb/LTs5d+CDAksSBrR1OHGyyKQ
 owxGZ31uXdkLw==
Date: Sat, 22 Mar 2025 18:02:11 -0700
To: Johannes Weiner <hannes@cmpxchg.org>
Message-ID: <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
References: <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250322231440.GA1894930@cmpxchg.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
 Alistair Popple <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Oliver Sang <oliver.sang@intel.com>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Mar 22, 2025 at 07:14:40PM -0400, Johannes Weiner wrote:
> Hey Luis,
> 
> This looks like the same issue the bot reported here:
> 
> https://lore.kernel.org/all/20250321135524.GA1888695@cmpxchg.org/
> 
> There is a fix for it queued in next-20250318 and later. Could you
> please double check with your reproducer against a more recent next?

Confirmed, at least it's been 30 minutes and no crashes now where as
before it would crash in 1 minute. I'll let it soak for 2.5 hours in
the hopes I can trigger the warning originally reported by this thread.

Even though from code inspection I see how the kernel warning would
trigger I just want to force trigger it on a test, and I can't yet.

  Luis

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
