Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA87FEE57DF
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 11:13:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB6C73CB3EB
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 13:13:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 944253CB39B
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 13:13:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EDD4B1A02394
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 13:13:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 489E121850;
 Mon, 11 Sep 2023 11:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694430803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bI2xocxgJgT3icDfebASLAYl6kE6FS8EGTp1Ez+wI2c=;
 b=yxkXcAcgCt5NGe8XIHH1OmUX5x94xPcTCs9UPPrPn6E74YdzqdwUijNDGfWqpfoiyYi8Vm
 VncNBE09VNXTMGH2T3n1a2PXYXu7zd1nRKsNKaWcwvmSWHh3clcT6yOY5heSSbQRXNI9eJ
 oTvsEVogVFo9FhsM8BQ6kX2q+12NupA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694430803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bI2xocxgJgT3icDfebASLAYl6kE6FS8EGTp1Ez+wI2c=;
 b=fcRXt3MM2mJWr0Bt1yioKCPIlZgoXVS1/6KF2B9BkHEhYclw8H7qWu0fCtQGkwH2dqjfi5
 8fRQOzNdcmTUkoAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3767A13780;
 Mon, 11 Sep 2023 11:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VqiSDFP2/mQnYQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 11 Sep 2023 11:13:23 +0000
Date: Mon, 11 Sep 2023 13:14:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZP72f0JFeMhkNo9n@yuki>
References: <8ebe4638-fda2-43f0-98d6-8d49b9b5a1b5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8ebe4638-fda2-43f0-98d6-8d49b9b5a1b5@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Replacing runltp-ng with kirk
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

Hi!
> The idea, now, is to replace runltp-ng, since it's not maintained 
> anymore, and replace it with kirk in the LTP official release.

Given that runltp-ng evolved into kirk I suppose that replacing it with
kirk in LTP is what we should do, especially since nobody is going to
invest into runltp-ng anymore.

I suppose that we should:

- put kirk to some more offical place
  should it live under linux-test-project umbrela?
- replace the submodule
- add symlink from runltp-ng to kirk

Does everyone agree or should we do something different?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
