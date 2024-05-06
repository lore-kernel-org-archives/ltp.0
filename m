Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574B7C10F16
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 09:54:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C01433CBAC1
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 11:54:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA0DD3CB78D
 for <ltp@lists.linux.it>; Mon,  6 May 2024 11:54:37 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D7EF321C7CA
 for <ltp@lists.linux.it>; Mon,  6 May 2024 11:54:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4FC4E3814C;
 Mon,  6 May 2024 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714989273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=telE2HfJ8F+haZYHH1Xybvq09v7Ur38KVx8M4tqn8k4=;
 b=Litee8bhOuxsOYkTIg1qb4ULM2/05io/Ohz8m+hepJlp4/mJNJY+xF4zPrboWR4F0dzUm/
 RC8TeTwXzE3nENvwzlHEcU6xE6XPz8RuHhgnBDeRZ5fDFKckqUbqr1kPp13cEwdonAPMqw
 b0uhSUvlbKa5iJ/QTkPJNhtZZV2oOxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714989273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=telE2HfJ8F+haZYHH1Xybvq09v7Ur38KVx8M4tqn8k4=;
 b=uPJDQBK+8W5M7B7ggL3yf7iiAUtlONdR7ENRobdVFDF9SBLN9z97RoHqM/mjJjKYAt0Pcy
 /RUwgRd1EWUWdqCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GiOhw7Nu;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CoYYgzi6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714989272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=telE2HfJ8F+haZYHH1Xybvq09v7Ur38KVx8M4tqn8k4=;
 b=GiOhw7Nu37HErkMNYK9TZunmYpZhMa9a/y/C9rHGyR+4aNDzH9SULQPg87fMZvyu+tixki
 KPpifzfrtC8BuPN/GFLSImYxYu+cQ3AQSh2q9HDpF6fmwn8AXkjY+IFAesdvAkcM2tO7it
 u/1d8VTgnPzszWTGNznAmEom09PYmXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714989272;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=telE2HfJ8F+haZYHH1Xybvq09v7Ur38KVx8M4tqn8k4=;
 b=CoYYgzi6NF4ITLFugiRV8pLOxI50sOOrFkPfQZk/yzutgv/fq85Xz6T3l2WLU8kGS82AKa
 6vglC6GECFBvuuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F6A813A25;
 Mon,  6 May 2024 09:54:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HqtCDtioOGYCDgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 May 2024 09:54:32 +0000
Date: Mon, 6 May 2024 11:53:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <ZjioqEwx22mjFYux@yuki>
References: <20240428074457.2629906-2-lufei@uniontech.com>
 <20240506070336.2711930-1-lufei@uniontech.com>
 <20240506070336.2711930-2-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240506070336.2711930-2-lufei@uniontech.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4FC4E3814C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add case about arch_prctl syscall.
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
> +static void run(unsigned int index)
> +{
> +	FILE *fd;

Please do not call FILE * pointer fd, that is confusing since fd is
usually a file descriptor. FILE * pointer is usually just call f.

> +	char needed_flag[] = "cpuid_fault";

I would include the space before flag name just to be extra careful we
do not match anything that has this as a substring. E.g. if in the
future they add something that would be named "no_cpuid_fault" this
would still match strstr(line, "cpuid_fault") but not
strstr(line, " cpuid_fault"); Ideally we would check that there is a
space after the string, but we can't just do that with strstr() since
the flag may be actually last in the list. So the only posibility would
be using the pointer from strstr() and checking that the character after
the matched string is also a space.

> +	char *line = NULL;
> +	size_t len = 0;
> +	bool tag = 0;
> +
> +	fd = SAFE_FOPEN("/proc/cpuinfo", "r");
> +
> +	while (getline(&line, &len, fd) != -1) {
> +		if (strncmp(line, "flag", strlen("flag")) == 0 &&
                                      ^
				      why not just whole "flags" ?
> +				strstr(line, needed_flag) != NULL) {
> +			tag = 1;
> +			break;
> +		}
> +	}

This whole check for flag should be done in the test setup so that we do
not parse the /proc/cpuinfo on each test iteration (-i command line
option).

> +	if (!tag)
> +		tst_brk(TCONF, "CPU need %s flag.", needed_flag);

Why don't we check that the prctl() returns ENODEV when the flag is not
present. That is a valid testcase as well.

> +	// index == 0 for disable cpuid, 1 for enable cpuid.
> +	TST_EXP_PASS(arch_prctl_set(ARCH_SET_CPUID, index));
> +
> +	TEST(arch_prctl_get(ARCH_GET_CPUID));
> +
> +	if (TST_RET == index)
> +		tst_res(TPASS, "get cpuid succeed.");
> +	else
> +		tst_res(TFAIL, "get cpuid failed.");
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = 2,
> +	.min_kver = "4.12",
> +	.supported_archs = (const char *const []){"x86_64", "x86", NULL}
> +};
> +
> +#else /* HAVE_ASM_PRCTL_H */
> +TST_TEST_TCONF("missing <asm/prctl.h>");
> +#endif
> -- 
> 2.39.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
