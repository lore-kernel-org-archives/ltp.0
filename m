Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4B7C282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 20:51:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 641893CAC42
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 21:51:51 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 89E313CA4F2
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 21:51:34 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4790414000FD
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 21:51:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B6A1D1F871;
 Tue, 18 Mar 2025 20:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742331091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBIlBp83wXanSWWJy+0Pbejw6L7ohDFvMGDaTGHVih0=;
 b=DUbswGZZ9MsH3lM1L6EHxZA1rwS/mYAswWyKtKsbLaSI+J4l4lAkbUi1x8E8OngnX9HpSa
 tngCttStqaxqJi0SCzOfx6YrFXz3NhyonHYh9+TkWJe/fUTLZyFKWKy5Tf4ZC7Geyq3KuL
 mxTvbUfLDODKqS4gc9P1mcbEtIZNtmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742331091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBIlBp83wXanSWWJy+0Pbejw6L7ohDFvMGDaTGHVih0=;
 b=VixRpddfZ3qQJYRR0XqUxiLWX/OlFSeRqiTB+76VrQTa9ndjyuBbctBXmQDO+zZlF9OnP2
 rfwj9WWCd6oVzOCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742331091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBIlBp83wXanSWWJy+0Pbejw6L7ohDFvMGDaTGHVih0=;
 b=DUbswGZZ9MsH3lM1L6EHxZA1rwS/mYAswWyKtKsbLaSI+J4l4lAkbUi1x8E8OngnX9HpSa
 tngCttStqaxqJi0SCzOfx6YrFXz3NhyonHYh9+TkWJe/fUTLZyFKWKy5Tf4ZC7Geyq3KuL
 mxTvbUfLDODKqS4gc9P1mcbEtIZNtmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742331091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lBIlBp83wXanSWWJy+0Pbejw6L7ohDFvMGDaTGHVih0=;
 b=VixRpddfZ3qQJYRR0XqUxiLWX/OlFSeRqiTB+76VrQTa9ndjyuBbctBXmQDO+zZlF9OnP2
 rfwj9WWCd6oVzOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91AB51379A;
 Tue, 18 Mar 2025 20:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /yV1ItPc2WfGAgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Mar 2025 20:51:31 +0000
Date: Tue, 18 Mar 2025 21:51:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250318205126.GA42042@pevik>
References: <x491pvczdfd.fsf@segfault.usersys.redhat.com>
 <Z9lj8izrgq0WVdEV@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9lj8izrgq0WVdEV@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4]: tst_find_backing_dev(): add support for
 overlayfs
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
Cc: Jeff Moyer <jmoyer@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jeff, Cyril,

> Hi!
> Looks good to me as well.

Great, merged.
Thanks to both.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
