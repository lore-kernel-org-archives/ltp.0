Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA386E9B36A
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 12:01:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56D283D77D3
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 13:01:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B94AF3CF08F
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 13:01:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5044F600AA1
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 13:01:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE47F5BD34;
 Mon,  2 Mar 2026 12:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772452893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NRPFy8Gb0URtLINwnPswlJQqGAzy2Fdhyjj1owP6mG0=;
 b=pyelfoxg91tbCoXz8qhzBLfHUbfQvLhgU0GKh5ieT8y7jeeDi8f2V8ryUP8G4LTfmDPmq4
 IpNSxS3Jsvhym6UBolpSqwL0EbHrrqobmgyeSS+28hw4XJWaxq9BazK5k+z6Wcc31a0Til
 4629ULSgAjsyoJHjLG2d+WDFZBAHwDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772452893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NRPFy8Gb0URtLINwnPswlJQqGAzy2Fdhyjj1owP6mG0=;
 b=mRJ6gZev8eA50kxiO9Vx8WCfSimjsc4y1uT8TJNuuzmOS2kw8WMLeF6osejSatWDGOA7QG
 nefl51L4v34dWwDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772452893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NRPFy8Gb0URtLINwnPswlJQqGAzy2Fdhyjj1owP6mG0=;
 b=pyelfoxg91tbCoXz8qhzBLfHUbfQvLhgU0GKh5ieT8y7jeeDi8f2V8ryUP8G4LTfmDPmq4
 IpNSxS3Jsvhym6UBolpSqwL0EbHrrqobmgyeSS+28hw4XJWaxq9BazK5k+z6Wcc31a0Til
 4629ULSgAjsyoJHjLG2d+WDFZBAHwDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772452893;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NRPFy8Gb0URtLINwnPswlJQqGAzy2Fdhyjj1owP6mG0=;
 b=mRJ6gZev8eA50kxiO9Vx8WCfSimjsc4y1uT8TJNuuzmOS2kw8WMLeF6osejSatWDGOA7QG
 nefl51L4v34dWwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEE783EA69;
 Mon,  2 Mar 2026 12:01:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ddfFKR18pWlhGgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Mar 2026 12:01:33 +0000
Date: Mon, 2 Mar 2026 13:01:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aaV8Jz9uILMKTA_J@yuki.lan>
References: <20260123-stream_refactoring-v1-0-281b85f6ab02@suse.com>
 <20260123-stream_refactoring-v1-3-281b85f6ab02@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260123-stream_refactoring-v1-3-281b85f6ab02@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/6] fs: rewrite stream02 test using new API
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
> +	for (size_t i = 0; i < ARRAY_SIZE(modes); i++) {
> +		stream = SAFE_FOPEN(FILENAME, modes[i]);

This will TBROK instead of TFAIL if the open fails.

Maybe we need:

#define TST_EXP_PASS_PTR_NULL(SCALL, ...) \
	TST_EXP_PASS_PTR_(SCALL, #SCALL, NULL, ##__VA_ARGS__)

So that we can use that as:

	TST_EXP_PASS_PTR_NULL(fopen(FILENAME, modes[i]);

	if (TST_PASS)
		SAFE_FCLOSE(TST_RET_PTR);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
