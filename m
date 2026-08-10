Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A49C5AD7B
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:06:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0276B3D0342
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 20:06:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F22E3CE2BE
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 20:06:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 38C081A002E2
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 20:06:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A99880F84;
 Mon, 10 Aug 2026 18:06:21 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74198779B6;
 Mon, 10 Aug 2026 18:06:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TsibGh0TemoKIwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 18:06:21 +0000
Date: Mon, 10 Aug 2026 20:06:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260810180620.GF1049677@pevik>
References: <20260810-sctphantom-v1-0-f8e9ee72a648@suse.com>
 <20260810-sctphantom-v1-2-f8e9ee72a648@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810-sctphantom-v1-2-f8e9ee72a648@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8A99880F84
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cve/sctphantom: Add reproducer for
 CVE-2026-64564
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Add a reproducer for CVE-2026-64564, a use-after-free in the SCTP
> Dynamic Address Reconfiguration (RFC 5061) DEL-IP processing.

> This vulnerability was fixed upstream by commit 9b2854f86f0b ("sctp:
> don't free the ASCONF's own transport in DEL-IP processing").

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Link: https://matrix.tencent.com/en/2026/08/06/sctphantom-CVE-2026-64564

Nice reproducer, full of magic. Generally LGTM, few notes bellow?
Acked-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

> +static void setup(void)
> +{
> +	int fd;
> +	const struct tst_path_val sysctls[] = {
> +		{"/proc/sys/net/sctp/addip_enable", "1", TST_SR_TCONF},
> +		{"/proc/sys/net/sctp/addip_noauth_enable", "1", TST_SR_TCONF},
> +		{}
> +	};
Can't this be part of .save_restore in struct tst_test?

> +	const struct tst_path_val *sysctl;
> +
> +	tst_modprobe("sctp", NULL);
...

> +
> +/*
> + * The freed transport is released by an RCU callback; once it is gone,
> + * reading the association status dereferences the stale primary_path,
> + * which KASAN reports as a use-after-free.
> + */
> +static void probe_uaf(void)
> +{
> +	uint8_t buf[512];
> +	long delay = 1;
> +	int i;
> +
> +	tst_res(TINFO, "probing the stale primary path via SCTP_STATUS");
> +
> +	for (i = 0; i < 12; i++) {
> +		socklen_t len = sizeof(buf);
> +
> +		TEST(getsockopt(cli_fd, SOL_SCTP, SCTP_STATUS, buf, &len));
What is the point of using TEST() macro here. Why not run getsockopt() directly?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
