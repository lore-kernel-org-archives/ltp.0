Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFF0C77B73
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 10:11:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E16853CD394
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 12:11:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B6A33CAC01
 for <ltp@lists.linux.it>; Wed, 24 May 2023 12:11:13 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6E4BC1A000BB
 for <ltp@lists.linux.it>; Wed, 24 May 2023 12:11:12 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 52F8B629C8;
 Wed, 24 May 2023 10:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60446C433EF;
 Wed, 24 May 2023 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684923069;
 bh=SNX4Uu1+83pn7Ar15Tpvb8G1gZD0fj3QsdAgEKC7edw=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=bsQAltPExVVp2VbxKHp3JvhNI6ezbp+25lji87qBct0XLO2WP70V858I+TGTDNCI+
 Q3CicSLpB4hazyE4wAMFqKKHUlt6h+nvBSRTePyHYZhmP/1XTAKcjO15CL4YeX4YgK
 54NIQLKnL3QZLKfjVxdBARXOxzAYIIG/Ri0Q7zUctywylwv3R0CRTiW9P+blUGTPwY
 KcqrLZn4acix72oPspco41tj33aNMuLqAdU73rPU/0fSxGPdTh0JBAYM06n6jN75Fr
 lL+wdXZs7fRGpNoI0fiE3x2X/V0VJesJLU07hXUpYLHv4hsGStB8EuAmTFlm2aNBJU
 Ob/W79oXZcrog==
Message-ID: <b35f343590352d0c669a017428e815e54e49a9ca.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 May 2023 06:11:08 -0400
In-Reply-To: <ZG3O0Oe2zlezT0ew@yuki>
References: <20230518113216.126233-1-jlayton@kernel.org>
 <68340cb2-87e1-ff17-2db8-5610beba761b@fujitsu.com>
 <c6c0ae90df044b883ed65ba1896db8b51dfa70d4.camel@kernel.org>
 <ZG3O0Oe2zlezT0ew@yuki>
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx06: use a fine-grained timestamp
 for the second time fetch
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 2023-05-24 at 10:46 +0200, Cyril Hrubis wrote:
> Hi!
> > > Now, it is not a right time to review this patch,  I prefer to review 
> > > this when your kernel patchset is merged into linux master or 
> > > linux-next. Then we can add a comment or a kernel commit id to explain 
> > > this..
> > > 
> > > 
> > 
> > Fair enough. I don't think there is any issue with taking this patch in
> > earlier however.
> > 
> > The problem with this test is that it makes the assumption that coarse-
> > grained timestamps are sufficient to bracket a filesystem operation.
> > While that has largely been true in the past, it's certainly not
> > specified by any standard.
> 
> Do we have any API to ask the kernel what the granularity of filesystem
> the timestamps is? Would that make sense to be added if it's not
> present?
> 

No, we don't have such a thing now, and we don't really track that
information in the kernel.

We do have a sb->s_time_gran field which is in units of nanoseconds, but
that really is more about the granularity that the filesystem itself can
store on disk. It doesn't tell you whether the kernel decided to put a
coarse or fine grained timestamp in there.

> Apart from that I think that this patch is fine, since the
> CLOCK_REALTIME value would be between CLOCK_REALTIME_COARSE and
> CLOCK_REALTIME_COARSE + one tick. So the change is backward compatible
> and we will not loose any precision in the assertions either.
> 
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> 

Thanks, and yes. This should be safe to apply now even if the kernel
patch series never goes in.
-- 
Jeff Layton <jlayton@kernel.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
