Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D040BE7716D
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 07:58:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4CB33DED26
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 08:58:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2FC43C8993
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 08:58:10 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A7AF763D4BC
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 08:58:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D2942115F;
 Wed,  4 Dec 2024 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733299087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ldsmq2TBaMhBf97Bo8C9ib3hhkr2bqzszV0m3ogZ3KQ=;
 b=GdXdOBOGPDfTDCyio99QRJGD9dY7/MwQbZin/mO6N3fUS1ecBrWxH1onx/GLEeQXNlxCyt
 Pbrp4rGfp02FfEjD3mXck923LZM3bLCFWk76rscITHVjG4fqA18Zn84SxBYcklYK2j8pBA
 HoduFTOeitmcgFMG+C29aKCulzU8XoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733299087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ldsmq2TBaMhBf97Bo8C9ib3hhkr2bqzszV0m3ogZ3KQ=;
 b=Ezt+7TrOorSSWQyB6Ip/eqUVKHAQLqhJt8U//RT9j8x5sS7Kyva9h28Wg0Ms9HyBq/p6ZH
 5DJYH/kdeflcODDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733299087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ldsmq2TBaMhBf97Bo8C9ib3hhkr2bqzszV0m3ogZ3KQ=;
 b=GdXdOBOGPDfTDCyio99QRJGD9dY7/MwQbZin/mO6N3fUS1ecBrWxH1onx/GLEeQXNlxCyt
 Pbrp4rGfp02FfEjD3mXck923LZM3bLCFWk76rscITHVjG4fqA18Zn84SxBYcklYK2j8pBA
 HoduFTOeitmcgFMG+C29aKCulzU8XoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733299087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ldsmq2TBaMhBf97Bo8C9ib3hhkr2bqzszV0m3ogZ3KQ=;
 b=Ezt+7TrOorSSWQyB6Ip/eqUVKHAQLqhJt8U//RT9j8x5sS7Kyva9h28Wg0Ms9HyBq/p6ZH
 5DJYH/kdeflcODDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A4821396E;
 Wed,  4 Dec 2024 07:58:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BC1TAY8LUGf7UAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Dec 2024 07:58:07 +0000
Date: Wed, 4 Dec 2024 08:56:47 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Z1ALPzhyAV6asfze@rei.lan>
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-6-chrubis@suse.cz>
 <b2bd0a57-b6f7-4bb7-8c15-d8be0dd37bf3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b2bd0a57-b6f7-4bb7-8c15-d8be0dd37bf3@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] mem/vma05.sh: Convert to the new shell library
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
> > PATH=$PATH:$PWD/../../../lib/:$PWD/testcases/lib/:: ./vma05.sh
> Is this an error? It doesn't look like a correct commit message.

Ah, I forget to add "To test the testcase run:" or something along the
lines.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
