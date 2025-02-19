Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7595AC021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 16:50:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1F433C4BD4
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 17:50:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13AAB3C0265
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 17:50:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5C347142CBA9
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 17:50:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6AFD0218F2;
 Wed, 19 Feb 2025 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739983809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8CpHx+WKFUlfd2T3HiZyY5o6gx+EtNdumMK4g0Lvcs=;
 b=i7Zqkz7HjknntSbvsD8dfYiKSWQe4LOSPMHk+8gABduD+xkzMcgmk8c46Si42+LpKuk2aN
 il8i1lYngRvtvvMa7LVlHYO2aUouo1RxDzDEZ9favAvcP3WEvll1qmCasXpYrtq4sm++U4
 21jPCn89dLGASw46m1G+u0w2sCJdeGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739983809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8CpHx+WKFUlfd2T3HiZyY5o6gx+EtNdumMK4g0Lvcs=;
 b=DZ/WAaCD9mb33uXRbYEQ+B/O0GIcgZR1aB7rEVf0l756MMhdsih/B45A8lxw7anl1WDGpZ
 GXJ/4nxQMeRIEEDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i7Zqkz7H;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="DZ/WAaCD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739983809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8CpHx+WKFUlfd2T3HiZyY5o6gx+EtNdumMK4g0Lvcs=;
 b=i7Zqkz7HjknntSbvsD8dfYiKSWQe4LOSPMHk+8gABduD+xkzMcgmk8c46Si42+LpKuk2aN
 il8i1lYngRvtvvMa7LVlHYO2aUouo1RxDzDEZ9favAvcP3WEvll1qmCasXpYrtq4sm++U4
 21jPCn89dLGASw46m1G+u0w2sCJdeGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739983809;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8CpHx+WKFUlfd2T3HiZyY5o6gx+EtNdumMK4g0Lvcs=;
 b=DZ/WAaCD9mb33uXRbYEQ+B/O0GIcgZR1aB7rEVf0l756MMhdsih/B45A8lxw7anl1WDGpZ
 GXJ/4nxQMeRIEEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA1AA13806;
 Wed, 19 Feb 2025 16:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UykvJ8ALtmdGTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Feb 2025 16:50:08 +0000
Date: Wed, 19 Feb 2025 17:50:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: chunfuwen <chwen@redhat.com>
Message-ID: <20250219165006.GC2590174@pevik>
References: <bc3276b8-8383-4ef8-a4d7-a2a786662cbd@suse.com>
 <20250219064804.1313358-1-chwen@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250219064804.1313358-1-chwen@redhat.com>
X-Rspamd-Queue-Id: 6AFD0218F2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add test case to cover the setting resource
 limit64 for process
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
Cc: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi 
> +	if (!pid) {
> +		TEST(setrlimit_u64(RLIMIT_CPU, rlim));
> +		if (TST_RET == -1) {
> +			tst_res(TFAIL | TTERRNO,
> +				"setrlimit_u64(RLIMIT_CPU) failed");
> +			exit(1);
> +		}
> +
> +		alarm(20);
> +
> +		while (1)

FYI we have TST_CHECKPOINT_WAKE() and others, please see
"1.9 Fork() and Parent-child synchronization" in doc/old/C-Test-API.asciidoc
or online
https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#19-fork-and-parent-child-synchronization

(still not yet converted docs to sphinx)

Also worth to read if you have time (because people would put at least some usleep() instead of plain while(1);
https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests

Kind regards,
Petr

> +			;
> +	}
> +

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
