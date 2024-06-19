Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B044AC27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 17:50:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E607C3CF731
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 19:50:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E8033CF731
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 19:50:40 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E91C31A00EE5
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 19:50:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2AA51F7CF;
 Wed, 19 Jun 2024 17:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718819438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A603lLMR+P9Cx+A+kyID2wYb1KAPqEsXswcJhXvLIsE=;
 b=OuuS8mEgpB1kZRv3wDRKKnkKEZqW+k25J7bLFrGa0Nb65vy7eyOcCAIXMVyouL4pw4CfBN
 TH7Np5DB7nxeuD7gsry/XM6J1kb/fFJ7ATU+4bb3P8lGsVhps3xBriFMZ+o38lIBcIow0X
 Egqr7nIpGREqOdJB9AZTC+4AvfPfLnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718819438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A603lLMR+P9Cx+A+kyID2wYb1KAPqEsXswcJhXvLIsE=;
 b=fPweC0pVvFR6mt0B6DSGzuBlTU043o98m6UvB8LVTEIf8eityMnSNi7+B4Mz+PjkxnAyNB
 qR+qaiI5OtCXH7CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718819438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A603lLMR+P9Cx+A+kyID2wYb1KAPqEsXswcJhXvLIsE=;
 b=OuuS8mEgpB1kZRv3wDRKKnkKEZqW+k25J7bLFrGa0Nb65vy7eyOcCAIXMVyouL4pw4CfBN
 TH7Np5DB7nxeuD7gsry/XM6J1kb/fFJ7ATU+4bb3P8lGsVhps3xBriFMZ+o38lIBcIow0X
 Egqr7nIpGREqOdJB9AZTC+4AvfPfLnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718819438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A603lLMR+P9Cx+A+kyID2wYb1KAPqEsXswcJhXvLIsE=;
 b=fPweC0pVvFR6mt0B6DSGzuBlTU043o98m6UvB8LVTEIf8eityMnSNi7+B4Mz+PjkxnAyNB
 qR+qaiI5OtCXH7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3486113668;
 Wed, 19 Jun 2024 17:50:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s+iLCG4ac2ZRTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jun 2024 17:50:38 +0000
Date: Wed, 19 Jun 2024 19:50:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <20240619175035.GA508839@pevik>
References: <20240619162807.2725018-1-edliaw@google.com>
 <20240619162807.2725018-3-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240619162807.2725018-3-edliaw@google.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] sched/starvation: Choose from available
 cpus
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edward,

Thanks a lot for spotting reversed return code check in v4.
merged, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
