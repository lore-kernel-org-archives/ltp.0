Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7673BC44520
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 15:32:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9C4A3E76A6
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 17:32:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67EC73E2CC9
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 17:31:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C8D901A001D9
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 17:31:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 452757A036;
 Mon, 20 Jul 2026 15:31:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34D4A779AA;
 Mon, 20 Jul 2026 15:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uUU4C1w/XmogDwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 20 Jul 2026 15:31:40 +0000
Date: Mon, 20 Jul 2026 17:31:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <al4_WWeLFMSvL0tS@yuki.lan>
References: <20260720-fix_cve-2026-46331_enoent-v3-0-9f216efdd661@suse.com>
 <20260720-fix_cve-2026-46331_enoent-v3-1-9f216efdd661@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260720-fix_cve-2026-46331_enoent-v3-1-9f216efdd661@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 452757A036
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_kconfig: add module mappings for
 ingress/matchall/pedit
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Map CONFIG_NET_SCH_INGRESS, CONFIG_NET_CLS_MATCHALL and CONFIG_NET_ACT_PEDIT
> to their kernel modules (sch_ingress, cls_matchall, act_pedit).
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  lib/tst_kconfig.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index 44eacc7c2989a5af3347b8f7ed16393fde0122a6..277ac606895046e072cf8f86076ecf7d79f9b1e6 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -162,6 +162,9 @@ static struct config_module_map {
>  	{"CONFIG_CAN_RAW", "can-raw"},
>  	{"CONFIG_CAN_BCM", "can-bcm"},
>  	{"CONFIG_IP_SCTP", "sctp"},
> +	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
> +	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
> +	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
>  	{}
>  };

This is still missing the additions to the CONFIG -> module map.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
