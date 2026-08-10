Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE4EC5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:24:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A3D93CE9EB
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 13:24:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38EEE3CC174
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:23:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 76B9760029D
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:23:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B07B53DF4;
 Mon, 10 Aug 2026 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786361028;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jTxLFF4x/OSoIUMEOZlIFxzDSWwdZkJmV/uGBlc7jsQ=;
 b=jlPO6fhYY98pxbcb45iECPkokAhIJvi2adhWJ0B5Y+m/QYc90E54kTY+xg2nZQwO7y4EPi
 gUZo2TunuejeS+ntG2aiPXTBQEsTI/GWp//FQEjE1eDxvVhYLlJ2GNd/eI0n0QEPWdtTNY
 D0B5g685xJlJ+/x++uRojOxgpuKP7Q4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786361028;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jTxLFF4x/OSoIUMEOZlIFxzDSWwdZkJmV/uGBlc7jsQ=;
 b=vEPbpZd/Gxs9eBlfx8UsuwzjBaBhiZR6igiIidHrUE/Eh86RaNdwz41Qnh/+c5waWRSrSk
 DT4Q3ERJg1flc8BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786361024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jTxLFF4x/OSoIUMEOZlIFxzDSWwdZkJmV/uGBlc7jsQ=;
 b=jtPD6rCDYurMpiVx4RusaKjGdniimYWOqr6vRvn6FpLBZL5Fq/M+KqFOdJOWgZoZiqwSme
 VaUOUtHxK4cB99TmdJD+jMK+lZ4Qyhd8SitI4r6ny2VHB5C9FcRBMeWyP7BNHFySbqw9al
 oOwCAhkx79wInunk98A5Mkp8SuRUxHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786361024;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jTxLFF4x/OSoIUMEOZlIFxzDSWwdZkJmV/uGBlc7jsQ=;
 b=bMKXITc63uP1HeaHbiF4JFzVTKA4HaBAOzOlK9Bw4yiyXDusaXZwVA2DbyZnWtI8cReFBb
 9juV2ZE4wdt0dlCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81CF4779B2;
 Mon, 10 Aug 2026 11:23:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6l4PHsC0eWp/GwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 11:23:44 +0000
Date: Mon, 10 Aug 2026 13:23:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260810112339.GC918586@pevik>
References: <20260805151451.648990-1-pvorel@suse.cz>
 <20260805151451.648990-10-pvorel@suse.cz> <anQ2b1STktuhnLrP@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anQ2b1STktuhnLrP@rei>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 9/9] [RFC] metaparse: Check {min,
 max}_kver validity
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

Hi Cyril,

...
> > +	/* Check max_kver >= min_kver */
> > +	struct data_node *max_kver = data_node_hash_get(res, "max_kver");
> > +	struct data_node *min_kver = data_node_hash_get(res, "min_kver");
> > +	int a1, a2, a3, b1, b2, b3;
> > +
> > +	if (min_kver) {
> > +		assert(min_kver->type == DATA_STRING);
> > +		if (tst_parse_kver(min_kver->string.val, &b1, &b2, &b3)) {
> > +			fprintf(stderr, "%s: wrong min_kver: '%s'\n",
> > +				argv[optind], min_kver->string.val);
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	if (max_kver) {
> > +		assert(max_kver->type == DATA_STRING);
> > +		if (tst_parse_kver(max_kver->string.val, &a1, &a2, &a3)) {
> > +			fprintf(stderr, "%s: wrong max_kver: '%s'\n",
> > +					argv[optind], max_kver->string.val);
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	if (min_kver && max_kver) {
> > +		if (tst_kver_cmp(a1, a2, a3, b1, b2, b3) < 0) {
> > +			fprintf(stderr, "%s: min_kver (%s) > max_kver (%s)\n",
> > +					argv[optind], min_kver->string.val, max_kver->string.val);
> > +			return 1;
> > +		}
> > +	}
> > +

> Andrea is working on metadata linter, that does much more than this,
> e.g. checks that CVE record is valid.

> This looks like a check that could be added more easily there.

Thanks for info, sounds good. I'll remove last 3 patches (2 of them are RFC, I
suppose "tst_kvercmp: Factor out 2 kernels integer comparison" could be used by
Andrea in that linter).

Anyway, I consider the rest ready (agent complains are IMHO wrong), but I'll
resend.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
