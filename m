Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2946ACD6E64
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 09:53:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B02A33E305A
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:53:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9ED63CD509
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:53:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 955901400548
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:53:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 073906A819;
 Wed,  3 Jun 2026 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780480382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/F5R5GpuFPnXnfvZfrijv7DtSyPwTeFWupVjdT03QvQ=;
 b=XRzWduPt9AbN1hwE4ddZmpIhL1Ejx5DpAst1BPYp2zoOoMqpTodRZ9R++upS/dGqcFlbdY
 jFDeyZrrkbge3IDyhXs2M7ToeKnknIi5dvujkBCsv/ueoMQwU/mmxJCnq19BO+aAxfBIiW
 0miXDetnPfxwPWflt9LqVKtB/XGR/sE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780480382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/F5R5GpuFPnXnfvZfrijv7DtSyPwTeFWupVjdT03QvQ=;
 b=biG96qgoHCMoQsb1BHqDPhq0e5UecJZbLaL2C63xD9lSMq/9yuIcGjlG6l3C/tMupWNSkZ
 /6TtFPzwToLW2oBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780480382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/F5R5GpuFPnXnfvZfrijv7DtSyPwTeFWupVjdT03QvQ=;
 b=XRzWduPt9AbN1hwE4ddZmpIhL1Ejx5DpAst1BPYp2zoOoMqpTodRZ9R++upS/dGqcFlbdY
 jFDeyZrrkbge3IDyhXs2M7ToeKnknIi5dvujkBCsv/ueoMQwU/mmxJCnq19BO+aAxfBIiW
 0miXDetnPfxwPWflt9LqVKtB/XGR/sE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780480382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/F5R5GpuFPnXnfvZfrijv7DtSyPwTeFWupVjdT03QvQ=;
 b=biG96qgoHCMoQsb1BHqDPhq0e5UecJZbLaL2C63xD9lSMq/9yuIcGjlG6l3C/tMupWNSkZ
 /6TtFPzwToLW2oBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E18E55A4D7;
 Wed,  3 Jun 2026 09:53:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iyIkNn35H2pSbwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jun 2026 09:53:01 +0000
Date: Wed, 3 Jun 2026 11:52:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: XiaoLei Wu <wxl18715129466@gmail.com>
Message-ID: <ah_5erqYxee3GmBk@yuki.lan>
References: <20260602064115.718468-1-wxl18715129466@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260602064115.718468-1-wxl18715129466@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; SINGLE_SHORT_PART(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/fcntl.h: fix O_PATH fallback on alpha
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
Applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
