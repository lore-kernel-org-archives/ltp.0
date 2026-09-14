Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48B8C88E6A
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 09:15:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 474FB3E90A6
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 11:15:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AD3B3E907F
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 11:15:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BDC47200981
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 11:15:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 217831F786;
 Mon, 14 Sep 2026 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789377314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uzp1NoJITseQ0mbwfS9ei50/eO/079chO/Z/zTi9p0c=;
 b=mF8NFVMcu6q+uPNzPl5l1uvNLsBGQKyM8C5cOw92C0RZ02nBKnpL+SvbudX2MTcZS0Xadn
 2Z5YuEGNorzGz3XqvCHrTlfEOKjYhxaLpFzT15SNb32dy0MBEMO+TvnNuHzAJH81RHIC1g
 AVdX1gdDw/B/kiUUCoiHfgoMn8+7inw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789377314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uzp1NoJITseQ0mbwfS9ei50/eO/079chO/Z/zTi9p0c=;
 b=2GHJxhIWkSK625cqzInGFe/tynpw0b/mcjUBo1YndsM+dKNNiyM7oe7nw6eRuAx+ACHkFU
 mVfsJVZx84b3pNDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789377310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uzp1NoJITseQ0mbwfS9ei50/eO/079chO/Z/zTi9p0c=;
 b=znBXIC4/A7EI4xwc3SjrD6cKEN0F+fqgvPBxGZYzHdWafKKck3T5oJ9mlXh3N4rMlTXujp
 A2sTAsn6ZX9h1WAbeGDzqbLf8DY7P4l5Etoxv5bn/wfgNFgo2IBraNnbOnrAH/aFx04gkp
 NoqlHk1zVGLPkGjbKsPx+sY/0IhNxYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789377310;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uzp1NoJITseQ0mbwfS9ei50/eO/079chO/Z/zTi9p0c=;
 b=++FT4TgHIJLnbDwBsNyo+FwBDPK67ny66ktOgF4VMXUhl3qj+292s0EOjXdHxc/C7+XcWI
 jcwvslL858Oky8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4D7A1368C;
 Mon, 14 Sep 2026 09:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Vm9kMh27p2oVSQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 14 Sep 2026 09:15:09 +0000
Date: Mon, 14 Sep 2026 11:15:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260914091508.GD1564244@pevik>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-28-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-28-43b78b15ef9f@suse.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 28/33] keyctl34: Test KEYCTL_CAPABILITIES flag
 retrieval
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

> Test keyrings subsystem capabilities retrieval with KEYCTL_CAPABILITIES
> and verify standard capability bits (CAPABILITIES, INVALIDATE,
> RESTRICT_KEYRING, MOVE, NS_KEYRING_NAME, NS_KEY_TAG).
...
> +++ b/testcases/kernel/syscalls/keyctl/keyctl34.c
...
> +static void run(void)
> +{
> +	memset(caps, 0, sizeof(caps));
> +
> +	TEST(keyctl(KEYCTL_CAPABILITIES, (unsigned long)caps, sizeof(caps), 0, 0));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "KEYCTL_CAPABILITIES failed");
> +
> +	if (TST_RET < 2) {
> +		tst_res(TFAIL, "KEYCTL_CAPABILITIES returned %ld, expected at least 2",
> +			TST_RET);
> +		return;
> +	}
> +
> +	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_CAPABILITIES,
> +		     "KEYCTL_CAPS0_CAPABILITIES is set");
> +	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_INVALIDATE,
> +		     "KEYCTL_CAPS0_INVALIDATE is set");
> +	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_RESTRICT_KEYRING,
> +		     "KEYCTL_CAPS0_RESTRICT_KEYRING is set");
> +	TST_EXP_EXPR(caps[0] & KEYCTL_CAPS0_MOVE,
> +		     "KEYCTL_CAPS0_MOVE is set");
> +
> +	TST_EXP_EXPR(caps[1] & KEYCTL_CAPS1_NS_KEYRING_NAME,
> +		     "KEYCTL_CAPS1_NS_KEYRING_NAME is set");

We also need KEYCTL_CAPS1_NS_KEYRING_NAME fallback added in v5.9-rc1
b206f281d0ee1 ("keys: Namespace keyring names")

(trivial fix)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
