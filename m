Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7550C25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 20:24:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 015973D09CB
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 22:24:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33D783CFFBF
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 22:24:38 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3AAF91400F53
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 22:24:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 74B721F83B;
 Wed,  5 Jun 2024 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717619076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1ML5MQpX73lMoR4hr7U5vF2lFDX051leEa4VrkI/P4=;
 b=gNjoJbXZ/UIN+U3776t1DQtHyZby2A+cqJ3balpk009FfYjW9nNOXY7eTFwO3MxXXf5CR4
 w59kHH5ZSEiSA09NJl5W7VYGOD3dkLXJvkNrkS/vb6hRYTM8D/Kz4gpvfxN606sCwjDUrl
 2iNFwsAYpqYVQohTGaRP172A4+QS7hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717619076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1ML5MQpX73lMoR4hr7U5vF2lFDX051leEa4VrkI/P4=;
 b=l7REdBnGentA3yKlnIZgr6zMo1me1kW/fiH6+Qs8LDe18ACqbXtaCcvvE/gfn/QCLDf7pH
 LmnZCRPO9ZeaBnBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gNjoJbXZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=l7REdBnG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717619076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1ML5MQpX73lMoR4hr7U5vF2lFDX051leEa4VrkI/P4=;
 b=gNjoJbXZ/UIN+U3776t1DQtHyZby2A+cqJ3balpk009FfYjW9nNOXY7eTFwO3MxXXf5CR4
 w59kHH5ZSEiSA09NJl5W7VYGOD3dkLXJvkNrkS/vb6hRYTM8D/Kz4gpvfxN606sCwjDUrl
 2iNFwsAYpqYVQohTGaRP172A4+QS7hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717619076;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1ML5MQpX73lMoR4hr7U5vF2lFDX051leEa4VrkI/P4=;
 b=l7REdBnGentA3yKlnIZgr6zMo1me1kW/fiH6+Qs8LDe18ACqbXtaCcvvE/gfn/QCLDf7pH
 LmnZCRPO9ZeaBnBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3513413A24;
 Wed,  5 Jun 2024 20:24:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eHm2CYTJYGZEIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jun 2024 20:24:36 +0000
Date: Wed, 5 Jun 2024 22:24:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240605202434.GA452540@pevik>
References: <20240527-shutdown-v1-0-1feffca5e3df@suse.com>
 <20240527-shutdown-v1-1-1feffca5e3df@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240527-shutdown-v1-1-1feffca5e3df@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 74B721F83B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Add shutdown01 test
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

Hi Andrea,

...
> diff --git a/testcases/kernel/syscalls/shutdown/shutdown01.c b/testcases/kernel/syscalls/shutdown/shutdown01.c
> new file mode 100644
> index 000000000..b68b14ae8
> --- /dev/null
> +++ b/testcases/kernel/syscalls/shutdown/shutdown01.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies the following shutdown() functionalities:
nit: here needs to be blank line to get list formatting.

> + * * SHUT_RD should enable send() ops but disable recv() ops
> + * * SHUT_WR should enable recv() ops but disable send() ops
> + * * SHUT_RDWR should disable both recv() and send() ops
> + */
...
> +static void test_shutdown_recv(void)
> +{
> +	int client_sock;
> +	char buff[MSGSIZE] = {0};
Wouldn't it be better to send some data?
Or is it not important, we use guarded buffers?

> +
> +	client_sock = start_test();
> +
> +	tst_res(TINFO, "Testing SHUT_RD flag");
> +
> +	TST_EXP_PASS(shutdown(client_sock, SHUT_RD));
> +	TST_EXP_EQ_LI(recv(client_sock, buff, MSGSIZE, 0), 0);
Interesting, I would expect failure ("If how is SHUT_RD, further receptions will
be disallowed.")

And maybe use SAFE_RECV()?

> +	TST_EXP_EQ_LI(send(client_sock, buff, MSGSIZE, 0), MSGSIZE);
And SAFE_SEND() here?
> +
> +	SAFE_CLOSE(client_sock);
> +	TST_CHECKPOINT_WAKE(0);
> +}

nit: I would also use struct tcase and .tcnt, because all 3 tests are nearly
identical.

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
