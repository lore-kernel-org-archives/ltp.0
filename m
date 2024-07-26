Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974C6C3DA70
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 13:25:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 018F23D1CC2
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 15:25:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F72A3CBC79
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 15:24:45 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD8F41001174
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 15:24:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA69B1FCFD;
 Fri, 26 Jul 2024 13:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722000283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jA7M7myeGImidSua+n/pyplOIkpy7s7A8pemOymR1c4=;
 b=MuIdtBY271a3icjJkVOQdoXE7/D+lvtCv4zLuTlvQ12potJ5s6RWmZ+gnpG07RBprYB6Zl
 YP3SBwzhFWcUtGwPAVm2FIuzQJ7sjYV5dgeaOt40wlvEmPdT9ckNJt9Zde2yKkzpShgDl1
 C7b6Mf6SEnmSP2T07zxCryNctRqyh6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722000283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jA7M7myeGImidSua+n/pyplOIkpy7s7A8pemOymR1c4=;
 b=NC+L7hDwzcO9exj592x15jypTfojAJ6UCbJuq/psYMlqJc0qV4czo2O0K0ZkfngM5a0aSk
 v+7T9TLrl7or2+Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722000283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jA7M7myeGImidSua+n/pyplOIkpy7s7A8pemOymR1c4=;
 b=MuIdtBY271a3icjJkVOQdoXE7/D+lvtCv4zLuTlvQ12potJ5s6RWmZ+gnpG07RBprYB6Zl
 YP3SBwzhFWcUtGwPAVm2FIuzQJ7sjYV5dgeaOt40wlvEmPdT9ckNJt9Zde2yKkzpShgDl1
 C7b6Mf6SEnmSP2T07zxCryNctRqyh6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722000283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jA7M7myeGImidSua+n/pyplOIkpy7s7A8pemOymR1c4=;
 b=NC+L7hDwzcO9exj592x15jypTfojAJ6UCbJuq/psYMlqJc0qV4czo2O0K0ZkfngM5a0aSk
 v+7T9TLrl7or2+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 572B71396E;
 Fri, 26 Jul 2024 13:24:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id syXVD5ujo2bPDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 13:24:43 +0000
Date: Fri, 26 Jul 2024 15:24:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240726132440.GC1066866@pevik>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
 <20240725-landlock-v4-5-66f5a1c0c693@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240725-landlock-v4-5-66f5a1c0c693@suse.com>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 5/5] Add landlock06 test
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
Cc: mic@digikod.net, gnoack@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Few notes below.

...
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.min_kver = "6.10",
nit: would not be able to check the availablity via landlock ABI == 5?

> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_SECURITY_LANDLOCK=y",
> +		NULL
Maybe we don't need this in any landlock test, if we are checking
verify_landlock_is_enabled(), right?

> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&ruleset_attr, .size = sizeof(struct landlock_ruleset_attr)},
> +		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
> +		{},
> +	},
> +	.caps = (struct tst_cap []) {
> +		TST_CAP(TST_CAP_REQ, CAP_SYS_ADMIN),
> +		{}
> +	},
> +	.format_device = 1,
> +	.mount_device = 1,
Please remove these two before merge:

$ cd metadata && make
...
testcases/kernel/syscalls/landlock/landlock06.c: useless tag: format_device
testcases/kernel/syscalls/landlock/landlock06.c: useless tag: needs_tmpdir

> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *[]) {
> +		"vfat",
> +		"exfat",
I wonder why landlock is not supported...

> +		NULL
> +	},
> +};

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
