Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548B1C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 14:53:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAC983CE782
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 15:53:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 573373C05DA
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 15:53:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 919FF1A0116D
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 15:53:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA3C81F7B6;
 Wed,  3 Jan 2024 14:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704293604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcLfikanub6qusRMesR7AgK1ZOl8/+KhLu+AXr/QC24=;
 b=kOSAcLVGaEOobzIo6vntfGwegtUamLXqdCjK8xhpqdUWXK878uWTP6RoTY3AQe/j8cbG+/
 YLCHF2/P2iJF9wJTgIyYmpFY5dkTMHtqSD/sXFqM31+EvX8TAdF5lPtcNI59PYeImeTfpg
 ChQLRdXtYtSJSWkOKr6AU+aAlZaT9Mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704293604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcLfikanub6qusRMesR7AgK1ZOl8/+KhLu+AXr/QC24=;
 b=xqANuhmZeLW5XPH3uD/21udvTKDV1wyjvwTmajIRkk70TXmYoicmAFaqg6UgUZnRV0ukYg
 1/EGM8xnY2GwEZDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704293604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcLfikanub6qusRMesR7AgK1ZOl8/+KhLu+AXr/QC24=;
 b=kOSAcLVGaEOobzIo6vntfGwegtUamLXqdCjK8xhpqdUWXK878uWTP6RoTY3AQe/j8cbG+/
 YLCHF2/P2iJF9wJTgIyYmpFY5dkTMHtqSD/sXFqM31+EvX8TAdF5lPtcNI59PYeImeTfpg
 ChQLRdXtYtSJSWkOKr6AU+aAlZaT9Mc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704293604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcLfikanub6qusRMesR7AgK1ZOl8/+KhLu+AXr/QC24=;
 b=xqANuhmZeLW5XPH3uD/21udvTKDV1wyjvwTmajIRkk70TXmYoicmAFaqg6UgUZnRV0ukYg
 1/EGM8xnY2GwEZDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98F961340C;
 Wed,  3 Jan 2024 14:53:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MLtTJOR0lWUwUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jan 2024 14:53:24 +0000
Date: Wed, 3 Jan 2024 15:53:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZZV0_fSR7l3JD53t@yuki>
References: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231205061639.68656-1-xuyang2018.jy@fujitsu.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[19.53%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kOSAcLVG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xqANuhmZ
X-Rspamd-Queue-Id: AA3C81F7B6
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] libltpswap: Add get_maxswapfiles api
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

Hi!
> +unsigned int get_maxswapfiles(void)
> +{
> +	unsigned int max_swapfile = 32;
> +	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0, swp_device_num = 0, swp_pte_marker_num = 0;
> +	struct tst_kconfig_var migration_kconfig = TST_KCONFIG_INIT("CONFIG_MIGRATION");
> +	struct tst_kconfig_var memory_kconfig = TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE");
> +	struct tst_kconfig_var device_kconfig = TST_KCONFIG_INIT("CONFIG_DEVICE_PRIVATE");
> +	struct tst_kconfig_var marker_kconfig = TST_KCONFIG_INIT("CONFIG_PTE_MARKER");
> +
> +	tst_kconfig_read(&migration_kconfig, 1);
> +	tst_kconfig_read(&memory_kconfig, 1);
> +	tst_kconfig_read(&device_kconfig, 1);
> +	tst_kconfig_read(&marker_kconfig, 1);

This API is designed so that we can pass an array and parse all values
in a single call. So this should be done as:

	struct tst_kconfig_var kconfig[] = {
		TST_KCONFIG_INIT("CONFIG_MIGRATION"),
		TST_KCONFIG_INIT("CONFIG_MEMORY_FAILURE"),
		...
	};

	tst_kconfig_read(kconfig, ARRAY_SIZE(kconfigs));

If you want to have a nice indexes into that array, you can create an
enum as:

	enum cfg_idx {
		CFG_MIGRATION,
		CFG_MEMORY_FAILURE,
		...
	};

Then use them in the array initialization to make sure they match:

	struct tst_kconfig_var kconfig[] = {
		[CFG_MIGRATION] = TST_KCONFIG_INIT("CONFIG_MIGRATION"),
		...
	};

And finally we can use these as:

	if (kconfig[CFG_MIGRATION].choice == 'y')


I guess that this is quite cumbersome to use, maybe we need optional
pointer in the tst_kconfig_var structure so we can pass a pointer to a
char that would be set to the value of choice then we could do:

	char migration_choice;

	struct tst_kconfig_var kconfig[] = {
		TST_KCONFIG_INIT2("CONFIG_MIGRATION", &migration_choice),
		...
	};

	if (migration_choice == 'y')
		...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
