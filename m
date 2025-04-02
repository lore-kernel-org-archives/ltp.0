Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E83C36014
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 10:29:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 166CC3CB0AE
	for <ltp@archiver.kernel.org>; Wed,  2 Apr 2025 12:29:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01A103CB083
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 12:29:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 34FE91400C5A
 for <ltp@lists.linux.it>; Wed,  2 Apr 2025 12:29:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F2C221190;
 Wed,  2 Apr 2025 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743589762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0XSj7i/g/Fus/py/WHUAib/+zR1E7NtFIEC6NZbPSI=;
 b=0czKlkiYuezwBMvP9BaYqx/feQi4eKiy38blsa8bCYN+7dYkiLaQXxbqUl7bbLKIDuyQ8T
 CnIGMDV7CVsv4s8GxZTg8EgT+cwE75bgYvWzMrtTFulO34dCFLgOZoFRd8TtyERgE/WV0l
 MosawFhN8PZ99ofKYNjfzjh4f8cJ1UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743589762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0XSj7i/g/Fus/py/WHUAib/+zR1E7NtFIEC6NZbPSI=;
 b=ThHLdqtkt0u9ws+GFQuQ2mQDKj6Skok/oUvV6l5KEidEjKEPIQ0HezPseD43zMAqEO3yS2
 bHa1co8yjhjTzKCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743589762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0XSj7i/g/Fus/py/WHUAib/+zR1E7NtFIEC6NZbPSI=;
 b=0czKlkiYuezwBMvP9BaYqx/feQi4eKiy38blsa8bCYN+7dYkiLaQXxbqUl7bbLKIDuyQ8T
 CnIGMDV7CVsv4s8GxZTg8EgT+cwE75bgYvWzMrtTFulO34dCFLgOZoFRd8TtyERgE/WV0l
 MosawFhN8PZ99ofKYNjfzjh4f8cJ1UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743589762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j0XSj7i/g/Fus/py/WHUAib/+zR1E7NtFIEC6NZbPSI=;
 b=ThHLdqtkt0u9ws+GFQuQ2mQDKj6Skok/oUvV6l5KEidEjKEPIQ0HezPseD43zMAqEO3yS2
 bHa1co8yjhjTzKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 512AC137D4;
 Wed,  2 Apr 2025 10:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z+qJEoIR7WcHWQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 02 Apr 2025 10:29:22 +0000
Date: Wed, 2 Apr 2025 12:29:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Z-0Rl4jlbplAQQR_@yuki.lan>
References: <20250301063134.14515-1-wegao@suse.com>
 <20250401075642.16656-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250401075642.16656-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, linux.it:url]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] fcntl40.c: Test fcntl using F_CREATED_QUERY
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
> +static void verify_fcntl(void)
> +{
> +	int fd;
> +
> +	fd = SAFE_OPEN("/dev/null", O_RDONLY | O_CLOEXEC);
> +
> +	/* We didn't create "/dev/null". */
> +	TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 0);
> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPEN(TEST_NAME, O_CREAT | O_RDONLY | O_CLOEXEC, 0600);
> +
> +	TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 1);
> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPEN(TEST_NAME, O_RDONLY | O_CLOEXEC);
> +
> +	/* We're opening it again, so no positive creation check. */
> +	TST_EXP_EQ_LI(fcntl(fd, F_CREATED_QUERY, 0), 0);
> +	SAFE_CLOSE(fd);
> +	SAFE_UNLINK(TEST_NAME);
> +
> +	/* tst_res(TPASS, "fcntl F_CREATED_QUERY check pass"); */

Why is this line here? It's not even proper comment, just commented out
code. It should have been removed.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_fcntl,
> +	.needs_tmpdir = 1,
> +	.min_kver = "6.12",
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "d0fe8920cbe4"},

This points to the kernel commit that added the test. Commit tags are
only for kernel commits that fixed a kernel bug, not for commits where
functionality was added.

> +		{}
> +	}
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
