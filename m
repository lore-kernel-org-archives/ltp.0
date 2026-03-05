Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5C8F33A7E
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 15:03:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5927E3DB2CE
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 16:03:44 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D66F43CAF08
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 16:03:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 53CA2600045
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 16:03:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 662423F896;
 Thu,  5 Mar 2026 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772722999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AYSY8XXYPRbpr5mrPHo1VKTaK1kyJcg5xRY1KzzOb7Q=;
 b=0ISNO7jwAOIeGVDV3qHLgbSNivpp6knWnNcCL2Le2YxcrxHwCvAdetZGSrlhdcqUskc1gO
 iuClIyQ7FYjq6FkiAWtPVoHV7+R8+Unbo7nzgRbRhPO+J+1Lz/jd3SoFkvgqgQbIA1AJWt
 eIllmtHp0aavGqlxhlwWkPYxMdUAR38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772722999;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AYSY8XXYPRbpr5mrPHo1VKTaK1kyJcg5xRY1KzzOb7Q=;
 b=dTh6xOsQTTTezRvqADv+Ue7py2mEy2h3J5bUH4IPgT8OSNRWr6CvPKtrYdpuXwkp2QDnmC
 9VpzD5E1Nn7UmaDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772722994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AYSY8XXYPRbpr5mrPHo1VKTaK1kyJcg5xRY1KzzOb7Q=;
 b=S1VIQ2YAW52Jg7Idg1gOm8MmFlH/g1NG3A7s5qCx5vUu3ezQkjORO+3i4UIJiAFsbXBsVV
 gbZFYYgQjQVkbBHQboCuje2GcQbKGxPoT/ZsqyrIgx5riAPX7MkAZW7B6/nkI/Me3OlltD
 9+queCDgg+9J5iQFesOGAdCh/4EmJ7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772722994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AYSY8XXYPRbpr5mrPHo1VKTaK1kyJcg5xRY1KzzOb7Q=;
 b=LF2Bj78+DXEb/K1bEdGEI4BJ1FrIUj7MXutGMMMFez3r5lUpa9GD9rYN2mrrOcdHRjafLG
 0d3Q7fb67pSOpRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53D2F3EA68;
 Thu,  5 Mar 2026 15:03:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xW1zEzKbqWmZGgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 05 Mar 2026 15:03:14 +0000
Date: Thu, 5 Mar 2026 16:03:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aambPOCOw3eowGcp@yuki.lan>
References: <20260304-fork_refactoring-v2-0-016c47c90bc1@suse.com>
 <20260304-fork_refactoring-v2-2-016c47c90bc1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260304-fork_refactoring-v2-2-016c47c90bc1@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] syscalls: refactor vfork01 using new API
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
> -	/*
> -	 * Get the device number and the inode number of "." (current-
> -	 * working directory) for the parent process.
> -	 */
> -	if (stat(Pcwd, &Stat_cwd_Pbuf) < 0) {
> -		tst_brkm(TFAIL, cleanup, "stat(2) failed to get info. of "
> -			 "working directory in parent process");
> -	}
> +	if (p_cwd)
> +		free(p_cwd);

free(NULL) is no-op, the if () is not needed.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
