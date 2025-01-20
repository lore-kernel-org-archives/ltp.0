Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7599CC02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 13:02:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7171F3C1A1B
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 14:02:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48C493C07B5
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 14:02:20 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3B61D1BD28F9
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 14:02:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3961C1F7B4;
 Mon, 20 Jan 2025 13:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737378139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdNrLjDxcAAmSVeB1/dGkIAUYmyz5D5CDm+Jte0kP3I=;
 b=oifrkBMKghbELlg+qBMKT0sjltVHiCTwxFfBMSNdqIKMW0cTcssDBXVlaQniox54i4KHMf
 hSnkAxjsc3smDAMTYl0JWtzIHzZ9iSoeus2JpPObY/afC21fApAu2naMIB2lQzA+osVXvr
 E65gD1C/ZcOQrbc5DAAHmrzrTUnzlIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737378139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdNrLjDxcAAmSVeB1/dGkIAUYmyz5D5CDm+Jte0kP3I=;
 b=+QRvpgUTTw3NXT10vTX9PmwNBSKhVzLlMY+P9XGBTBvTvOgnyJEA9dWmvcKe9ShC1CJRZb
 7jf0nH1Kr2Pv9xDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737378139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdNrLjDxcAAmSVeB1/dGkIAUYmyz5D5CDm+Jte0kP3I=;
 b=oifrkBMKghbELlg+qBMKT0sjltVHiCTwxFfBMSNdqIKMW0cTcssDBXVlaQniox54i4KHMf
 hSnkAxjsc3smDAMTYl0JWtzIHzZ9iSoeus2JpPObY/afC21fApAu2naMIB2lQzA+osVXvr
 E65gD1C/ZcOQrbc5DAAHmrzrTUnzlIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737378139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdNrLjDxcAAmSVeB1/dGkIAUYmyz5D5CDm+Jte0kP3I=;
 b=+QRvpgUTTw3NXT10vTX9PmwNBSKhVzLlMY+P9XGBTBvTvOgnyJEA9dWmvcKe9ShC1CJRZb
 7jf0nH1Kr2Pv9xDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B521393E;
 Mon, 20 Jan 2025 13:02:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LBfsBltJjmfqZwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Jan 2025 13:02:19 +0000
Date: Mon, 20 Jan 2025 14:02:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250120130217.GA802692@pevik>
References: <20250120120606.20145-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250120120606.20145-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_has_slow_kconfig() cache the result
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

Hi Cyril, Li,


> The result from the tst_has_slow_kconfig() is not going to change so we
> can cache the result as there are several cases where the function may
> end up being called. For instance any test that calls SAFE_CLONE() will
> call the function repeatedly. This change makes the tests slightly
> faster and also avoids repeated messages in the test output.

Thanks, elegant solution, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
