Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1583CDB471
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 13:31:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79B5A3E0E13
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 15:31:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B3E93E0DA4
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 15:30:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C245C1000772
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 15:30:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2819470831;
 Mon, 22 Jun 2026 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782135058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1LCweTzIqdYiU/y0+H7pPGd/wjuwRjUMUIGYgNSHbaU=;
 b=sJ5fNv3jHaei6nm9kGebII8A30VYgE4naRDDdgGbpJ+EGUW5I3nx6AFAWdjxMwB+y8weJ8
 9iNgQ6D4mcbC3kyCSecJx47dIUo9Mk1JWhasYKLW33O/Yh1uQeYNio2UFhwqaTZKLay/S1
 s77CStAdDdSHeb0ad/VtrIsvs2m27jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782135058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1LCweTzIqdYiU/y0+H7pPGd/wjuwRjUMUIGYgNSHbaU=;
 b=hcPgFRhxmHcbUW3TzM6nikF55XzVhNuzAx2IzZxiJZoPyka5Z099Kp0l5a54xafdQIQrEI
 0Fl1rO1tegiK+eCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782135058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1LCweTzIqdYiU/y0+H7pPGd/wjuwRjUMUIGYgNSHbaU=;
 b=sJ5fNv3jHaei6nm9kGebII8A30VYgE4naRDDdgGbpJ+EGUW5I3nx6AFAWdjxMwB+y8weJ8
 9iNgQ6D4mcbC3kyCSecJx47dIUo9Mk1JWhasYKLW33O/Yh1uQeYNio2UFhwqaTZKLay/S1
 s77CStAdDdSHeb0ad/VtrIsvs2m27jg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782135058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1LCweTzIqdYiU/y0+H7pPGd/wjuwRjUMUIGYgNSHbaU=;
 b=hcPgFRhxmHcbUW3TzM6nikF55XzVhNuzAx2IzZxiJZoPyka5Z099Kp0l5a54xafdQIQrEI
 0Fl1rO1tegiK+eCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18D42779A8;
 Mon, 22 Jun 2026 13:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cke5BBI5OWoMKAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 22 Jun 2026 13:30:58 +0000
Date: Mon, 22 Jun 2026 15:31:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ajk5FKU8_KEBhMSU@yuki.lan>
References: <20260622-metadata_cve-v1-1-c8d43e0db19e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260622-metadata_cve-v1-1-c8d43e0db19e@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] metadata: automatically detect CVE via tags
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
>  /*
> - * Add a group to the groups array, skipping 'kernel' as it's too generic.
> - * Returns 0 if no group was added, 1 otherwise.
> + * Add a group to the groups array, skipping path components that are too
> + * generic ('kernel') or assigned from a more reliable source ('cve', which
> + * is derived from the CVE tag instead). Returns 0 if no group was added,
> + * 1 otherwise.
>   */
>  static int add_group(struct data_node *groups, const char *name)
>  {
> -	if (name && strcmp(name, "kernel")) {
> +	if (name && strcmp(name, "kernel") && strcmp(name, "cve")) {
>  		data_node_array_add(groups, data_node_string(name));
>  		return 1;
>  	}
> @@ -971,11 +973,11 @@ static void load_internal_macros(void)
>   * Add groups derived from the source file path.
>   *
>   * Groups are the two nearest parent directories (immediate parent
> - * first), skipping 'kernel' as it's too generic:
> + * first), skipping 'kernel' (too generic) and 'cve' (assigned from the
> + * CVE tag instead, see add_tag_groups()):
>   *
>   *   testcases/kernel/syscalls/clone/clone01.c  -> clone, syscalls
>   *   testcases/kernel/kvm/kvm_pagefault01.c     -> kvm
> - *   testcases/cve/cve-2017-16939.c             -> cve
>   */
>  static void add_path_groups(struct data_node *groups, const char *fname)
>  {
> @@ -1010,6 +1012,35 @@ static void add_path_groups(struct data_node *groups, const char *fname)
>  	free(buf);
>  }
>  
> +/*
> + * Add group to specific test tags.
> + */
> +static void add_tag_groups(struct data_node *groups, struct data_node *res)
> +{
> +	struct data_node *tags = data_node_hash_get(res, "tags");
> +	unsigned int i;
> +
> +	if (!tags || tags->type != DATA_ARRAY)
> +		return;
> +
> +	for (i = 0; i < data_node_array_len(tags); i++) {
> +		struct data_node *tag = tags->array.array[i];
> +		struct data_node *name;
> +
> +		if (tag->type != DATA_ARRAY || !data_node_array_len(tag))
> +			continue;
> +
> +		name = tag->array.array[0];
> +		if (name->type != DATA_STRING)
> +			continue;
> +
> +		if (!strcmp(name->string.val, "CVE")) {
> +			data_node_array_add(groups, data_node_string("cve"));
> +			return;
> +		}

We may as well add group "regression" if there is a linux-git tag
present.

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
