Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670DCC79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:53:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C194E3E9275
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 12:53:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54B433DEDC8
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 12:52:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7C77D1A0090B
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 12:52:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 148791FD91;
 Thu, 10 Sep 2026 10:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789037563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YQgEzLGk+ChjX7WUZdDMs0KnYZx5RNc+V8yxdSMof1Y=;
 b=HRR3go0B/wIowpYJyThonnIfKNohZLQUpCmSMhuKx6YgHvR5cdIzljjvZzlQR308eZIYM6
 i/m6QIfuLwyNKGhuz+oz7lxud97iImuEkCrWHHy0Gs/QkNbm3bF+Rc9quE+dxIIGCSlzi/
 mYhqATiynzAk/Otp6ZN2EU9tSkqhe9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789037563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YQgEzLGk+ChjX7WUZdDMs0KnYZx5RNc+V8yxdSMof1Y=;
 b=hPDgBnDhkICIzismzVYCKMER66+va91pPCihlCDeb9BKY6ScMvUVvolow6gy2e46yKjtWP
 RUioqklZqpYba2CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789037559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YQgEzLGk+ChjX7WUZdDMs0KnYZx5RNc+V8yxdSMof1Y=;
 b=RcWajPeT5fmX/UcllMcoi3wABUQsWiHt2enc3OJJhjB5hK/MIFKyakJTD9d/orWMRIIg/s
 YsQiWgM7l9qbWn+ioglRhCywsVGzGlpWstqYZBskkgvPFnsiAjalXVMFMQE0heTy1adpSN
 sDJrUnUpluKkTV/JtApjrdigquGFePw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789037559;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YQgEzLGk+ChjX7WUZdDMs0KnYZx5RNc+V8yxdSMof1Y=;
 b=CyTZX3bwEnH7DiI1fAZeM/gX2Dt3qF5fBoH3+MFzK3biSIr54moTP0JwbDNIz1czsrpGgl
 JJh9rcL+sHyUOzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D899E13180;
 Thu, 10 Sep 2026 10:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ikbgNPaLomrAZwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 10 Sep 2026 10:52:38 +0000
Date: Thu, 10 Sep 2026 12:52:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqKMALn_hFnYsQFV@yuki.lan>
References: <20260904-cve-ghostlock-v8-0-bd999083c7fb@suse.com>
 <20260904-cve-ghostlock-v8-3-bd999083c7fb@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-cve-ghostlock-v8-3-bd999083c7fb@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 3/5] lapi/sched: add SAFE_SCHED_SETATTR()
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
> +static inline int safe_sched_setattr(const char *file, const int lineno,
> +				     pid_t pid, struct sched_attr *attr,
> +				     unsigned int flags)
> +{
> +	int ret;
> +
> +	ret = sched_setattr(pid, attr, flags);
> +
> +	if (ret == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"sched_setattr(%i) failed", pid);

Maybe it would make sense to print at least the size and sched_policy as well.


Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
