Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC34DC54E64
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 12:34:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42D263CFED4
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 13:34:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 094003CFB4D
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 13:34:26 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4B4AF1400DE3
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 13:34:25 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4604235141;
 Mon, 25 Mar 2024 12:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711370065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ch1jjnzW5VOP1MLy3E5ZXFKp64r/3SOMmvvBXpdhM/0=;
 b=SY3hOr4mSSXqLPsswOvxDkDOPgV3hitKFXP6JWV3ImC8dlo/wlj4Lj7xA8Bythv89tFvcK
 BbsNxglpJOVCC0CCICommy4vQxpymGXLRdk/9tc7YUrHLH2vA/jVrlqG3MZHBK2ghiazj8
 gDwLeokPDGcUQ1fOeL4drXXxoJEwwY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711370065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ch1jjnzW5VOP1MLy3E5ZXFKp64r/3SOMmvvBXpdhM/0=;
 b=lhJLmoZH0UQl2aGPN/aDoba0otzj1UGtNR0CJx2PHH8OGSKPfkK3Fc669rUa0VCrAhw999
 G5z7MR16cFq8MRAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711370065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ch1jjnzW5VOP1MLy3E5ZXFKp64r/3SOMmvvBXpdhM/0=;
 b=SY3hOr4mSSXqLPsswOvxDkDOPgV3hitKFXP6JWV3ImC8dlo/wlj4Lj7xA8Bythv89tFvcK
 BbsNxglpJOVCC0CCICommy4vQxpymGXLRdk/9tc7YUrHLH2vA/jVrlqG3MZHBK2ghiazj8
 gDwLeokPDGcUQ1fOeL4drXXxoJEwwY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711370065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ch1jjnzW5VOP1MLy3E5ZXFKp64r/3SOMmvvBXpdhM/0=;
 b=lhJLmoZH0UQl2aGPN/aDoba0otzj1UGtNR0CJx2PHH8OGSKPfkK3Fc669rUa0VCrAhw999
 G5z7MR16cFq8MRAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 22C2F13A2E;
 Mon, 25 Mar 2024 12:34:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id nT7bBlFvAWYFEwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 25 Mar 2024 12:34:25 +0000
Date: Mon, 25 Mar 2024 13:34:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <metan@ucw.cz>
Message-ID: <20240325123419.GC627989@pevik>
References: <20240322120700.3072-1-metan@ucw.cz>
 <20240322120700.3072-2-metan@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240322120700.3072-2-metan@ucw.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[16.88%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] include: doc: Convert comments into linuxdoc
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

Hi Cyril,

generally LGTM, not looking deeply as you plan to send v2.

Do you plan later to work also on include/tst_test_macros.h?
Do you need any help on docs?

Also I should find time to study how to generate docs locally.

...
>  /**
> - * Add, check or remove a capabilities
> + * tst_cap_setup() - Add, check or remove a capabilities.
> + *
> + * @cap: An {} terminated array of capabilities to alter.
> + * @action_mask: Decides which actions are done, i.e. only drop caps, add them
> + *               or both.
>   *
>   * Takes a NULL terminated array of structs which describe whether some
>   * capabilities are needed or not and mask that determines subset of the
>   * actions to be performed. Loops over the array and if mask matches the
>   * element action it's passed to tst_cap_action().
>   */
> -void tst_cap_setup(struct tst_cap *cap, unsigned int action_mask);
> +void tst_cap_setup(struct tst_cap *cap, enum tst_cap_act action_mask);

This is a real code change, which could be merged separately on the docs change.
But I see whole patchset is not only about docs, but about moving definitions
into enums thus OK for me.

>  #endif /* TST_CAPABILITY_H */
> diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
> index 1b6911d73..62d87d60b 100644
> --- a/include/tst_checkpoint.h
> +++ b/include/tst_checkpoint.h
> @@ -1,24 +1,86 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later
> +// SPDX-License-Identifier: GPL-2.0-or-later

I guess this change will cause checkpatch.pl to complain:

tst_checkpoint.h:1: WARNING: Improper SPDX comment style for 'tst_checkpoint.h', please use '/*' instead
tst_checkpoint.h:1: WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Generally LGTM.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
