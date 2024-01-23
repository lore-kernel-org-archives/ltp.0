Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B45FC47DDB
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 10:41:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BB9D3CE21F
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 11:41:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D4BE3CC7B2
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 11:41:19 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E0A951402FB1
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 11:41:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B68481F76E;
 Tue, 23 Jan 2024 10:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706006476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XpTYHzKfEYrqnd38mMhNXyMV2XdvnaJ3pORessBY+a4=;
 b=HlU84GQQ4sywIT3amkHiNaeNRLsnih0dHv/R9u77LASaXfjqEYYcz6U58gsFwmoBIUsmCz
 zznXcdHJhlud8zA/qfrdS/E7dQfzJ9NYjkrHfXcbjaHGU3X66FNegPSNYXjurTO8PSHmdb
 siDM2EJLRQWc4gqqiLJ8KJDActkG9JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706006476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XpTYHzKfEYrqnd38mMhNXyMV2XdvnaJ3pORessBY+a4=;
 b=gJpSJzB6nK3nTql+N/UapKg/fEzLnD9U0sarZC5x9L+Yi7McYaR7XLzDRF68eunNK6gNWY
 vcui75ljYrGe8DBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706006476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XpTYHzKfEYrqnd38mMhNXyMV2XdvnaJ3pORessBY+a4=;
 b=HlU84GQQ4sywIT3amkHiNaeNRLsnih0dHv/R9u77LASaXfjqEYYcz6U58gsFwmoBIUsmCz
 zznXcdHJhlud8zA/qfrdS/E7dQfzJ9NYjkrHfXcbjaHGU3X66FNegPSNYXjurTO8PSHmdb
 siDM2EJLRQWc4gqqiLJ8KJDActkG9JQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706006476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XpTYHzKfEYrqnd38mMhNXyMV2XdvnaJ3pORessBY+a4=;
 b=gJpSJzB6nK3nTql+N/UapKg/fEzLnD9U0sarZC5x9L+Yi7McYaR7XLzDRF68eunNK6gNWY
 vcui75ljYrGe8DBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C6D213786;
 Tue, 23 Jan 2024 10:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ciMUJMyXr2XYHQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 23 Jan 2024 10:41:16 +0000
Date: Tue, 23 Jan 2024 11:41:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Za-X2FD2qfv-xbbe@yuki>
References: <20240117080446.9663-1-wegao@suse.com>
 <20240117125227.24700-1-wegao@suse.com>
 <20240117125227.24700-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117125227.24700-2-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HlU84GQQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gJpSJzB6
X-Spamd-Result: default: False [0.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[28.79%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B68481F76E
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] lib: TST_EXP_FAIL_PTR
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
> +#define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, ERRNOS, ERRNOS_CNT, ...)       \
> +	do {                                                                   \
> +		TESTPTR(SCALL);                                                \
> +		                                                               \
> +		TST_PASS = 0;                                                  \
> +		                                                               \
> +		if (TST_RET_PTR) {                                             \

Unfortunatelly there are two types of calls, one returns NULL on a
failure and the second returns (void *)-1, from the top of my head these
are mmap(), shmat() and possibly other memory related syscalls.

So I suppose that this macro needs another parameter for the actual
value that is returned on a failure:

#define TST_EXP_FAIL_SILENT_PTR_(SCALL, SSCALL, FAIL_PTR_VAL, ERRNOS, ...)
	do {
		TESTPTR(SCALL);

		...

		if (TST_RET_PTR == FAILPTR_VAL) {
		...


The hard question is if we want to pass this parameter explicitly from the
macros used by the tests, i.e. if each test would need to specify a
FAIL_PTR_VAL or if we want to pass it in the macros, but that would mean
that the number of macros will explode again and we would have to figure
out a good names. So maybe it would be easier to pass them from each
test.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
