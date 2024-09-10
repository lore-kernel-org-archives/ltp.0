Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A61EDE99A
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 15:49:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13BD53C1BAF
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 17:49:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE5823C021B
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 17:49:35 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73CF71A007E9
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 17:49:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C9E53219C5;
 Tue, 10 Sep 2024 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725983373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yb7qXveP+dIHO/9fi7xJ/+Zy7ZkPXSWZKvepTxhi7Ac=;
 b=LlJRGmFR8Vv/87e1ua7cSl0UW2RLxa8TxduQBpXJr+/71uxuFaddzeajog297cw3HR2vcp
 nGPdRgXc4N5T3OIt+4BVzFaJ9oyOkrwjOE8C1V1LWWWknVvVE0yo71uZDBaM0Lki5gId9W
 /WOnAtoMrMmQvOSZ1lXhkZIJdDpL7xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725983373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yb7qXveP+dIHO/9fi7xJ/+Zy7ZkPXSWZKvepTxhi7Ac=;
 b=JqcRqVim4cI9tTLWw7JJi/a0gt145J6FRVmgO7Y29a4hUiED3mGh89sim0Uv/l42YvT4Sl
 QsaoF6Psvvc9kkAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MkCYUq84;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aWrZzier
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725983372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yb7qXveP+dIHO/9fi7xJ/+Zy7ZkPXSWZKvepTxhi7Ac=;
 b=MkCYUq84Sta/YUGiiAgrPlbhhanwP+YLwAZPLS1TZYGZykW8NW106e85LxGqjIiiPJiXFf
 1GQLQXIXSWgScQMfJPp5peiUm+m8xtOvbqNFS5JVF4/c+O3wcvnX+9c7uoJZYW08wCdyGl
 ju8/KKHq0r/OKIEIx1NgVkxBTcSwYf4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725983372;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yb7qXveP+dIHO/9fi7xJ/+Zy7ZkPXSWZKvepTxhi7Ac=;
 b=aWrZzier0YpMQ24zXSz939fY6M8AfB46qTodfYapofHpEHAqsfQ2dud0ZHQ3tN//rLvv1v
 6bl43W+/z2vfdKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A82FA13A3A;
 Tue, 10 Sep 2024 15:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pjFcJoxq4GZUSwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 10 Sep 2024 15:49:32 +0000
Date: Tue, 10 Sep 2024 17:48:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZuBqSjIK4z25dEfD@yuki.lan>
References: <20240902-fcntl4_refactoring-v4-0-4446517da427@suse.com>
 <20240902-fcntl4_refactoring-v4-2-4446517da427@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240902-fcntl4_refactoring-v4-2-4446517da427@suse.com>
X-Rspamd-Queue-Id: C9E53219C5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] Rewrite fcnt14 test
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
Just minor thing the subject has 'fcnt14' instead of 'fcntl14'.

> ---
>  runtest/syscalls                          |    4 +-
>  testcases/kernel/syscalls/fcntl/fcntl14.c | 1253 +++++------------------------
>  2 files changed, 211 insertions(+), 1046 deletions(-)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a9fc8c432..1e4c41d17 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -312,8 +312,8 @@ fcntl12 fcntl12
>  fcntl12_64 fcntl12_64
>  fcntl13 fcntl13
>  fcntl13_64 fcntl13_64
> -fcntl14 fcntl14
> -fcntl14_64 fcntl14_64
> +fcntl14_01 fcntl14
> +fcntl14_01_64 fcntl14_64

We should get rid of the 01 if there is only single variant now.

The rest looks fine.

With these fixed: Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
