Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983EAC433F5
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 14:04:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C9933C06C4
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 15:04:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FCB23C0214
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 15:03:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0515D200DDD
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 15:03:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2050621129;
 Wed, 22 Dec 2021 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640181830;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sk9g2z9kPFlAgFTk0rOoabmab4dOLYdsjyiiHOcAcdM=;
 b=OnvmUGa5K2ZkEYnnqEJv7lURqyono3jLs4UBHuxqpmdUiyO4vyLHl0hIIfSN0gWmPkBV3J
 hclS39p0BSOb7sG4IxlDd1eZiN1nGA6xdKxvUdbIz02CxNG9Q899AusdkPsLnDhLUtQ/J7
 EcYQthS7Vu6aR2qeYVuaZdRfKYZu6W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640181830;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Sk9g2z9kPFlAgFTk0rOoabmab4dOLYdsjyiiHOcAcdM=;
 b=BVQ+seZ9aSD4urmbbkZP3mMlEXsIWTRNJgPHiYENprQHVt78MIQ06porGvyQSksJv2iomw
 slqYvSWqbXO3chAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E66D213D2F;
 Wed, 22 Dec 2021 14:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id M0W3NkUww2ELXAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 22 Dec 2021 14:03:49 +0000
Date: Wed, 22 Dec 2021 15:03:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YcMwRIZcQNH94xhe@pevik>
References: <20211222135234.30025-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211222135234.30025-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: Do not fail a test if oom score cannot be
 adjusted.
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,

> From: Petr Vorel <pvorel@suse.cz>

> Setting value < 0 in /proc/*/oom_score_adj requires CAP_SYS_RESOURCE or
> CAP_SYS_ADMIN. However setting the library process score is a best
> effort operation, so let's skip it silently when the user is not
> privileged to do so.
+1

LGTM, thanks for this version, I'm for merging it.

Also tested locally and on CI, working as expected.
https://github.com/pevik/ltp/runs/4607602484?check_suite_focus=true

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
