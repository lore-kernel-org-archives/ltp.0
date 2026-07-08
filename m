Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ACC5C43458
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 13:31:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DC033E49E6
	for <ltp@archiver.kernel.org>; Wed,  8 Jul 2026 15:31:39 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6A673E248E
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 15:31:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 667542005D1
 for <ltp@lists.linux.it>; Wed,  8 Jul 2026 15:31:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A8DD74907;
 Wed,  8 Jul 2026 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783517482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKFvJ9ZHODSj7tqFCc3qV+a4qHuJFyMqk1vuNNjqZ+o=;
 b=XMt9IUluTFIg0Nc272a1gGLbhp0Xd7vCAvJMS7+sZwCUJ3HwweN4CeY4gbKAPF1jkFUf0e
 CiRRwQE2YmiZuaYkccaIqAVdoBo0ha7Qc+6ek/aX0dOrB2L71THp79W7wI1q0lnnRLPgVo
 vaHNUy3sTX4cPEW5XbOvN+72xqSf6Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783517482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKFvJ9ZHODSj7tqFCc3qV+a4qHuJFyMqk1vuNNjqZ+o=;
 b=7vLWebnyxnX+pP7mRG5V9xf2s+5CThW704FK0D3Y7+ejLVJPkvGLk67+nBgUimkHzNyJTa
 noaCeoOP2eH+SaDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783517481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKFvJ9ZHODSj7tqFCc3qV+a4qHuJFyMqk1vuNNjqZ+o=;
 b=nQth7zs2oJAWjxmfRb0VVvUIgNgJzUj3MDHH6606yoBGzY4094UhOEG6M4JtS0S7+C0N+F
 ukCPOHWTS1flXzOJc1dUg1sAgKfzqwxQyE/arGA1D5pBM+eDJa2dDYiM7WgoZJxZa5FIX6
 euP5wT4utXsUUOZZ/Auz1ZcuCWvZFKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783517481;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKFvJ9ZHODSj7tqFCc3qV+a4qHuJFyMqk1vuNNjqZ+o=;
 b=zRfH3rBYe1CWYLYezTmundWYkt2ExYe7cAdS3NXJoM83uOXDK09TlRD+RKtwkt83qwdShU
 WBkkP7LJki3w1tBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28ED6779AE;
 Wed,  8 Jul 2026 13:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XxV1BilRTmrcRwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 08 Jul 2026 13:31:21 +0000
Date: Wed, 8 Jul 2026 15:31:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260708133119.GA125128@pevik>
References: <20260707-cve-2026-46331-v3-0-3f6f1d697eec@suse.com>
 <20260707-cve-2026-46331-v3-2-3f6f1d697eec@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260707-cve-2026-46331-v3-2-3f6f1d697eec@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] lapi: Add pkt_sched.h fallback
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

> +#include <linux/pkt_sched.h>
> +
> +#ifndef TC_H_CLSACT
> +# define TC_H_CLSACT	TC_H_INGRESS
nit: How about using TC_H_INGRESS directly in the test? It's already defined in the
first patch.

Anyway, obviously correct.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +#endif
> +
> +#ifndef TC_H_MIN_EGRESS
> +# define TC_H_MIN_EGRESS	0xFFF3U
> +#endif
> +
> +#endif /* LAPI_PKT_SCHED_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
