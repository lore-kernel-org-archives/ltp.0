Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EB1C47073
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 10:23:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A9F83CE51C
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 11:23:20 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2489F3CFE3F
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 21:54:42 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.dev (client-ip=95.215.58.170; helo=out-170.mta1.migadu.com;
 envelope-from=kent.overstreet@linux.dev; receiver=lists.linux.it)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [95.215.58.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2F10F600C30
 for <ltp@lists.linux.it>; Mon,  8 Jan 2024 21:54:40 +0100 (CET)
Date: Mon, 8 Jan 2024 15:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1704747279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RcYTwFfSB+4FKsdjsP7P++2hZCBcGK1EdtN9nb4v1IU=;
 b=hArcSTsZ/Ctb7L81FQJl0LBtNkZbCuNF3zeMTbiHhuE+hFnfb8tuSTPRuWOEHX59Eqgdma
 StObN5+3huGXnaWIM6Pqhpjg8aBKXGxo0K7GoSq9ZoZrgt1eRxEZ9PBRI3eAY3jTTiJsZS
 i0OyKpTi3u5KCJnhgmQq9nlALvu11CM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <gjfjylr4bdytdot7ywjispswvgpvjtkdmtsinsbcbc42ik2y3d@ws4tjmwqywrb>
References: <20231207194011.273027-1-pvorel@suse.cz>
 <20231207194011.273027-4-pvorel@suse.cz>
 <20231213024617.vx3epsav2n2lxozi@moria.home.lan>
 <ZZvIBO-a1b_nIHJ8@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZvIBO-a1b_nIHJ8@yuki>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 09 Jan 2024 11:23:06 +0100
Subject: Re: [LTP] [PATCH v2 3/3] statx04: Skip STATX_ATTR_COMPRESSED on
 Bcachefs
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
Cc: linux-bcachefs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 fstests@vger.kernel.org, Jan Kara <jack@suse.cz>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jan 08, 2024 at 11:01:40AM +0100, Cyril Hrubis wrote:
> Hi!
> > On Thu, Dec 07, 2023 at 08:40:11PM +0100, Petr Vorel wrote:
> > > STATX_ATTR_COMPRESSED is not supported on Bcachefs, thus skip it
> > > (it's already skipped on tmpfs and XFS).
> > 
> > Hang on, bcachefs most definitely does hae compression. This would be
> > just because statx isn't plumbed through?
> 
> Quite likely, other filesystems does have an inode flag that is set when
> file has been compressed and simply report that in the foo_getattr()
> callback. Looking at bcachefs I supose that we need to figure out if the
> inode is v3 and then unpack the v3 info to get to the compressed flag,
> you probably know best how to do that.

I'm still not clear how we want to map STATX_ATTR_COMPRESSED, since it's
extents that are compressed, not entire files - and just reporting the
compression option is probably not what we want since it can be flipped
off, and existing data will still be compressed.

Do you know anything about the intended use case?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
