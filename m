Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD94C77B73
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 14:15:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D3FC3CE79F
	for <ltp@archiver.kernel.org>; Fri, 26 May 2023 16:14:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D33723C995F
 for <ltp@lists.linux.it>; Fri, 26 May 2023 16:14:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C52FF200BA4
 for <ltp@lists.linux.it>; Fri, 26 May 2023 16:14:47 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C0FB1FD83;
 Fri, 26 May 2023 14:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685110487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhyxb24pUz+CaMjKQMKdgPStNbeNFp3JrpTU8MrntMc=;
 b=xM2yGkk8tE/3yaOqCrPQoHJtfyWy5ayoynqY+Tf0FnUXqOpVzcRK4wMvoiwLauwDr5Neg8
 kTMLMvlX7k6/Kt95e7wXysadb6C0kRDnPm45K9tMMXPCT4Rq9SC5v9Gc6PPgTfpHP0r0ZV
 9geWAv9ElDSr7AHJxP/feA8G8a5O1Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685110487;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhyxb24pUz+CaMjKQMKdgPStNbeNFp3JrpTU8MrntMc=;
 b=qqs3+XWM4s6a8LgXNQoPyKztMw+jg1Em364WZdn1omzKtBWXIpGe0GaCCtm+4MIRmmCQ6d
 LiuVeEQoz7CaRSAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D8C92134AB;
 Fri, 26 May 2023 14:14:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id qMrhM9a+cGSAdQAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Fri, 26 May 2023 14:14:46 +0000
Date: Fri, 26 May 2023 16:14:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it,
 Nicolai Stange <nstange@suse.de>
Message-ID: <20230526141445.GB810612@pevik>
References: <20230526133435.7369-1-mdoucha@suse.cz>
 <20230526133435.7369-3-mdoucha@suse.cz>
 <20230526140759.GA805411@pevik> <20230526141001.GA810612@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230526141001.GA810612@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/7] Add test for CVE 2021-3656
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Martin,

> FYI used toolchain [1]:

> clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
> Target: x86_64-pc-linux-gnu

FYI it's oldstable. Debian 12 Bookworm is planned to be released on 10 June,
in two weeks this error vanishes from the CI (we don't test oldoldstable).

Kind regards,
Petr

> Kind regards,
> Petr

> [1] https://github.com/pevik/ltp/actions/runs/5091551272/jobs/9151721119

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
