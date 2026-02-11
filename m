Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC05EA3F18
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 08:55:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A68563CCB2A
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 09:55:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 159473CC23E
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 09:55:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 87E7E2001A1
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 09:55:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D45D93E726;
 Wed, 11 Feb 2026 08:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770800115;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/f7RxA2v1AWw60oNCecBh3/kyqEyePMBt26nDGeQC4E=;
 b=2eqmIwbkyaBwsESpwmbKjOFxU59cEIBilMjC37D0UALVMTvxqSig4Q1cBI3WkR+rtX/pTk
 Piz7aSYVuq7ofheZa0mhJyldnLju1oudMpC3bX412vsOjLhNp2T6g1Jwbvdu9DN9lcPG0Z
 wc68Ihe3aIAIT0bzP7TF6LHRGc55zK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770800115;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/f7RxA2v1AWw60oNCecBh3/kyqEyePMBt26nDGeQC4E=;
 b=pDze5Yse/ZYUonYJcxXO73Me6rbj3PKWpRIwrOFTcLU4P9jMMfi5Gb3pKT4n5M2SR6qeBq
 kijENQRb6i5+W9Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770800115;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/f7RxA2v1AWw60oNCecBh3/kyqEyePMBt26nDGeQC4E=;
 b=2eqmIwbkyaBwsESpwmbKjOFxU59cEIBilMjC37D0UALVMTvxqSig4Q1cBI3WkR+rtX/pTk
 Piz7aSYVuq7ofheZa0mhJyldnLju1oudMpC3bX412vsOjLhNp2T6g1Jwbvdu9DN9lcPG0Z
 wc68Ihe3aIAIT0bzP7TF6LHRGc55zK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770800115;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/f7RxA2v1AWw60oNCecBh3/kyqEyePMBt26nDGeQC4E=;
 b=pDze5Yse/ZYUonYJcxXO73Me6rbj3PKWpRIwrOFTcLU4P9jMMfi5Gb3pKT4n5M2SR6qeBq
 kijENQRb6i5+W9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B25E93EA62;
 Wed, 11 Feb 2026 08:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0Y8lKvNDjGlYIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Feb 2026 08:55:15 +0000
Date: Wed, 11 Feb 2026 09:55:14 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260211085514.GA39031@pevik>
References: <20260209234418.2810671-1-sbertram@redhat.com>
 <DGC004SO49C6.LWOJO8CM24XW@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DGC004SO49C6.LWOJO8CM24XW@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mq_timedreceive01: fails sometimes with EEXIST.
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
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stephen,

> Hi,

> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Out of curiosity I wonder how you achieve the clash. I was not able to, when
running many processes long time enough:

./mq_notify01 -i 200000 &
./mq_notify01 -i 200000 &
...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
