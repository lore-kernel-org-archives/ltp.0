Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A79C677F1
	for <ltp@archiver.kernel.org>; Fri, 13 Jan 2023 09:13:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D8633CDC38
	for <ltp@archiver.kernel.org>; Fri, 13 Jan 2023 10:13:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7903B3CB519
 for <ltp@lists.linux.it>; Fri, 13 Jan 2023 10:13:15 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A47610006C6
 for <ltp@lists.linux.it>; Fri, 13 Jan 2023 10:13:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F47F5D75A;
 Fri, 13 Jan 2023 09:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1673601193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vP4AOYHGbPznh2ZvMHWBYWXV7NO3X+Q5OpTXs0qMYh0=;
 b=Y+mOz1+2DQO2fhvqZBOPF3y10MMgvVceyPjLWhAeR1+gZCmGHrHJYGZtvmY0qZUf45lI3S
 Q0mO1NmBm8N7gxO8Sme79JUEF2uhJh410ToYwF6dPRqaQbaMuUrJ3m2hARqgwAsXWOBPvo
 FMuW+O2HsCHmVoxPF/NN78bLHuOzkI0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1673601193;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vP4AOYHGbPznh2ZvMHWBYWXV7NO3X+Q5OpTXs0qMYh0=;
 b=pRIfpnbIVtOI4V4R8EvnO+8aQ1LG5dMnxVfumaMWT+aYb1dsYvGMquHKv+Ghu8CpXPmZbC
 QOwWYGuLHVm6szCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 78CE11358A;
 Fri, 13 Jan 2023 09:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HBrfG6kgwWNGbQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 13 Jan 2023 09:13:13 +0000
Date: Fri, 13 Jan 2023 10:13:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: coolgw <coolgw1126@gmail.com>
Message-ID: <Y8EgpwPK2EeUicjC@pevik>
References: <20230112024547.4121-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230112024547.4121-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add more strict check for tst_require_cmds
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

Hi Wei,

I rewritten the commit message, add my tag Suggested-by
and merged.

Thanks for your work!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
