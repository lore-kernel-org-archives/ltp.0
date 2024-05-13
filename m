Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 471A8C25B10
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 12:27:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFC3D3CF0A9
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 14:27:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BD063CEFB4
 for <ltp@lists.linux.it>; Mon, 13 May 2024 14:27:06 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CF7D91A00925
 for <ltp@lists.linux.it>; Mon, 13 May 2024 14:27:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 14E3A5BD86;
 Mon, 13 May 2024 12:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715603224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBJq6pWax7R8m90XrSAzcZrYKITlaQNjpvGV1BYvtbc=;
 b=U/D0xt1QmxSgudICGsGJxQa8OoejPRRRLc9swD7+kRahbgTAWSIfxptC26hruk1k/RLgtY
 h6+yx4rpXKMIS3qRz6Lj+z/RoNkDGLyeigZ6TlBIfay/aviMyj8hVv0KM+IRccgts0MqkA
 yMc6zV+dn0bvfb3TeKh1ain1eg4PA64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715603224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBJq6pWax7R8m90XrSAzcZrYKITlaQNjpvGV1BYvtbc=;
 b=1lu0SHSbopftBcdWgZzNkOh0pB0CZLErCtSEGZY4KYyqvkKuFbuN5dl+8eU6HsNqTJKxae
 YYePPMbIeSGRgsDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715603224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBJq6pWax7R8m90XrSAzcZrYKITlaQNjpvGV1BYvtbc=;
 b=U/D0xt1QmxSgudICGsGJxQa8OoejPRRRLc9swD7+kRahbgTAWSIfxptC26hruk1k/RLgtY
 h6+yx4rpXKMIS3qRz6Lj+z/RoNkDGLyeigZ6TlBIfay/aviMyj8hVv0KM+IRccgts0MqkA
 yMc6zV+dn0bvfb3TeKh1ain1eg4PA64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715603224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NBJq6pWax7R8m90XrSAzcZrYKITlaQNjpvGV1BYvtbc=;
 b=1lu0SHSbopftBcdWgZzNkOh0pB0CZLErCtSEGZY4KYyqvkKuFbuN5dl+8eU6HsNqTJKxae
 YYePPMbIeSGRgsDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE6A11372E;
 Mon, 13 May 2024 12:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2ZSlORcHQmbGdgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 13 May 2024 12:27:03 +0000
Date: Mon, 13 May 2024 14:26:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZkIG5xalaxt21EwZ@yuki>
References: <trinity-73a44add-26d5-4c8b-b6ad-0576beafb79a-1715202092298@3c-app-webde-bap44>
 <ZjyVgVUs6wWt5cd2@yuki>
 <a182355e-d425-4646-90da-a6c86d11262c@jv-coder.de>
 <20240513104731.GA63875@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240513104731.GA63875@pevik>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_CC(0.00)[aox.de,web.de,lists.linux.it];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open_posix_testsuite: Remove inclomplete warning
 commandline argument
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
Cc: Detlef Riekenberg <wine.dev@web.de>, ltp@lists.linux.it,
 Joerg.Vehlow@aox.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +1 for replacing -W with -Wextra

Let's go with that -Wextra has been out there for long enough.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
