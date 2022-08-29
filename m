Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E197EECAAD4
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 11:40:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 019493C81E1
	for <ltp@archiver.kernel.org>; Mon, 29 Aug 2022 13:40:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B54843C0D04
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 13:40:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 12ABC1A00988
 for <ltp@lists.linux.it>; Mon, 29 Aug 2022 13:40:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D46C22B9F;
 Mon, 29 Aug 2022 11:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661773200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6BHDlAB8TTUl8P4HhZMiJ0pkCMtuJ1JSbpNDI82gAFU=;
 b=L7oiDhCeuYMpuCIj8LfV3N49vysrMPKVxoBa9IQd/qQuIF+12KK9m+ZaTbsYNoKTApxG6e
 CcuUx1zF6TEqucyiM7joFkH6jdUexGuiCFeAMe076EhwMQmGGhtfQI7h1rkQSBROjlZMkJ
 /WAB57V3tKHlgSGB+U+lVAV3HivwruA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661773200;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6BHDlAB8TTUl8P4HhZMiJ0pkCMtuJ1JSbpNDI82gAFU=;
 b=O4hFDsPnmugG1GACZwnNmGIeKCq/3d4Hq1wXmUWvtAUDgoOrB/L2eL70THI4ux/wHYaWj2
 v4qd0IkRDWhb5RBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 142971352A;
 Mon, 29 Aug 2022 11:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RG/FApClDGOvIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 29 Aug 2022 11:40:00 +0000
Date: Mon, 29 Aug 2022 13:39:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YwyljsgYIK3AvUr+@pevik>
References: <20220827002815.19116-1-pvorel@suse.cz>
 <YwyYUzvlxfIGpTwo@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YwyYUzvlxfIGpTwo@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH 0/6] Track minimal size per
 filesystem
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Joerg Vehlow <joerg.vehlow@aox-tech.de>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > This patchset require to be on the top of:

> > [RFC,1/1] API: Allow to use xfs filesystems < 300 MB
> > https://lore.kernel.org/ltp/20220817204015.31420-1-pvorel@suse.cz/
> > https://patchwork.ozlabs.org/project/ltp/patch/20220817204015.31420-1-pvorel@suse.cz/

> I'm not that sure if we want to run tests for xfs filesystem that is
> smaller than minimal size used in production. I bet that we will cover
> different codepaths that eventually end up being used in production
> that way.

	> > LTP community: do we want to depend on this behavior or we just increase from 256MB to 301 MB
	> > (either for XFS or for all). It might not be a good idea to test size users are required
	> > to use.

	> It might *not*? <confused>
	Again, I'm sorry, missing another not. I.e. I suppose normal users will not try
	to go below 301MB, therefore LTP probably should not do it either. That's why
	RFC.

@Darrick, others (kernel/LTP maintainers, embedded folks) WDYT?

I'm personally OK to use 300 MB (safer to use code paths which are used in
production), it's just that for older kernels even with xfs-progs installed it's
unnecessary boundary. We could base XFS size on runtime kernel, but unless it's
300 MB a real problem for anybody I would not address it. i.e. is there anybody
using XFS on old kernels? (old LTS, whey sooner or later need to use these
variables themselves).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/Yv4ABHlsP+BZ3bRD@pevik/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
