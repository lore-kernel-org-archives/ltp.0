Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526A0C02198
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 08:21:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85AFA3C99DD
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 09:21:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79D1D3C99A6
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 09:21:38 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B9EEF140162B
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 09:21:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3F29338A2;
 Wed, 12 Feb 2025 08:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739348496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4zw2yVGxxzMY5AkiIsMj2m7H7BSp9xop3I9PLatJJZM=;
 b=JpI7iYhpEGXvPB2xVKZhQO4hBIq65JhX7o0j5F7cWjxehUecfKkNoJ4UgAGpVBuNFl3DQh
 6KX2Wgc2TzzhqOyOJDOGgNhv0GjbtgldzSMdnufy51IYkeh1hpV++JqnSc/R0zXml+w6r9
 zemAdhtJLQyTnN/WDWR+Acy1eezR5IA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739348496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4zw2yVGxxzMY5AkiIsMj2m7H7BSp9xop3I9PLatJJZM=;
 b=JCvEgZXg3O/d+xUMylTeZhQ4kqovcKgtvo3DXcy4Gk1t6A8Jo+5t34TfS772sC2Z6wMnXd
 hdeJY6wa0UPwPECg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739348496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4zw2yVGxxzMY5AkiIsMj2m7H7BSp9xop3I9PLatJJZM=;
 b=JpI7iYhpEGXvPB2xVKZhQO4hBIq65JhX7o0j5F7cWjxehUecfKkNoJ4UgAGpVBuNFl3DQh
 6KX2Wgc2TzzhqOyOJDOGgNhv0GjbtgldzSMdnufy51IYkeh1hpV++JqnSc/R0zXml+w6r9
 zemAdhtJLQyTnN/WDWR+Acy1eezR5IA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739348496;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4zw2yVGxxzMY5AkiIsMj2m7H7BSp9xop3I9PLatJJZM=;
 b=JCvEgZXg3O/d+xUMylTeZhQ4kqovcKgtvo3DXcy4Gk1t6A8Jo+5t34TfS772sC2Z6wMnXd
 hdeJY6wa0UPwPECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBCB413874;
 Wed, 12 Feb 2025 08:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xnB9LA9arGdMLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 08:21:35 +0000
Date: Wed, 12 Feb 2025 09:21:34 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250212082134.GA2007065@pevik>
References: <20250211223156.1974651-1-pvorel@suse.cz>
 <93040edf-0574-4428-b8d4-ffd91c754d08@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <93040edf-0574-4428-b8d4-ffd91c754d08@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Remove [Description] title
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

> Hi!

> Beware there are a couple of misspelling "[Description]": hugemmap17 and
> hugemmap19.
Thanks!

And I need to run the script before merge to make sure everything was updated.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
