Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC9A606A339
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FHOVsbmU;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YOlQFFYR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=FHOVsbmU;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YOlQFFYR
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE2353CFAA0
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 13:50:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F82F3CC8BD
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 13:50:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 68C9B1401103
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 13:50:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87B401F45A;
 Fri,  6 Nov 2026 12:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793969419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W+gA42K6RmXJgIzkddaXNq1cUnYUzGdPCBAKBJAGaZ0=;
 b=FHOVsbmUR/5MSOwiKCTqRnTXOdnVqbdsq2VHnHxnnrIilCrFz2uqhqcc1ppdna9cCFlIcP
 T/3QNRufS0cLX2F/D+uUKnBt9fmCCIQOto3ugDKhEZ90p7eBI+WiRS55t7/5BrGQN8oXr3
 e9e/G8ylQtUDyIDICH/Tlu2ma5TvWJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793969419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W+gA42K6RmXJgIzkddaXNq1cUnYUzGdPCBAKBJAGaZ0=;
 b=YOlQFFYRpvu7dEjiyn+OWwSavfhGqpk0DwvzDE/C4mO+e8Oi5Q/Cd9+WQ74wW3S2JUEMGA
 04awjTmdo8P/oiAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793969419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W+gA42K6RmXJgIzkddaXNq1cUnYUzGdPCBAKBJAGaZ0=;
 b=FHOVsbmUR/5MSOwiKCTqRnTXOdnVqbdsq2VHnHxnnrIilCrFz2uqhqcc1ppdna9cCFlIcP
 T/3QNRufS0cLX2F/D+uUKnBt9fmCCIQOto3ugDKhEZ90p7eBI+WiRS55t7/5BrGQN8oXr3
 e9e/G8ylQtUDyIDICH/Tlu2ma5TvWJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793969419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W+gA42K6RmXJgIzkddaXNq1cUnYUzGdPCBAKBJAGaZ0=;
 b=YOlQFFYRpvu7dEjiyn+OWwSavfhGqpk0DwvzDE/C4mO+e8Oi5Q/Cd9+WQ74wW3S2JUEMGA
 04awjTmdo8P/oiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AA51132C9;
 Fri,  6 Nov 2026 12:50:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8uTpDQvN7WqADAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 06 Nov 2026 12:50:19 +0000
Date: Fri, 6 Nov 2026 13:50:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "Li Wang (Hieco)" <li.wang@linux.dev>
Message-ID: <au3NIJatDEAIu23h@yuki.lan>
References: <20261103075722.181317-1-li.wang@linux.dev>
 <20261103075722.181317-3-li.wang@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261103075722.181317-3-li.wang@linux.dev>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,linux.it:url]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 linux.it:url]
X-Spam-Score: -13.30
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/4] tst_kconfig: load and unload kernel
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
> +	while (loaded_module_count > 0) {
> +		snprintf(name, sizeof(name), "%s",
> +			 loaded_modules[--loaded_module_count]);
> +
> +		for (p = name; (p = strchr(p, '-')); )
> +			*p = '_';

Wouldn't it be easier to enforce the module names to have only
underscores?

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index f055c2e5f..cfa513282 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -175,6 +175,9 @@ static void kconfig_module_check(struct tst_kconfig_var *var)
        size_t i;
 
        for (i = 0; config_module_maps[i].config; i++) {
+               if (strchr(config_module_map[i].module_name, '-'))
+                       tst_brk(TBROK, "Module names must contain only '_' not '-'");
+
                if (strcmp(config_module_maps[i].config, var->id))
                        continue;

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

Why not 'modprobe -r' the main difference is that 'modprobe -r' removes
all unused depended modules. If anything loaded as a dependency of the
module we loaded we are not going to be able to remove the module this
way.

> +	}
> +
> +	loaded_module_count = 0;
> +}
> +
>  static size_t array_len(const char *const kconfigs[])
>  {
>  	size_t i = 0;
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 10ff73397..a9e679bee 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1471,12 +1471,16 @@ static void do_setup(int argc, char *argv[])
>  
>  	check_supported_kver();
>  
> -	if (tst_test->needs_kconfigs && tst_kconfig_check(tst_test->needs_kconfigs))
> -		tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
> -
>  	if (tst_test->needs_root && geteuid() != 0)
>  		tst_brk(TCONF, "Test needs to be run as root");
>  
> +	if (tst_test->needs_kconfigs) {
> +		if (tst_kconfig_check(tst_test->needs_kconfigs))
> +			tst_brk(TCONF, "Aborting due to unsuitable kernel config, see above!");
> +
> +		tst_kconfig_module_load();
> +	}
> +
>  	if (tst_test->min_kver)
>  		check_kver(tst_test->min_kver, 1);
>  
> @@ -1690,6 +1694,9 @@ static void do_cleanup(void)
>  	if (tst_test->restore_wallclock)
>  		tst_wallclock_restore();
>  
> +	if (tst_test->needs_kconfigs)
> +		tst_kconfig_module_unload();
> +
>  	cleanup_ipc();
>  }
>  
> -- 
> 2.56.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
