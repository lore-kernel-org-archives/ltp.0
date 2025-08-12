Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC49C87FCB
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 12:22:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CEA53CB477
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 14:22:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 637413C8E87
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 14:22:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B5F051400761
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 14:22:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F5AF1F45F;
 Tue, 12 Aug 2025 12:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755001345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pepnMujNJwqsUO6J5psDoIUT7GJRtkPfjog8g4JPGyQ=;
 b=VWpnTx3UEi0CrnA0YnXF5yA+/86+7mtN1v6lV7v4xz8FNcMBQgqBlZ+hb4csmqNq+lOoOs
 mrvHH3K/ElFQJh7h3ISp9ZzPGL7Iit/S6jW1gRO02WAlEmx16/Bzu42nih4Nk1jUszkrsn
 +QebFN+7L7uxxlQbn1QVX+3BSju1PVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755001345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pepnMujNJwqsUO6J5psDoIUT7GJRtkPfjog8g4JPGyQ=;
 b=WV6Cm8JWxEbZhT1kMengc8+WH9EjHeH92Lv17Tev6aOharGEjbCs3oeoAz7Uf4wGNTRybg
 KcyeIwBC3PfyqmAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755001345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pepnMujNJwqsUO6J5psDoIUT7GJRtkPfjog8g4JPGyQ=;
 b=VWpnTx3UEi0CrnA0YnXF5yA+/86+7mtN1v6lV7v4xz8FNcMBQgqBlZ+hb4csmqNq+lOoOs
 mrvHH3K/ElFQJh7h3ISp9ZzPGL7Iit/S6jW1gRO02WAlEmx16/Bzu42nih4Nk1jUszkrsn
 +QebFN+7L7uxxlQbn1QVX+3BSju1PVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755001345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pepnMujNJwqsUO6J5psDoIUT7GJRtkPfjog8g4JPGyQ=;
 b=WV6Cm8JWxEbZhT1kMengc8+WH9EjHeH92Lv17Tev6aOharGEjbCs3oeoAz7Uf4wGNTRybg
 KcyeIwBC3PfyqmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 279BF1351A;
 Tue, 12 Aug 2025 12:22:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tr6wCAEym2iBKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Aug 2025 12:22:25 +0000
Date: Tue, 12 Aug 2025 14:22:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250812122215.GE843668@pevik>
References: <20250812-cve_2025_38236-v2-1-76abeeaeaee6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250812-cve_2025_38236-v2-1-76abeeaeaee6@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cve: add CVE-2025-38236 test
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

Hi Andrea,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

> Changes in v2:
> - use MSG_DONTWAIT
> - add reference in the description
> - reduce if/else nesting
> - use different data for send()
> - Link to v1: https://lore.kernel.org/r/20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com
+1

...
> +	ret = recv(sock[0], &dummy, 1, MSG_DONTWAIT);
> +	if (ret == -1) {
> +		if (errno == EWOULDBLOCK) {
> +			tst_res(TPASS, "Can't read out-of-band data from normal stream");
> +			return;
> +		}
> +
> +		tst_brk(TBROK | TERRNO, "recv error");
> +		return;
nit: this return is not needed (can be removed before merge).
We have compilers smart enough to know that tst_brk() quits,
although there might be a warning on oldest supported toolchains.

Kind regards,
Petr

> +	}
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
