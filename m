Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB9CC3DA59
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 17:15:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F42273D1ABB
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 19:15:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67C3E3C0123
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 19:15:33 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 18F72600769
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 19:15:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A102121B87;
 Tue, 16 Jul 2024 17:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721150129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zD1LIE+46KJTOCnmOyHZRgt4WsA6rLRX+g1FWDiVZIo=;
 b=0jIOEkyjUlTLMDHndMHLJuiKXkBrx1okDrG30yA1oGsces4D9D4SRVeKYK8ziMBwQyzaEx
 UQZqzJOXMIFEov8INvNh3w5/1rbSxaGSyLj30T58OKhkBGFIxprtwUVYlsvSr1GNy85NQq
 3Y/vBtXgj//as+N62wkiyq1UvoHMPSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721150129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zD1LIE+46KJTOCnmOyHZRgt4WsA6rLRX+g1FWDiVZIo=;
 b=FnUW1TJOcIqZk92O9iJm6mHisYZxPd7YgWPgNv+7l0PJ8bwPSAYsrVvpME/llqMiPnYtvk
 Vj4io+FEYSPqkUCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0jIOEkyj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FnUW1TJO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721150129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zD1LIE+46KJTOCnmOyHZRgt4WsA6rLRX+g1FWDiVZIo=;
 b=0jIOEkyjUlTLMDHndMHLJuiKXkBrx1okDrG30yA1oGsces4D9D4SRVeKYK8ziMBwQyzaEx
 UQZqzJOXMIFEov8INvNh3w5/1rbSxaGSyLj30T58OKhkBGFIxprtwUVYlsvSr1GNy85NQq
 3Y/vBtXgj//as+N62wkiyq1UvoHMPSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721150129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zD1LIE+46KJTOCnmOyHZRgt4WsA6rLRX+g1FWDiVZIo=;
 b=FnUW1TJOcIqZk92O9iJm6mHisYZxPd7YgWPgNv+7l0PJ8bwPSAYsrVvpME/llqMiPnYtvk
 Vj4io+FEYSPqkUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AD6213795;
 Tue, 16 Jul 2024 17:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rGlFHLGqlmYkMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Jul 2024 17:15:29 +0000
Date: Tue, 16 Jul 2024 19:15:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240716171520.GB549165@pevik>
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-7-c7b0e9edf9b0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240711-landlock-v3-7-c7b0e9edf9b0@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A102121B87
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 07/11] Add landlock03 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Li,

...
> +static struct tcase {
> +	int *fd;
> +	uint32_t flags;
> +	int exp_errno;
> +	char *msg;
> +} tcases[] = {
> +	{&ruleset_fd, -1, EINVAL, "Invalid flags"},
> +	{&ruleset_invalid, 0, EBADF, "Invalid file descriptor"},
> +	{&file_fd, 0, EBADFD, "Not a ruleset file descriptor"},
> +	{&ruleset_fd, 0, EPERM, "File descriptor doesn't have CAP_SYS_ADMIN"},
> +	{&ruleset_fd, 0, E2BIG, "Maximum number of stacked rulesets is reached"},

I was going to merge this, but the last E2BIG does not work with -i2:

# ./landlock03 -i2
tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.6.15-amd64'
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:1806: TINFO: LTP version: 20240524-99-gf651e2dd5
tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
landlock_common.h:30: TINFO: Landlock ABI v3
landlock03.c:70: TPASS: Invalid flags : EINVAL (22)
landlock03.c:70: TPASS: Invalid file descriptor : EBADF (9)
landlock03.c:70: TPASS: Not a ruleset file descriptor : EBADFD (77)
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
landlock03.c:70: TPASS: File descriptor doesn't have CAP_SYS_ADMIN : EPERM (1)
tst_capability.c:41: TINFO: Permitting CAP_SYS_ADMIN(21)
landlock03.c:70: TPASS: Maximum number of stacked rulesets is reached : E2BIG (7)
landlock03.c:70: TPASS: Invalid flags : EINVAL (22)
landlock03.c:70: TPASS: Invalid file descriptor : EBADF (9)
landlock03.c:70: TPASS: Not a ruleset file descriptor : EBADFD (77)
tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
landlock03.c:70: TPASS: File descriptor doesn't have CAP_SYS_ADMIN : EPERM (1)
tst_capability.c:41: TINFO: Permitting CAP_SYS_ADMIN(21)
landlock03.c:63: TFAIL: tst_syscall(__NR_landlock_restrict_self, *tc->fd, tc->flags) failed: E2BIG (7)

> +};
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	if (tc->exp_errno == EPERM)
> +		tst_cap_action(&dropadmin);
> +
> +	if (tc->exp_errno == E2BIG) {
> +		for (int i = 0; i < MAX_STACKED_RULESETS; i++) {
> +			TST_EXP_PASS_SILENT(tst_syscall(__NR_landlock_restrict_self,
> +				*tc->fd, tc->flags));

I suppose any later call for E2BIG will fail, because we reached maximum of the
rulests, right? (That's why there is below TST_EXP_FAIL). Can we somehow undo
landlock rulestes?

It looks to me it's not possible:
https://docs.kernel.org/userspace-api/landlock.html#ruleset-layers
man page does not mention it either:
https://man7.org/linux/man-pages/man2/landlock_restrict_self.2.html
https://man7.org/linux/man-pages/man2/landlock_create_ruleset.2.html

Tomorrow I'll try to have look into the sources, but I guess we will need to
skip this last test for other iterations, right?

> +			if (TST_RET == -1)
> +				return;
> +		}
> +	}
> +
> +	TST_EXP_FAIL(tst_syscall(__NR_landlock_restrict_self, *tc->fd, tc->flags),
> +		tc->exp_errno,
> +		"%s", tc->msg);

Kind regards,
Petr
> +
> +	if (tc->exp_errno == EPERM)
> +		tst_cap_action(&needadmin);
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
