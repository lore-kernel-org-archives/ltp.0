Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D546C28B30
	for <ltp@archiver.kernel.org>; Sun, 23 Mar 2025 07:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742713675; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=oQuJHzHDpRooeFJIK14LK8J9y8sNcVgc1O527iKXHXc=;
 b=IdGjlWh8N3A05EThK9uVJnlP/IcArKk9W8U8GsFrHxv/BRmZiB1w2sCday/3t8y7c9Ps3
 IFpwauGkump0o4JOwExGc2ti3xa2ofGz3Ty9FY81ChXjXOc/Xh87Q2uvGXA84tjV8VScTrk
 2XXWnaUfSQ6EqQOyRxQO8qHOq2Um1s8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72FF93C23F1
	for <ltp@archiver.kernel.org>; Sun, 23 Mar 2025 08:07:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E2763C1D2D
 for <ltp@lists.linux.it>; Sun, 23 Mar 2025 08:07:33 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3;
 helo=nyc.source.kernel.org; envelope-from=mcgrof@kernel.org;
 receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7875D14004E3
 for <ltp@lists.linux.it>; Sun, 23 Mar 2025 08:07:31 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B14FBA48733;
 Sun, 23 Mar 2025 07:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6291C4CEE2;
 Sun, 23 Mar 2025 07:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742713649;
 bh=waNR4m35arNyjJJa0jtGjNQD6uPw/33mh7/K0+sSIU0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DtaPfMGIzhAvrqUamGTqwM1triUwq3WJtmXy2fQM/+l/eFBpbreqQ6PJGuA7YlHxL
 MB3p4OjJjZU/C6YWcUXLA4zDZqvW2omU0/cFsmt6135idyi4+0iGCdqp4M9XvxJxFF
 32bdFKkg+/m6lNWc9T+RGWXE8xTy+/U2CQj8Lq1AKhELBZ3um48DbTfk+2QOV+lRyS
 oH5DWdSgtSlotIj+XTfFV8SFwnX8Z5XCkwnK0BCb6Oje9qdHVq1hZ20NX6KScKifRi
 jnUspnRHfa+5/ivFqTYm4m/LuWnJTZu4jOwppG905ycdAUOfAse+jzkOXB1MovafSd
 M64Oe4gdkbOyA==
Date: Sun, 23 Mar 2025 00:07:27 -0700
To: Johannes Weiner <hannes@cmpxchg.org>, Oliver Sang <oliver.sang@intel.com>
Message-ID: <Z9-zL3pRpCHm5a0w@bombadil.infradead.org>
References: <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
 <20250322231440.GA1894930@cmpxchg.org>
 <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z99dk_ZMNRFgaaH8@bombadil.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
 Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Mar 22, 2025 at 06:02:13PM -0700, Luis Chamberlain wrote:
> On Sat, Mar 22, 2025 at 07:14:40PM -0400, Johannes Weiner wrote:
> > Hey Luis,
> > 
> > This looks like the same issue the bot reported here:
> > 
> > https://lore.kernel.org/all/20250321135524.GA1888695@cmpxchg.org/
> > 
> > There is a fix for it queued in next-20250318 and later. Could you
> > please double check with your reproducer against a more recent next?
> 
> Confirmed, at least it's been 30 minutes and no crashes now where as
> before it would crash in 1 minute. I'll let it soak for 2.5 hours in
> the hopes I can trigger the warning originally reported by this thread.
> 
> Even though from code inspection I see how the kernel warning would
> trigger I just want to force trigger it on a test, and I can't yet.

Survied 5 hours now. This certainly fixed that crash.

As for the kernel warning, I can't yet reproduce that, so trying to
run generic/750 forever and looping
./testcases/kernel/syscalls/close_range/close_range01
and yet nothing.

Oliver can you reproduce the kernel warning on next-20250321 ?

  Luis

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
