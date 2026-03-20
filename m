Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E20E108B8F7
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 11:20:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AB2F3E2B49
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 572CE3C940A
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 12:19:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0842D200923
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 12:19:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D176F4D255;
 Fri, 20 Mar 2026 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774005583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nexJia5anVGMhANVf33OAwZaLT5w42Ist+dsJOa/edA=;
 b=eqtZ4Xlt0+RXHKV9F5Qrs6U736Fh/Xl9PMw7Y/yhd6QR1FPtJWHtlPuqHiPo3RF0J4rY8b
 de81Mp6dYXyB4ngQn9OY9Wyy91JfeM9LbqatSbrr+4zCTcnabIXkk0nlZLNXB5AfDD7LPz
 LTZHwEKmFPo0xqTqA2tH7LMr1Z2FYZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774005583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nexJia5anVGMhANVf33OAwZaLT5w42Ist+dsJOa/edA=;
 b=KUdBYj/JzRUFvROyvz+YEUqO3OofoAovkQC+wqGqw9FrcuEdahxkYCR/96ZNJpR5lauIvt
 EuXB0mE5HEcKU4AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="xrNVg5t/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mWwjkXYY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774005582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nexJia5anVGMhANVf33OAwZaLT5w42Ist+dsJOa/edA=;
 b=xrNVg5t/qvCy25nAeadi7dIDOMWGs2eCy9H0s0MNpMUBUkmnjNDE333Aor/+7OgblUc8B1
 xq8vIFCTs2MBE7oRJKX4fI3Z8RvTgyfpq/Pyq9riCXZ8HF1oSQPTg59U7M17IyV99qCWLu
 UN7pJM2qIxml7V3szzw00dt/FbJ7ADI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774005582;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nexJia5anVGMhANVf33OAwZaLT5w42Ist+dsJOa/edA=;
 b=mWwjkXYYd79Xndjsqu+GMPHvPbKORooaXKpoHZ1Ljn0jMFspUDAOEaHehKa1HcDSOUfLAi
 IAr0+00hPHiJnnDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEE594278A;
 Fri, 20 Mar 2026 11:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K8lULU4tvWmxcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Mar 2026 11:19:42 +0000
Date: Fri, 20 Mar 2026 12:19:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ab0tTjN_bw8FL-Ay@yuki.lan>
References: <20260313-listns-v2-0-38384fae9b1f@suse.com>
 <20260313-listns-v2-5-38384fae9b1f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260313-listns-v2-5-38384fae9b1f@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: D176F4D255
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] syscalls: add listns02 functionality test
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
> +	if (TST_RET < 0) {
> +		tst_res(TFAIL | TTERRNO, "listns() failed for %s", tc->desc);
> +		return;
> +	}
> +
> +	found = 0;
> +	for (int i = 0; i < TST_RET; i++) {
> +		tst_res(TDEBUG, "buf[%d] = %lu", i, buf[i]);
                                  ^
				  I would say that this is a bit
				  cryptic.

If we want have debugging output I would add something as:

	tst_res(TDEBUG, "Looking for nsid=%lu", ns_id);

	for (int i ...) {
		tst_res(TDEBUG, "list %i. nsid=%lu", i, buf[i]);

	}

Otherwise it looks good:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
