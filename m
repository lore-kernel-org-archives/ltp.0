Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287FAC88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 12:01:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 508613E816E
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 14:01:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B75AA3E816E
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 14:00:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 529526009F3
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 14:00:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59B1421A90;
 Fri, 11 Sep 2026 12:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789128049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2biSydqXI7OMM2PZtymcRkVC5dAi3gb1evJrk5CmN0I=;
 b=wbv4zocC3JXizOox11JjOKe1y65oaOYUp1GUrCJOzH8+WZR9+KNuSbAnGIRGzIVKn2lU+S
 WuP87FK5tELHoOnyaSmU+0tD7h9EqFWBVpOVaBAJT1RRbL9+7kXxt/uDtru2prNGe4HNVK
 bTpkLL7ATp63HUqeRg4AJZtkeVeKpr0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789128049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2biSydqXI7OMM2PZtymcRkVC5dAi3gb1evJrk5CmN0I=;
 b=8Wk/GtbL1NXn0ik1t70X4BLD0kv+eRaJqGPgB6J2g3EA8LCqwYPz+vLR/o621M0XS5ybRF
 NtKQCHQqwjnDO8Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LSAeUu0Z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9wWJ7nKl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789128045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2biSydqXI7OMM2PZtymcRkVC5dAi3gb1evJrk5CmN0I=;
 b=LSAeUu0ZxM+/UcTrIPI9xSknnDuR+NVAG+tp0OBFRNgC68W+j9nhoJof9xuBz1/VglgqTH
 RXdxGlxTEM6y5gBH8uxJO33O2e7/t0CPjaVrlxX7FTLBtcuBWqzqTfgLpat/zAJvUkL+1r
 u5B+jQDpVROPtB34YGeW6uNda6FpuP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789128045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2biSydqXI7OMM2PZtymcRkVC5dAi3gb1evJrk5CmN0I=;
 b=9wWJ7nKldHSA9o0gbGKWKxf/+sNFjx4qfnsG07o+h7kla+bKPNUjU/jnHm5aZDvwYLDPTy
 qR/kSteC7mhH1pCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E5B136ED;
 Fri, 11 Sep 2026 12:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id denSCW3to2q2YQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 12:00:45 +0000
Date: Fri, 11 Sep 2026 14:00:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqPtdwYK8AmVpTyk@yuki.lan>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-12-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-12-43b78b15ef9f@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 59B1421A90
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,linux.it:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 12/33] keyctl20: Test KEYCTL_MOVE displacement
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +#define RING_A_DESC	"ltpkeyctl20_a"
> +#define RING_B_DESC	"ltpkeyctl20_b"
> +#define KEY_DESC	"k"
> +#define PAYLOAD		"payload"
> +
> +static key_serial_t ring_a, ring_b;
> +static key_serial_t key_a, key_excl;
> +
> +static void setup(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
> +
> +	ring_a = new_ring(RING_A_DESC);
> +	ring_b = new_ring(RING_B_DESC);
> +
> +	key_a = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_a);
> +	key_excl = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_b);
> +
> +	/* Keep key_excl in session keyring so displacement does not destroy it */
> +	SAFE_KEYCTL(KEYCTL_LINK, key_excl, KEY_SPEC_SESSION_KEYRING, 0, 0);
> +}
> +
> +static void reset_state(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_LINK, key_a, ring_a, 0, 0);
> +	TEST(keyctl(KEYCTL_UNLINK, key_a, ring_b, 0, 0));
> +	if (TST_RET == -1 && TST_ERR != ENOENT)
> +		tst_brk(TBROK | TTERRNO, "failed to unlink key_a from ring_b");

Here as well, not sure if this is worth the trouble.

> +	SAFE_KEYCTL(KEYCTL_LINK, key_excl, ring_b, 0, 0);
> +}
> +
> +static void run(void)
> +{
> +	reset_state();
> +
> +	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key_a, ring_a, ring_b, 0));
> +
> +	TST_EXP_EQ_LI(search_ring(ring_b, "user", KEY_DESC), key_a);

And here as well.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.min_kver = "5.3",
> +};
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
