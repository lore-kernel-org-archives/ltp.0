Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E53C88E4A
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 11:40:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D31123E2EA5
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:40:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22EEF3C06B9
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 13:40:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 01F1B1400DEB
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 13:40:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2154F1FE77;
 Fri, 11 Sep 2026 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789126799;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BoXzvfg9o+a3D8SuWXSOFmZd+17GA1v6eZ6sW5BN5gA=;
 b=TLYeOoqNbh6Q4i2CGxCtDs+eIOKCkfJ2TL8Qh29qJG0RbpLgh6i62XZSg7MWsJlz7R9YbP
 Hn6i55VLbHs3dfefuewBYN5I9XV3844E9JtL5X+siQhrZHuOC2SWw+w8GAvHwCbk04KDnS
 VN8RZ4BnV4l1VA6yZ7XFSNfGtmaPQAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789126799;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BoXzvfg9o+a3D8SuWXSOFmZd+17GA1v6eZ6sW5BN5gA=;
 b=qt6HcvzHY8DYXCSCiEiTtv9zJWR294x9WDKVaPRyoU5qAsvW3BbjXTedHQC490uXaPLrLN
 UaWrlF5Qtot8LkCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ULagbywk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=72njDxWu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789126795;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BoXzvfg9o+a3D8SuWXSOFmZd+17GA1v6eZ6sW5BN5gA=;
 b=ULagbywkXbFmacCB2oBFPepHHePWvYiLxuEa1HJNCzESgbXjZfg3mlt3aKB+6B7RdkXy6M
 uZqeYOvKHJVoe1RMEaPCc5kGhHSwIpd0y2U6AJuFjRALBZhRwl/ZowP58QsCpB1/nQ8Wxh
 +XHVpklSf6o2yr22Jziw/4wQtlQJ7tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789126795;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BoXzvfg9o+a3D8SuWXSOFmZd+17GA1v6eZ6sW5BN5gA=;
 b=72njDxWu/opzXq84lmaJID4cggqlo2BfTe2JNjJMCC5EHg2attr10slxn1y1VAcwYQsuCn
 ob4XcrSl1ixFbXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D69A013770;
 Fri, 11 Sep 2026 11:39:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xpHcMoroo2oOTAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 11:39:54 +0000
Date: Fri, 11 Sep 2026 13:39:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260911113949.GD1454430@pevik>
References: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
 <20260911-fix_documentation-v2-6-716b2613c477@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260911-fix_documentation-v2-6-716b2613c477@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2154F1FE77
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 6/9] include: Document memory test utilities
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

> +++ b/include/tst_memutils.h
...
> -/*
> - * Read the value of SwapFree from /proc/meminfo.
> +/**
> + * tst_available_swap() - Reads free swap from /proc/meminfo.
Maybe worth tho note SwapFree:

* tst_available_swap() - Reads free swap from /proc/meminfo using SwapFree.

> + *
> + * Return: Available swap space in KiB.
>   */
>  long long tst_available_swap(void);

...
> @@ -63,10 +59,10 @@ void tst_disable_oom_protection(pid_t pid);
>  /**
>   * tst_mapping_in_range() - Returns true if there is a mapping provided range.
>   *
> - * @low: A lower address inside of the processe address space.
> - * @high: A higher address inside of the processe address space.
> + * @low: A lower address inside of the process address space.
> + * @high: A higher address inside of the process address space.
>   *
> - * return: Returns true if there is a mapping between low and high addresses in
> + * Return: Returns true if there is a mapping between low and high addresses in
>   *         the process address space.

This is causes wrong formatting: "Returns true if there is a mapping between low
and high addresses in" being bold. Please adjust before merge.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

diff --git include/tst_memutils.h include/tst_memutils.h
index e3f18c45ef..2be476191f 100644
--- include/tst_memutils.h
+++ include/tst_memutils.h
@@ -63,7 +63,7 @@ void tst_disable_oom_protection(pid_t pid);
  * @high: A higher address inside of the process address space.
  *
  * Return: Returns true if there is a mapping between low and high addresses in
- *         the process address space.
+ * the process address space.
  */
 int tst_mapping_in_range(unsigned long low, unsigned long high);
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
