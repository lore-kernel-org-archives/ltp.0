Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C4CCA5513
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 08:55:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69E623CB2E1
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 10:55:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C74CC3CB2AC
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 10:55:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EF684601B03
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 10:55:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B94CE218E2
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 08:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694595321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=twMGbZDtaqDv4xLKO2/baGFg93Gvqly1Bep1ofCg3Lw=;
 b=YMp/j7/8GSsRQVivJo8oBm3b2GniYkofyyjL+AgOf5haQsR7LrnD70Zuc0kl05rR5bdW4N
 Kc5qP0fnPqWuhpRpJY/+kwxB+B4GOy5QPsbpB8n4V7nWF1oVSkBfkoO+e6Ig/FlsZL+DPq
 ouxoQhpg2UNnqlVguKA3bN5nOmHOjFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694595321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=twMGbZDtaqDv4xLKO2/baGFg93Gvqly1Bep1ofCg3Lw=;
 b=gLZRXQW1uVYOxEwAWAfxsC6CDzuyy7M/GWjk3zXNUPAtk48cph/X90XDCgEjscZFIf3N9k
 755XiHv1U2iI2OBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D02613582
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 08:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 66QgJfl4AWXBMgAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 08:55:21 +0000
Date: Wed, 13 Sep 2023 10:56:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Message-ID: <ZQF5J0UJ25_QLwcQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP Release preparations
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
As usuall we are supposed the release LTP at the end of the month. In
order to get at least two weeks of pre-release testing I would like to
freeze the git starting next week. I will try to review and merge as
much as possible till the end of this week. If there is anything that
you think should go into the release let me know so that I can have a
look.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
