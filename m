Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0943C88E64
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 09:02:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1CB93E908D
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 11:02:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94B4D3E196B
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 11:02:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3B9241A00143
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 11:02:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AA80219B6;
 Mon, 14 Sep 2026 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789376538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IyqwaKkMSSNcU9P9j3xr186fmzLYxOvouFxR0zxhRpE=;
 b=H2BlM7Rb4sIAvpg19g3Yo332ZIx7pkV2Wucivf0wuybhO+v1eaCLBiXxNTqucnzP4hgTpI
 mtYln0Mp8elWgwrU5+TRn1/XQygQGNggqCcTai6Hi8W5eucj9siUPDB+yELZnkADLT6xbd
 x7X0XhewOMUYLAFh+0ZOZjqJUNz9tTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789376538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IyqwaKkMSSNcU9P9j3xr186fmzLYxOvouFxR0zxhRpE=;
 b=21dToZGoKYiDTYb3xxqqpOkLH5LyGrxrUxb9hLHimSS3E2/LLMcneS7XKSu5fUJuvVce5U
 g9eIrn4Z+hfacXBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789376534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IyqwaKkMSSNcU9P9j3xr186fmzLYxOvouFxR0zxhRpE=;
 b=Q1PMhNiR7okMCE/xpaTt5DZXdfUPbxqSfcJwRRD9wXMfvzDtxoDh3mQ2sJ+71ZZwyeI5VW
 VTjhxK9f9M1rUUcvf+CjXiwhX05tEh8pafQQ8D1K/Jrv6UYbZyVnCZajlLQjzVA2UzpxTf
 iVpsQ9lh3HiKqAdYRSjaPZD8Ml3jlVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789376534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IyqwaKkMSSNcU9P9j3xr186fmzLYxOvouFxR0zxhRpE=;
 b=yBPz6v3ul7+kY2JKIqNXrYeOa6E8UKQjklmvDv5etIV1lVPllmNdauQITs3xG+qAZAiQ2f
 oCiES0WnVm3ju+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E04181368C;
 Mon, 14 Sep 2026 09:02:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b09BNRW4p2qgNwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 14 Sep 2026 09:02:13 +0000
Date: Mon, 14 Sep 2026 11:02:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260914090207.GC1564244@pevik>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-18-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-18-43b78b15ef9f@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 18/33] keyctl26: Test KEYCTL_DH_COMPUTE size
 query
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Test KEYCTL_DH_COMPUTE buffer size query: verify that calling
> with buflen 0 returns the required output buffer size (256)
> without writing to userspace.

...
> +static void setup(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
> +
> +	dh_params->priv = new_user_key("dh_priv", dh_priv, sizeof(dh_priv),
> +				       KEY_SPEC_PROCESS_KEYRING);

Unfortunately Leap 42.2 (which we still support) does not have struct
keyctl_dh_params priv support - added in v4.20-rc1 in
2ecefa0a15fd0 ("keys: Fix the use of the C++ keyword "private" in uapi/linux/keyctl.h")

keyctl26.c:24:11: error: dereferencing pointer to incomplete type
  dh_params->priv = new_user_key("dh_priv", dh_priv, sizeof(dh_priv),
           ^
keyctl26.c:26:11: error: dereferencing pointer to incomplete type
  dh_params->prime = new_user_key("dh_prime", dh_prime, sizeof(dh_prime),
           ^
keyctl26.c:28:11: error: dereferencing pointer to incomplete type
  dh_params->base = new_user_key("dh_base", dh_base, sizeof(dh_base),
           ^
keyctl26.c: At top level:
keyctl26.c:50:31: error: dereferencing pointer to incomplete type
   {&dh_params, .size = sizeof(*dh_params)},
                               ^
We need AC_CHECK_MEMBERS check.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
