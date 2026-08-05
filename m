Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F41C55174
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 15:46:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A37FB3E714E
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:46:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D9B63E4A27
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:46:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BF94510009B0
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:46:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD3F13DFC;
 Wed,  5 Aug 2026 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785944790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmlgkdEuLjbfQURPVpPCweLlVNA8XqT71vjVoNiq64w=;
 b=yyTpYcabW5W2CxvLLA9v9F7800OvVGJYaqUa1YiHguk0MLgkOxBCBP1hS2J+QudIxgrN5D
 sQL/AKzQDvSU7st3u1graVu2vkNZHj55jUt0UqGMLZex2zB79fmXKg2h34g5LJiqkVYPB3
 4SzmOe8hcL4HYmfVACKmbWA9S1sHSwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785944790;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmlgkdEuLjbfQURPVpPCweLlVNA8XqT71vjVoNiq64w=;
 b=iUI7Unv5QW+4gICiommmskq97U6vbV//JZdCstbAxnort6fxXneNzR1wl6LmUZzkAaccpV
 rFbbPqxtjNn2NTCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m7WlpEh3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8LE0kozk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785944785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmlgkdEuLjbfQURPVpPCweLlVNA8XqT71vjVoNiq64w=;
 b=m7WlpEh302RHLBxCBqT5A+fpmpCPwuVcCZ++jOo79UpDKJFk9xUoCgBXFbXd46QIbQeYBG
 46lJHJAV4WIHfHM2GzpUX7ZDpSAWoCv+S6tSpyCdhelpZdEkFYyigdmHZ+OBYX/vXdI0L3
 ERfxJrGF08EAqNEWz8EJZ7FxFprM29I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785944785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmlgkdEuLjbfQURPVpPCweLlVNA8XqT71vjVoNiq64w=;
 b=8LE0kozk+D7OyQ5NSm+k9kBVV9K55MyFBKW3tHOy5hjaqGDuzaMcD2hzNtparj2wT2uXa1
 dcsiCcjBT6L0mJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0DBF779C2;
 Wed,  5 Aug 2026 15:46:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KuTLKdFac2piOgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 15:46:25 +0000
Date: Wed, 5 Aug 2026 17:46:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260805154616.GA649402@pevik>
References: <20260805145213.3066-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260805145213.3066-1-always.starving0@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CD3F13DFC
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_TO(0.00)[gmail.com];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[runpwtests06.sh:url,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,runpwtests04.sh:url];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] power_management: rewrite runpwtests04.sh in C
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

Hi Jinseok Kim,

Patch does not apply:
error: patch failed: runtest/power_management_tests:1
error: runtest/power_management_tests: patch does not apply
error: patch failed: testcases/kernel/power_management/.gitignore:1
error: testcases/kernel/power_management/.gitignore: patch does not apply
Patch failed at 0001 power_management: rewrite runpwtests04.sh in C

=> please rebase and repost.

>  runpwtests06 runpwtests06.sh
> diff --git a/testcases/kernel/power_management/.gitignore b/testcases/kernel/power_management/.gitignore
> index 03f0c83e4..052696dc5 100644
> --- a/testcases/kernel/power_management/.gitignore
> +++ b/testcases/kernel/power_management/.gitignore
> @@ -1 +1,2 @@
> -high_freq_hwp_cap_cppc
> +/cpuidle01
> +/high_freq_hwp_cap_cppc
> diff --git a/testcases/kernel/power_management/cpuidle01.c b/testcases/kernel/power_management/cpuidle01.c
> new file mode 100644
> index 000000000..7e7b8d01f
> --- /dev/null
> +++ b/testcases/kernel/power_management/cpuidle01.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
Maybe add a note:

Based on a script written by Nageswara R Sastry <nasastry@in.ibm.com>
Copyright (c) International Business Machines  Corp., 2001

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
