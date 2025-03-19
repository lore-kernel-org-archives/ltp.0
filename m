Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F93C35FFA
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 19:24:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A9F733CADE1
	for <ltp@archiver.kernel.org>; Wed, 19 Mar 2025 20:24:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 027883CADC1
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:24:35 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org;
 envelope-from=willy@infradead.org; receiver=lists.linux.it)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 05AC7200C06
 for <ltp@lists.linux.it>; Wed, 19 Mar 2025 20:24:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=EpQOjPVa2Beq04kJvvraeY6xvIQbVVFWRl2dfYg/9BQ=; b=febyWxe8indQHW+/DXNc8XwTh7
 pCXPazgrVQb1NC7evVDOPeSQltfuqysNWTFC5oJj3WPOzEA2aD6iRliRra4uBuFJ13mq7UTwbfs/V
 z1n1JUECWHCnmeAomv/S7mWQSA6v0rTDYeF62tAa69tKTTbrMJVuphq3P82FjqMbUN/5W76Abd2cl
 dQpsiF2P9sTan1YH5XPb0LA41V4TPkJ9iNxITxRbCovvgb9tJLA4x84vbYEPWobTccY1GzwbBVd3R
 CjZnVFu71PRuIuEfbzM8Ubd7coSD1oeTCHb8fqZBuDXWVeLlruLDcwvqw6RonAk2AcdNTu4qbyLeL
 pMlxg84A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tuz1c-0000000E0QD-02eg; Wed, 19 Mar 2025 19:24:24 +0000
Date: Wed, 19 Mar 2025 19:24:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <Z9sZ5_lJzTwGShQT@casper.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9sYGccL4TocoITf@bombadil.infradead.org>
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

On Wed, Mar 19, 2025 at 12:16:41PM -0700, Luis Chamberlain wrote:
> On Wed, Mar 19, 2025 at 09:55:11AM -0700, Luis Chamberlain wrote:
> > FWIW, I'm not seeing this crash or any kernel splat within the
> > same time (I'll let this run the full 2.5 hours now to verify) on
> > vanilla 6.14.0-rc3 + the 64k-sector-size patches, which would explain why I
> > hadn't seen this in my earlier testing over 10 ext4 profiles on fstests. This
> > particular crash seems likely to be an artifact on the development cycle on
> > next-20250317.
> 
> I confirm that with a vanilla 6.14.0-rc3 + the 64k-sector-size patches a 2.5
> hour run generic/750 doesn't crash at all. So indeed something on the
> development cycle leads to this particular crash.

We can't debug two problems at once.

FOr the first problem, I've demonstrated what the cause is, and that's
definitely introduced by your patch, so we need to figure out a
solution.

For the second problem, we don't know what it is.  Do you want to bisect
it to figure out which commit introduced it?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
