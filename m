Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C234DC5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 12:40:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30AB63CA33C
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 14:40:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D9033CA11B
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:40:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE77B60103C
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 14:40:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 37FA934B7F;
 Thu,  5 Jun 2025 12:40:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24E98137FE;
 Thu,  5 Jun 2025 12:40:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sODyBy6QQWheIQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 05 Jun 2025 12:40:14 +0000
Date: Thu, 5 Jun 2025 14:40:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aEGQTfxMGWZ2pSHJ@yuki.lan>
References: <20250515015855.68510-1-liwang@redhat.com>
 <20250515015855.68510-3-liwang@redhat.com>
 <aEA0LYNKcPPeS0Uw@yuki.lan>
 <CAEemH2erR_5qOk-ixhMMd2L0=RLH=RvDdSBdeiWWPXNtE60_QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2erR_5qOk-ixhMMd2L0=RLH=RvDdSBdeiWWPXNtE60_QQ@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 37FA934B7F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] lib: moves test infrastructure states into
 a shared context structure
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
> I guess you were hoping:
> 
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -152,7 +152,7 @@ static void setup_ipc(void)
>         if (tst_test->needs_checkpoints) {
>                 tst_futexes = ipc->futexes;
> 
> -               size_t futexes_offset = (char *)ipc->futexes - (char *)ipc;
> +               size_t futexes_offset = offsetof(struct ipc_region,
> futexes);
>                 tst_max_futexes = (size - futexes_offset) / sizeof(futex_t);
>         }
> 
> @@ -208,7 +208,7 @@ void tst_reinit(void)
>         results = &ipc->results;
> 
>         tst_futexes = ipc->futexes;
> -       size_t futexes_offset = (char *)ipc->futexes - (char *)ipc;
> +       size_t futexes_offset = offsetof(struct ipc_region, futexes);
>         tst_max_futexes = (size - futexes_offset) / sizeof(futex_t);
> 
>         if (context->tdebug)

That's exactly what I've been asking for, to use offsetof() to calculate
the size of the structure we need to substract from the size.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
