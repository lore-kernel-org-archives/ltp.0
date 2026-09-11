Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CC0C88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 14:36:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 380CD3E921B
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 16:36:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 312943C062E
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 16:36:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E662600B2A
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 16:36:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C57B521BB3;
 Fri, 11 Sep 2026 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789137369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAqtoYHcoV1MouBq2fzx5sNwNnI2B50lw8hfmxZpOvE=;
 b=WbtxqjXS6qF9mMzMyjYgb8fBDFSmLXomHKIJNSl8iGH6cNnUkZu+m5Pe6XREYEBNLgXvrh
 iLsXk8Jo+AqwMOwkX7PJQVBmY0+oJu583adPtuhmOkxYVVLYg6wKV5OGKrDLKEVyCAoPw+
 Fz6p4LvAWITEI1bcn4ZnSK4lG+RTah4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789137369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAqtoYHcoV1MouBq2fzx5sNwNnI2B50lw8hfmxZpOvE=;
 b=sEXyjslAed8WWddTnMzlENyXcKN2lcGeiGvtoDv83/iiC66xF0zh7xicKdY6oVcZyLxXHt
 NQz/ITP8M2N0SNCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789137365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAqtoYHcoV1MouBq2fzx5sNwNnI2B50lw8hfmxZpOvE=;
 b=v3UI6ROpkF702/gJVxBaAWdH9HDA04pxT31Ay6eUj2KqjQRpHYYU88aDKrwZWJL+wpH+wH
 xyJsYvyhM9k1O9i9XBnEdOzo+rYl1HO0aFuQqIty+cJTuzFSNiXutSodoDXqoDj+1FZPnZ
 TRKY60vr8KyrJ20yORMLDLsO2U+NS4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789137365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kAqtoYHcoV1MouBq2fzx5sNwNnI2B50lw8hfmxZpOvE=;
 b=To+A8G8fzgKIENq0UyspTSNNHpJLw+HpIk+qLZOV9l+dOf0kuHbwOhCphOZZ/cyv9jU1yD
 in+LjM/ZwIxiGxBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 940F5132D3;
 Fri, 11 Sep 2026 14:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8kMiJNURpGrgfwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 14:36:05 +0000
Date: Fri, 11 Sep 2026 16:36:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqQR19a4HTcHxPXs@yuki.lan>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-16-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-16-43b78b15ef9f@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:email,linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 16/33] keyctl24: Negative tests for
 KEYCTL_RESTRICT_KEYRING
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

> +/*
> + * A tcase with .id = NULL asks verify_negative() to allocate a fresh
> + * unrestricted keyring for the case and unlink it afterwards, so that a
> + * false-positive result cannot restrict a ring shared with later cases.
> + * .self_cycle asks for a "key_or_keyring:<fresh>:chain" restriction string
> + * pointing back at that fresh ring, needed for the EDEADLK check.
> + */
> +static struct tcase {
> +	key_serial_t *id;
> +	int self_cycle;
> +	const char *type;
> +	const char *restriction;
> +	int exp_errno;
> +	int needs_asym;
> +	const char *desc;
> +} tcases[] = {
> +	{
> +		.restriction = "builtin_trusted",
> +		.exp_errno = EINVAL,
> +		.desc = "NULL type and non-NULL restriction",
> +	},
> +	{
> +		.type = "asymmetric",
> +		.exp_errno = EINVAL,
> +		.desc = "non-NULL type and NULL restriction",
> +	},
> +	{
> +		.id = &user_key,
> +		.exp_errno = ENOTDIR,
> +		.desc = "non-keyring key",
> +	},
> +	{
> +		.type = "nosuchtype",
> +		.restriction = "builtin_trusted",
> +		.exp_errno = ENOKEY,
> +		.desc = "unknown key type",
> +	},
> +	{
> +		.type = "user",
> +		.restriction = "builtin_trusted",
> +		.exp_errno = ENOENT,
> +		.desc = "key type having no lookup_restriction",
> +	},
> +	{
> +		.type = "asymmetric",
> +		.restriction = "bogus",
> +		.exp_errno = EINVAL,
> +		.needs_asym = 1,
> +		.desc = "asymmetric with invalid restriction string",
> +	},
> +	{
> +		.type = "asymmetric",
> +		.restriction = "key_or_keyring:2147483647",
> +		.exp_errno = ENOKEY,
> +		.needs_asym = 1,
> +		.desc = "asymmetric with bogus key serial",
> +	},
> +	{
> +		.id = &ring_reject,
> +		.exp_errno = EEXIST,
> +		.desc = "already restricted keyring",
> +	},
> +	{
> +		.self_cycle = 1,
> +		.type = "asymmetric",
> +		.exp_errno = EDEADLK,
> +		.needs_asym = 1,
> +		.desc = "self-referencing key_or_keyring chain",
> +	},
> +	{
> +		.id = &ring_no_setattr,
> +		.exp_errno = EACCES,
> +		.desc = "keyring without Setattr permission",
> +	},
> +};
> +
> +static void setup(void)
> +{
> +	key_serial_t probe_ring;
> +
> +	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
> +
> +	ring_reject = new_ring("ltpkeyctl24_reject");
> +	ring_no_setattr = new_ring("ltpkeyctl24_no_setattr");
> +	SAFE_KEYCTL(KEYCTL_SETPERM, ring_no_setattr, KEY_PERM_NO_SETATTR, 0, 0);
> +
> +	/* Permanently restrict ring_reject with reject-all for EEXIST test */
> +	SAFE_KEYCTL(KEYCTL_RESTRICT_KEYRING, ring_reject, 0, 0, 0);
> +
> +	user_key = new_user_key("k", "payload", 7, KEY_SPEC_PROCESS_KEYRING);
> +
> +	/* Probe asymmetric support on a throwaway ring so we cannot poison
> +	 * any ring reused later by the tcase table.
> +	 */
> +	probe_ring = new_ring("ltpkeyctl24_probe");
> +	TEST(keyctl(KEYCTL_RESTRICT_KEYRING, probe_ring,
> +		    (unsigned long)"asymmetric", (unsigned long)"bogus", 0));
> +	asym_supported = (TST_RET != -1 || TST_ERR != ENODEV);
> +	keyctl(KEYCTL_UNLINK, probe_ring, KEY_SPEC_PROCESS_KEYRING, 0, 0);
> +}
> +
> +static void verify_negative(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	key_serial_t id, fresh_ring = 0;
> +	const char *restriction = tc->restriction;
> +	char cycle_buf[64];
> +
> +	if (tc->needs_asym && !asym_supported) {
> +		tst_res(TCONF, "asymmetric key type not supported");
> +		return;
> +	}
> +
> +	if (tc->id) {
> +		id = *tc->id;
> +	} else {
> +		fresh_ring = new_ring("ltpkeyctl24_fresh");
> +		id = fresh_ring;
> +		if (tc->self_cycle) {
> +			snprintf(cycle_buf, sizeof(cycle_buf),
> +				 "key_or_keyring:%d:chain", fresh_ring);
> +			restriction = cycle_buf;
> +		}

Maybe it would have been better if we moved the self cycle test to a
seprate testcase, instead of adding special cases to this test...

> +	}
> +
> +	TST_EXP_FAIL(keyctl(KEYCTL_RESTRICT_KEYRING, (unsigned long)id,
> +			    (unsigned long)tc->type,
> +			    (unsigned long)restriction, 0),
> +		     tc->exp_errno,
> +		     "KEYCTL_RESTRICT_KEYRING with %s", tc->desc);
> +
> +	if (fresh_ring)
> +		keyctl(KEYCTL_UNLINK, fresh_ring, KEY_SPEC_PROCESS_KEYRING,
> +		       0, 0);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test = verify_negative,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.min_kver = "4.12",
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
