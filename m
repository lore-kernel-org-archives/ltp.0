Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B34EC3DA61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 22:57:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 636073D1D83
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 00:57:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46FE23D1BF9
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 00:57:02 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 51BF01400B7C
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 00:57:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1A3B1F7C0;
 Mon, 29 Jul 2024 22:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722293821;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7+pHXGCII3xgZhZ1r0hAOzFiZ95sA91Pl5z1SCKLQA=;
 b=Dq+h57MnMkQPWJ6ZCXT7nKKq1YGTtJHMH2ndJTai29GPhD96JwDg+O7/f4DPHHkw+bgC3o
 u/b+j9kpPhD0QK54ZgZH5MCBnVnADUrrUo5nCfUhVTuwU3MFSne6Cvdwzdv+vbavjvyisE
 I81uimCjmHaJxA3PsjR5+TOZlGEyIfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722293821;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7+pHXGCII3xgZhZ1r0hAOzFiZ95sA91Pl5z1SCKLQA=;
 b=RK3oGHyGS0q4oC8TI0NmxNFIZgQuWZfVTP7mXMlz7ghDk+gQORHNTL1gHqy5AjqUVAGJ9J
 zI8jgUNzUP2e//Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HUJCb+Ls;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vEb+S8Cd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722293820;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7+pHXGCII3xgZhZ1r0hAOzFiZ95sA91Pl5z1SCKLQA=;
 b=HUJCb+LsxV2tWkXxmJrTwfVBXQOKTPDLNz+uW5Hf/CFNbzO2nVVpw9qaML/QiHUpBbag2h
 kgd0M1Cbyls1s5/QJMYXHO8KwlGqOYfDBMC8Td86MBB7gclYxca6x9BW60myrThIHauMm3
 Z2RiZUwbqbXaPpZ/3IY+0xqoNwELF2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722293820;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m7+pHXGCII3xgZhZ1r0hAOzFiZ95sA91Pl5z1SCKLQA=;
 b=vEb+S8Cd9EBcxMGQ/w20Wmv6nmNJYCWEYCenLy6W+rAKKN2BK0dW3z+s+qfGd9oDNbQDRW
 MXm7iADbv8mEB2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C71F6138A7;
 Mon, 29 Jul 2024 22:57:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VSwhLzweqGYrbgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 22:57:00 +0000
Date: Tue, 30 Jul 2024 00:57:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20240729225700.GA1311523@pevik>
References: <ZpfOqJaIO5mr__CW@rei>
 <20240718065532.20188-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240718065532.20188-1-maxj.fnst@fujitsu.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: F1A3B1F7C0
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcpu: Add testcase for EFAULT
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

Hi Ma, Cyril,

...
> +static void run(void)
> +{
> +	unsigned int cpu_id, node_id = 0;
> +
> +	TST_EXP_FAIL(getcpu(tst_get_bad_addr(NULL), &node_id), EFAULT);
I'm not sure why, but I get SIGSEGV due tst_get_bad_addr(NULL) on various
kernels (SLES 5.14.21, Tumbleweed 6.5.1, 6.10, Debian 6.9, ...).

But the test works on SLES 4.4.180.

Kind regards,
Petr

> +	TST_EXP_FAIL(getcpu(&cpu_id, tst_get_bad_addr(NULL)), EFAULT);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
