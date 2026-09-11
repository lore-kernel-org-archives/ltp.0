Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F60C88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:44:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50DAE3E9206
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 11:44:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F7E33C18A4
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 11:44:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E8E172005ED
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 11:44:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75F5E1FEED;
 Fri, 11 Sep 2026 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789119839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VuVUsFslua3athFE15TtzTJwX+YfvZ4wxdF3BzbiQis=;
 b=Gs7Hr4bSbTfwPgnQfe1gS9/4cXr7Vt51/sZXOBzYpMU0ZXEn/EjEQj23AxPWYtf8S4fYjD
 +5JXlAn/xKLSAHMUX/SXT3dG2wXrk0EUrF1M/Xd5gm8ltaHseDD8chMlghb0YZYoseneUa
 z1DXhclDw//lb/dMYiEs6Xde3WyTp6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789119839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VuVUsFslua3athFE15TtzTJwX+YfvZ4wxdF3BzbiQis=;
 b=XUOZH7wU45H/Qpx1uzSj8oCTrSN5WkGCU2A5MQispK6EHVDn1pMQEFpR+jGs+M46OyyZjo
 mwTSS2x5bG6GAYDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789119835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VuVUsFslua3athFE15TtzTJwX+YfvZ4wxdF3BzbiQis=;
 b=yg7fbNTQ51BWjGHB3idyg3RuVCTwRuR4zFBBy9U8EKhZX6tCKbFZLp8I95hG191hExES1Y
 yGbH/+G6G3TlxEtpKjhrFG07lCNa4sl1nFqYo5EEG3UUcpBPqdcrCeTUj96xsuLoG30pF6
 2FbigFC9vWwIeSGITw/ddIN3wfbx4D8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789119835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VuVUsFslua3athFE15TtzTJwX+YfvZ4wxdF3BzbiQis=;
 b=aYvSiyKj5WRykwKh/RPBZImSzsnu2oHWui58gOR1SubnpBIBbkk7zpb/j43hzM+Klf7UsD
 3UUWyRhzHi4S+1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DDC3136ED;
 Fri, 11 Sep 2026 09:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 65CHCFvNo2qgVAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 09:43:55 +0000
Date: Fri, 11 Sep 2026 11:43:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260911094345.GC1435339@pevik>
References: <20260911-fix_core_leak_astra-v1-1-bc5cb35a182a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260911-fix_core_leak_astra-v1-1-bc5cb35a182a@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_af_alg: Fix control buffer memory leak
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
Cc: Linux Test Project <ltp@lists.linux.it>, Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> The ancillary control buffer allocated in tst_alg_sendmsg() is never
> freed after sendmsg(), leaking memory on repeated calls in the same
> process.

> Free the buffer once sendmsg() completes.

Good catch, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Fixes: 3cbb963abb9e ("lib/tst_af_alg: add tst_alg_sendmsg()")
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  lib/tst_af_alg.c | 2 ++
>  1 file changed, 2 insertions(+)

> diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
> index 93757278f..10fb42da5 100644
> --- a/lib/tst_af_alg.c
> +++ b/lib/tst_af_alg.c
> @@ -249,4 +249,6 @@ void tst_alg_sendmsg(int reqfd, const void *data, size_t datalen,
>  	}

>  	SAFE_SENDMSG(datalen, reqfd, &msg, params->msg_flags);
> +
> +	free(control);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
