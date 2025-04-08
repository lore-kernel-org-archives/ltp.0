Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5092EC36010
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744139656; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IA1Aa7PGKWsivARFdnKcawsuEPq9eZp0gt4X5zliWl8=;
 b=N/jfMhv0J2yaeFPkwKULNc0Upi5g+lgXD633oFoRs3/vAj8f9LOH64Tqg6pi4kHlWgGuT
 MKgkF0RK0A0UAI8nVrLmY4POeZxEcNdVD1aQxr+4P+j4oi3I1m+BM9xH+vN87UYYgnuShSs
 B/caAksGtt2pLNrljWiQuXd6QybtnxY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A631E3CB3BF
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 21:14:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7D773CB3B6
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 21:13:54 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3;
 helo=nyc.source.kernel.org; envelope-from=mcgrof@kernel.org;
 receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5BA681000AE9
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 21:13:53 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 4420FA491E4;
 Tue,  8 Apr 2025 19:08:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02892C4CEE8;
 Tue,  8 Apr 2025 19:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744139631;
 bh=UVl5iTpHM260MX/3qRXPG3WLcoNsa+ERXi0+vvajOWU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Om8FOAy0qhkOWGJRJHKZThT6ySOVxlDEeP7MuKeO1JluzhLZ/kY/7hbMh5f0oYzvm
 q7eLzs5ecG5R5HRMIICOJGuGQinJkbiNcTqrHvkw3LtSfK9AAs/liKBkKNtGPd0vCU
 I41pxt/qyia4nsRlDYwLlufw9j6shNU/jkMiRS74rVhwG636xUr3fJVSIdwJ8iYzWX
 lr/JlQFQPC879+UkgIKoaQYeQKbBCMXeOJX19rdsRN57O3bcyKci5b79V/ARdqr9lc
 I28SgqstrSsLLBEbzvKBH+TpoKOdFS5fIo1peHgLE12Hdsd6oD0DqanIYKD99eHhVf
 JZezGNqrbr8iw==
Date: Tue, 8 Apr 2025 12:13:49 -0700
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <Z_V1bRTwRk4a1nD-@bombadil.infradead.org>
References: <20250331074541.gK4N_A2Q@linutronix.de>
 <20250408164307.GK6266@frogsfrogsfrogs>
 <Z_VXpD-d8iC57dBc@bombadil.infradead.org>
 <CAB=NE6X2QztC4OGnJwxRWdeCVEekLBcnFf7JcgV1pKDn6DqhcA@mail.gmail.com>
 <20250408174855.GI6307@frogsfrogsfrogs>
 <Z_ViElxiCcDNpUW8@casper.infradead.org>
 <20250408180240.GM6266@frogsfrogsfrogs>
 <Z_VwF1MA-R7MgDVG@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z_VwF1MA-R7MgDVG@casper.infradead.org>
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Jan Kara <jack@suse.cz>,
 David Hildenbrand <david@redhat.com>, "Darrick J. Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
 David Bueso <dave@stgolabs.net>, lkp@intel.com, gost.dev@samsung.com,
 Alistair Popple <apopple@nvidia.com>, Pankaj Raghav <p.raghav@samsung.com>,
 John Garry <john.g.garry@oracle.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>,
 ltp@lists.linux.it, linux-block@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Tso Ted <tytso@mit.edu>,
 Oliver Sang <oliver.sang@intel.com>, Johannes Weiner <hannes@cmpxchg.org>,
 oe-lkp@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Apr 08, 2025 at 07:51:03PM +0100, Matthew Wilcox wrote:
> And then we call readahead, which will happily put order-2 folios
> in the pagecache because of my bug that we've never bothered fixing.

What was that BTW?

  Luis

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
