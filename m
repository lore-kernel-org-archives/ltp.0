Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA8CC433EF
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 10:32:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A0923C8CA0
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 11:32:49 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3B963C0354
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 11:32:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A973D201002
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 11:32:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C3F31F745;
 Fri, 25 Mar 2022 10:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648204357;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QG3nrj0YBF0Ui2GFb4hNQd548mmrf2alSNpGgoj4oE0=;
 b=gHrAmJCtTB/DEYBYMRTXPLsrVDdzGLE3GbxtskFDGyPgvE4RY5c8NAxsbj67EgsG4c2p/i
 gQlOTb3NfJyD4fAkG22ZRxbPanfa48XGGGDW2RrUzJejtVrYhhBek9ZkI0zaW4YGDOdaHI
 hHG38C+TNXKY3eNCXu2+jZKL76hNJ9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648204357;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QG3nrj0YBF0Ui2GFb4hNQd548mmrf2alSNpGgoj4oE0=;
 b=VCAOCJyBKva3oVpg7vJalAYfJCdUV55+EyXbQ+kk8MJRO0QlhYTvR+ZKtw5+Fki5BWRAMo
 uR0qFXF6cxv14cDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD72D1332D;
 Fri, 25 Mar 2022 10:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XjW8MESaPWJMHwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Mar 2022 10:32:36 +0000
Date: Fri, 25 Mar 2022 11:32:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yj2aQ5BN/9AV7y5a@pevik>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
 <20220325093626.11114-7-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220325093626.11114-7-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 6/9] Rewrite userns06.c using new LTP API
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
