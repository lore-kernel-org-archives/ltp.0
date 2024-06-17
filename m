Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D031C2BA1A
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 17:37:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A19713D0D33
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 19:37:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE2E53C0123
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 19:37:21 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CEC501A00CB2
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 19:37:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0775A1F7D0;
 Mon, 17 Jun 2024 17:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718645839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzwooaZbdj/dPXhWBiFeq5lsVJVll7qPHts3xs+ADbY=;
 b=woTq9s/tjTm2CreLzg73nu7R31OmxJGT2Pzd7jUE1kjB6KusxE+BqeQoLQofEi2KHczapT
 s7dNKVzrlbOf+4Zsc6G//gyshVPRtxaYlgfZyDBZRLR/ZCH9OeaW0CcxlT4MQI5Mm8qSlc
 EtPsqJIL9agL6B0hFtZ0kM7QxlgHjfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718645839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzwooaZbdj/dPXhWBiFeq5lsVJVll7qPHts3xs+ADbY=;
 b=N1jHXcTspzgRXfzFkjEs/7xbGnonVkTx9Ud5dtE45ArBRyP/2etJhOPu1t8fUhyD7y2gOJ
 MxCoBy7A4JMi82Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K4IIS4ue;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=szXWCnIN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718645838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzwooaZbdj/dPXhWBiFeq5lsVJVll7qPHts3xs+ADbY=;
 b=K4IIS4ueSSKzhtuV6W0Z5pr6tzoPJmhTbvNbWYXwx9kOxJSuqlJWP8uzezDcZYtnBF3JKd
 h287DJhBzfUybqAuD5FbXC1p5alU77slMTFr8B32Vms2kF48OC5lzhjz2mwgOMCmvfoy9v
 CWTBozEapF0EBhu4xZvULFv+b4mKazg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718645838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DzwooaZbdj/dPXhWBiFeq5lsVJVll7qPHts3xs+ADbY=;
 b=szXWCnINnkn9a3NsVe9QgjjXK4N+Dx8NXhZ5buaIdh60oy4F61RaRRyae/I3sLM5VHla5R
 bMZdHqeEbsmNASDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEC9613AAA;
 Mon, 17 Jun 2024 17:37:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cJ6POU10cGaFEgAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 17 Jun 2024 17:37:17 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Jun 2024 19:37:17 +0200
Message-ID: <3575698.dWV9SEqChM@localhost>
Organization: SUSE
In-Reply-To: <20240612121106.11127-2-chrubis@suse.cz>
References: <20240612121106.11127-1-chrubis@suse.cz>
 <20240612121106.11127-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; HAS_ORG_HEADER(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0775A1F7D0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: tst_test: Add per filesystem mkfs and
 mount opts
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

>  /**
>   * struct tst_test - A test description.
>   *
> @@ -377,29 +407,22 @@ struct tst_ulimit_val {
>   *
>   * @dev_min_size: A minimal device size in megabytes.
>   *
> - * @dev_fs_type: If set overrides the default file system type for the device and
> - *               sets the tst_device.fs_type.
 * @format_device: Does all tst_test.needs_device would do and also formats
 *                 the device with tst_test.dev_fs_type file system as well.
We should also update 'format_device' documentation according to these changes.

> - *
> - * @dev_fs_opts: A NULL terminated array of options passed to mkfs in the case
> - *               of 'tst_test.format_device'. These options are passed to mkfs
> - *               before the device path.
> - *
...
...
> @@ -1160,6 +1160,38 @@ static void set_ulimit_(const char *file, const int lineno, const struct tst_uli
>  	safe_setrlimit(file, lineno, conf->resource, &rlim);
>  }
>  
> +static unsigned int count_fs_descs(void)
> +{
> +	unsigned int ret = 0;
> +
> +	if (!tst_test->filesystems)
> +		return 0;
> +
> +	/*
> +	 * First entry is special, if it has zero type is the it's the default
this sentence seems a bit off.

with these,
Reviewed-by: Avinesh Kumar <akumar@suse.de>
for both patches.

> +	 * entry and is either followed by a terminating entry or by filesystem
> +	 * description(s) plus terminating entry.
> +	 */
> +	if (!tst_test->filesystems[0].type)
> +		ret = 1;
> +
> +	while (tst_test->filesystems[ret].type)
> +		ret++;
> +
> +	return ret;
> +}
> +

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
