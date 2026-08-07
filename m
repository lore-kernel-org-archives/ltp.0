Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA42C5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 07:35:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 868D63E6FE6
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 09:35:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FA5A3E138E
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 09:35:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76CD5100098C
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 09:35:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FBD68046B;
 Fri,  7 Aug 2026 07:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786088109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxeMzAsIU4mhSpyHOmBkQmNB3fCwO4umooAThtn2EXI=;
 b=G8/sljJuet4gvWqtT9bY/Uv6HjkC94gQKhe9I7k2TumMSQlH73U1kEh7kEls+sKcMxOv8l
 Ohl8inkkRNZUW0oFvxkH2eFm9K80EUBrYjIlZvYHVSk63aCJyENUQP+lgY29aIzjmBST+U
 2KmicgCvoNfUvEa/tgy1Kege9/80I5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786088109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxeMzAsIU4mhSpyHOmBkQmNB3fCwO4umooAThtn2EXI=;
 b=DwpP8HavmI8xMzaM2r+9KWNKM1ZKmh4dH6nQ9Qu4H/01l8CQw3YcyGrf89TINBh1bQFVMK
 Z/mx+uKj5j4oRrBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K4xWLW5T;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u0zeKzI4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786088105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxeMzAsIU4mhSpyHOmBkQmNB3fCwO4umooAThtn2EXI=;
 b=K4xWLW5TcC1eU6yDD/GU6zG+/FrFXgSdwo9vRdgS3IjzerwsZ5Qm/kA8DQj6y6K86Wnkxr
 tE5bTNMi7hGd4bGsXWWk7fMnQekieLtxnBvOr1u8z0LZYz4naMh1Z+gtINAbsu8lB5Ui+r
 Pgemn/Kdz4FqytwDkPSOFiENRcqa630=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786088105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxeMzAsIU4mhSpyHOmBkQmNB3fCwO4umooAThtn2EXI=;
 b=u0zeKzI4GdMVj/fAynm3uTc6DoHs1Mhvoh3SjFiMGZdf0lwCFpdpQQ3JDDQHiYIltbSrKn
 dBwkWBs9I8AuU/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 99747779BF;
 Fri,  7 Aug 2026 07:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wLljJamKdWpLGAAAD6G6ig
 (envelope-from <pvorel@suse.de>); Fri, 07 Aug 2026 07:35:05 +0000
MIME-Version: 1.0
Date: Fri, 07 Aug 2026 09:35:05 +0200
From: pvorel <pvorel@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
In-Reply-To: <20260806-cve-2026-64600-v6-1-26c11513c75a@suse.com>
References: <20260806-cve-2026-64600-v6-1-26c11513c75a@suse.com>
User-Agent: Roundcube Webmail
Message-ID: <a1d939127b54c51fd29f869b0fe1706f@suse.de>
X-Sender: pvorel@suse.de
X-Spamd-Result: default: False [-4.48 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.18)[-0.913]; MIME_GOOD(-0.10)[text/plain];
 XM_UA_NO_VERSION(0.01)[]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9FBD68046B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] cve: reproducer for cve-2026-64600
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

...
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.runtime = 180,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.filesystems = (struct tst_fs []) {
> +		{
> +			.type = "xfs",
> +			.min_kver = "4.16",
It got introduced in 4.11. Is there a reason for testing from 4.16?
Or is it just the copy paste error?

Other than that LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +			.mkfs_ver = "mkfs.xfs >= 1.5.0",
> +			.mkfs_opts = (const char *const []) {
> +				"-m", "reflink=1",
> +				NULL
> +			},
> +		},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "2f4acd0fcd86"},
Can you please before merge use longer hash
"2f4acd0fcd862e22eab45690ec2c08c80b6ef2e7"?

> +		{"CVE", "2026-64600"},
> +		{}
> +	},
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
