Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157EC606A32A
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 10:48:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99DD93E94FA
	for <ltp@archiver.kernel.org>; Wed, 25 Nov 2026 11:48:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87B363E252D
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 11:48:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 01B83600A86
 for <ltp@lists.linux.it>; Wed, 25 Nov 2026 11:48:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E6F422263;
 Wed, 25 Nov 2026 10:48:31 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FE35134CA;
 Wed, 25 Nov 2026 10:48:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +VFoB/+8BmuaewAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 25 Nov 2026 10:48:31 +0000
Date: Wed, 25 Nov 2026 11:48:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "Li Wang (Hieco)" <li.wang@linux.dev>
Message-ID: <awa9GnSOwUvDo-HE@yuki.lan>
References: <20261125030529.907385-1-li.wang@linux.dev>
 <20261125030529.907385-3-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261125030529.907385-3-li.wang@linux.dev>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 6E6F422263
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/4] tst_kconfig: load and unload kernel
 modules for CONFIG_*=m
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: wakel@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +void tst_kconfig_module_unload(void)
> +{
> +	const char *name;
> +
> +	if (!loaded_module_count)
> +		return;

This if is not really needed here.

> +	while (loaded_module_count > 0) {
> +		name = loaded_modules[--loaded_module_count];
> +
> +		tst_res(TDEBUG, "Unloading module '%s'", name);
> +
> +		if (!syscall(__NR_delete_module, name, O_NONBLOCK))
> +			continue;
> +
> +		switch (errno) {
> +		case ENOENT:		/* already unloaded */
> +		case EWOULDBLOCK:	/* in use */
> +		case EBUSY:		/* still loading or unloading */
> +		case ENOSYS:		/* no CONFIG_MODULE_UNLOAD */
> +			break;
> +		default:
> +			tst_res(TWARN | TERRNO, "Failed to unload module '%s'", name);
> +		}
> +	}
> +
> +	loaded_module_count = 0;
> +}
> +
>  static size_t array_len(const char *const kconfigs[])
>  {
>  	size_t i = 0;

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
