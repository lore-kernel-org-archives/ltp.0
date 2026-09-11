Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B95AC88E4C
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 08:30:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 965F23E71EA
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 10:30:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 811133E53C2
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 10:30:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B99A51A004A3
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 10:30:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E9D191FD9B;
 Fri, 11 Sep 2026 08:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789115400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oF9vyDiB79/4ZPNBqxyfQQDKBsr5IGBpnQeTzxN1CMo=;
 b=RZFB/vVE6oqkIQbLssLDFfgWwFHql+Be9teVAIXkrjZ6MVPItuCYQxtUCPQFAN0CjFCraR
 IPkWdvmGn4yLSGIp8vr9uHLarbLt1G/BDeIR4FQCMzW+GaZ4BDr3x0o7g3iE60hof4dbpg
 qYcgLOIL3DatIfWITGWicTYz8P7sXpU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789115400;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oF9vyDiB79/4ZPNBqxyfQQDKBsr5IGBpnQeTzxN1CMo=;
 b=gv4Cow2dHOr/0BeOAoSYY//foJ9Xfz7pDtvs+/QlDEe1YECf7vnZQdiZq8QQovmamcEwT3
 Wrtf05Bem1I9yqCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C7KulvY+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3vEAxBsv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789115395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oF9vyDiB79/4ZPNBqxyfQQDKBsr5IGBpnQeTzxN1CMo=;
 b=C7KulvY+qFg3pBEsV805SmvwWmcq1vmC5DDHMGoxhN8uQccvlCOdpbpJ3/FEKu2Gaw6Y5F
 G/1g3u9HR8fdQX36fVBCP5wJuR1a/OJzvrxFN0jYUX3UfchBi7o4RXOJGl/pkzxM00tRe1
 anzAHmW3eyOApDTl6sEpuux3Fjx0tyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789115395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oF9vyDiB79/4ZPNBqxyfQQDKBsr5IGBpnQeTzxN1CMo=;
 b=3vEAxBsv0oG1XpFOpvOnKNdRqVQMVgP6DKgEM96rOqJfyuMGTTRbwm7To1t0yZzBej9qyg
 PtvfjMzJtoX2KZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B212C13715;
 Fri, 11 Sep 2026 08:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gw5yKwO8o2oWCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 08:29:55 +0000
Date: Fri, 11 Sep 2026 10:30:05 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqO8DQ-I4OUfDI8v@yuki.lan>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-8-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-8-43b78b15ef9f@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E9D191FD9B
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 08/33] keyctl16: Test KEYCTL_GET_SECURITY
 truncated copy
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
> +static void run(void)
> +{
> +	size_t i;
> +
> +	memset(buf, 0xAA, sizeof(buf));
> +	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_GET_SECURITY, key,
> +				    (unsigned long)buf, 1, 0), sec_len);
> +	if (!TST_PASS)
> +		return;
> +
> +	if (buf[0] == (char)0xAA) {
> +		tst_res(TFAIL, "nothing was copied into the buffer");
> +		return;
> +	}
> +
> +	for (i = 1; i < sizeof(buf); i++) {
> +		if (buf[i] != (char)0xAA) {
> +			tst_res(TFAIL, "copy overran the buffer at offset %zu",
> +				i);
> +			return;
> +		}
> +	}
> +
> +	tst_res(TPASS, "exactly one byte copied, full length %ld returned",
> +		sec_len);

Here as well, we can loop over all truncated lengths.

> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
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
