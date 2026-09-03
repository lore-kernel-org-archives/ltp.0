Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A54DC624D6
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 14:58:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9344C3EB0A3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 16:58:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65B813EAD9A
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 16:57:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CD5BD1000DC7
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 16:57:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E9F71FE4D;
 Thu,  3 Sep 2026 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788447470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8X9YQLXbCiATBTMwuGYoHkbE7qdWC0HDFUXwRNhhLc=;
 b=wlTl4YKHgwRfSXqoVOKfsnw70M4m3XTPRSp2lIyi5xevj/+IDhqToiywsVtJm6M4gTbavl
 vjTj4npppQ19u3gTPtC5ngjHGNSDzfOJ/LtV/eteUTvQ+HgTfalznwYYGEFYejdqygZEnq
 FWeWLNu1XDVOaYZlOZHsHxTWY+PGKew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788447470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8X9YQLXbCiATBTMwuGYoHkbE7qdWC0HDFUXwRNhhLc=;
 b=RMdKTau4OQVv53CO6DND/lQ6geTEe1aPp7pYKf9a8ZJdqzWYy+wCC4ItxKG7nxhdGyrwkS
 ZMhm4BnNJL3iz+AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lxZ7kKqq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="tjC/TeVp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788447466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8X9YQLXbCiATBTMwuGYoHkbE7qdWC0HDFUXwRNhhLc=;
 b=lxZ7kKqqdKLzi4lD4lr+jzelto7oL1KdbwvVbbrYHAljgCZ5KsOaMSPWrD/WsBgauTvK5X
 f0SSetMERG8nYdIftI9s6qbuz3PXyaAvn2br+WloO0nGEe53m6lL3dhwD66rmBDg++eO+s
 +1Jj73wFGLTAEEyvcYgqTBBITBF9nqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788447466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P8X9YQLXbCiATBTMwuGYoHkbE7qdWC0HDFUXwRNhhLc=;
 b=tjC/TeVpX7oD8pJf+u7L8Why1M9Wc+zaCVgKAxtjGXGTlfqxhMyHa7F9VO0iXK9Css/qj7
 PciJKnXJA5pUn8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9429136D9;
 Thu,  3 Sep 2026 14:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6GtoK+mKmWpwMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 14:57:45 +0000
Date: Thu, 3 Sep 2026 16:57:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260903145740.GB1107507@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827112157.1748734-2-chrubis@suse.cz>
X-Rspamd-Queue-Id: 1E9F71FE4D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux-test-project.readthedocs.io:url];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 01/31] lib: Add tst_sysfs_assert
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

...
> +++ b/include/tst_sysfs_assert.h
...
> +/**
> + * TST_SYSFS_ASSERT_RANGELF() - Asserts that min <= val <= max.
> + *
> + * The min bound is a long long, while the max bound is read from a file,
> + * hence the LF (long long, file) suffix. The value and max paths are built
> + * by appending val_suffix/max_suffix to a common prefix built from fmt.
> + *
> + * Skips with TCONF if either file does not exist.
doc related nit: If you use
:c:enum:`TCONF <tst_res_flags>`

TCONF will be clickable in the docs, link to:
https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#c.tst_res_flags

I admit it's really ugly construct (I haven't found better), but newcomers can
find quickly TCONF related doc.

If you agree, just change it before merge.

> + *
> + * @min: A minimal value.
> + * @val_suffix: A filename the val is read from.
> + * @max_suffix: A filename the max is read from.
> + * @fmt: A printf-like format to build the path to val and max from.
> + * @...: A printf-like parameters for fmt.
> + */
> +#define TST_SYSFS_ASSERT_RANGELF(min, val_suffix, max_suffix, fmt, ...) \
> +	tst_sysfs_assert_rangelf(__FILE__, __LINE__, min, val_suffix, \
> +		max_suffix, fmt, ##__VA_ARGS__)
> +
> +void tst_sysfs_assert_rangelf(const char *file, const int lineno,
> +	long long min, const char *val_suffix, const char *max_suffix,
> +	const char *fmt, ...);
> +
> +/**
> + * TST_SYSFS_ASSERT_BOOL() - Asserts that file has boolean value.
> + *
> + * Reads a value from the file at the path built from fmt and asserts
> + * that it is a boolean (0 or 1).
> + *
> + * Skips with TCONF if the file does not exist.
And here as well.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
