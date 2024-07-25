Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1230AC3DA5D
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 15:56:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61B373D1CB5
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 17:56:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 187423CF6B9
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 17:55:55 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 18398600879
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 17:55:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3E2C81F7F1;
 Thu, 25 Jul 2024 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721922953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0iDS2FCxd82SJNEgmE/y5Q2xE7DP4vRL9pOlvZFpDoM=;
 b=pXc87N2yM7Pao07IGTWVdnyRTBH6L8ZIKNmh+e2QqLop150ei8inz9kOpWsZp49cK8Ypo2
 INP4l53VfAAO6g3F7QfbBs1Wq9Xa3h3ZFsWBlHwtvDXftgckN69aEhF7Ipn2AX+0dldvhg
 PBzLqeWOY7oa9DvLVOB260KdKa5GhqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721922953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0iDS2FCxd82SJNEgmE/y5Q2xE7DP4vRL9pOlvZFpDoM=;
 b=9CO/N+quWKDsH5563D0cGz12LA8y7IL7/cJZvL1pkKAShzyH2zt3E7OEKdjMNRbu1Y4ghx
 h3vxHkIhkPsAwlDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pXc87N2y;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="9CO/N+qu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721922953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0iDS2FCxd82SJNEgmE/y5Q2xE7DP4vRL9pOlvZFpDoM=;
 b=pXc87N2yM7Pao07IGTWVdnyRTBH6L8ZIKNmh+e2QqLop150ei8inz9kOpWsZp49cK8Ypo2
 INP4l53VfAAO6g3F7QfbBs1Wq9Xa3h3ZFsWBlHwtvDXftgckN69aEhF7Ipn2AX+0dldvhg
 PBzLqeWOY7oa9DvLVOB260KdKa5GhqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721922953;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0iDS2FCxd82SJNEgmE/y5Q2xE7DP4vRL9pOlvZFpDoM=;
 b=9CO/N+quWKDsH5563D0cGz12LA8y7IL7/cJZvL1pkKAShzyH2zt3E7OEKdjMNRbu1Y4ghx
 h3vxHkIhkPsAwlDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DA3F1368A;
 Thu, 25 Jul 2024 15:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 61h2Col1omauMAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 25 Jul 2024 15:55:53 +0000
Date: Thu, 25 Jul 2024 17:55:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZqJ1bKQ4_0GG3r_7@yuki>
References: <20240723-mseal-v2-0-5aa872d611bc@suse.com>
 <20240723-mseal-v2-2-5aa872d611bc@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240723-mseal-v2-2-5aa872d611bc@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3E2C81F7F1
X-Spamd-Result: default: False [-3.81 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add mseal01 test
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
> +static void child(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	mem_addr = SAFE_MMAP(NULL, mem_size,
> +		tc->prot,
> +		MAP_ANONYMOUS | MAP_PRIVATE,
> +		-1, 0);
> +
> +	tst_res(TINFO, "Testing %s", tc->message);
> +
> +	TST_EXP_PASS(sys_mseal(mem_addr + mem_offset, mem_alignment));
> +
> +	tc->func_test();
> +}
> +
> +static void run(unsigned int n)
> +{
> +	/* the reason why we spawn a child is that mseal() will
> +	 * protect VMA until process will call _exit()
> +	 */
> +	if (!SAFE_FORK()) {
> +		child(n);
> +		_exit(0);
> +	}
> +
> +	tst_reap_children();
> +
> +	if (mem_addr != MAP_FAILED)
> +		SAFE_MUNMAP(mem_addr, mem_size);

The memory is mapped in the child, it's hence not propagated to the
parent. With fork() only changes done in parent before the fork happens
are visible in child as well, since the memory is CoW.

> +}
> +
> +static void setup(void)
> +{
> +	mem_alignment = getpagesize();
> +	mem_size = mem_alignment * MEMPAGES;
> +	mem_offset = mem_alignment * MEMSEAL;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (mem_addr != MAP_FAILED)
> +		SAFE_MUNMAP(mem_addr, mem_size);

Here as well, this is useless, since the memory was allocated in child,
and freed automatically when the child exits.


The rest look fine.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
