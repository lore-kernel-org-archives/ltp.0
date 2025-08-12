Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E895C87FCB
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 11:17:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA96E3CB324
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 13:17:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF3293C06B5
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:16:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6528E600116
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:16:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7BE3421B1D;
 Tue, 12 Aug 2025 11:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754997403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/E6TxhqU6tX8BAPv4fNvyIX67t5tnq3PVhYQDTQfBw=;
 b=kVw/1g0TCs6waKWsXw1hweFFdDiQkorthV3M6/jUWjr1us0U7L1t+F54NAzOAMkce7fDK1
 4Ze/HSaAMFxPSCBlkze3JhOdAVVHJVNGWOZj9UMhMZjRYagOkKeXNacy8xjaSIpGX8VOn5
 eyp6f/1MSncZ+t4O+b1LLnOO/q5/Hmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754997403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/E6TxhqU6tX8BAPv4fNvyIX67t5tnq3PVhYQDTQfBw=;
 b=aM1nv2GxeOLeXlxqdUMw7pk6ATQaQ61kqjhZpsZudCHPb4uYG+a+RTRCiymkyXGw6VpueB
 kpSq/c5usjwdeXBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="NXs9PhR/";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fEatPltf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754997401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/E6TxhqU6tX8BAPv4fNvyIX67t5tnq3PVhYQDTQfBw=;
 b=NXs9PhR/6wzEvcha1mSlouMJ1KHzulfq5HMG/xdHrdTNFD9drXnZIXWms3zdZNcW6ZZWIH
 Z+ZPXcbjj0rT24JQCj6mhifYy6ABE9Dbu8UkNqWja4bhPVxtg3NyFZFhhrurKStKhvfukE
 32BuHgOrDZdr75jiH4iqnau3TBN2BWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754997401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2/E6TxhqU6tX8BAPv4fNvyIX67t5tnq3PVhYQDTQfBw=;
 b=fEatPltf4Zf3WbN+sa6XWpZrslBLhkT7oHiQgqL6A/cIqffgnOwLn9YfQLgCUU/cmmmwvk
 /Gfl75TJavYzaIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59CA2136C7;
 Tue, 12 Aug 2025 11:16:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E+EtFZkim2h3FwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 12 Aug 2025 11:16:41 +0000
Date: Tue, 12 Aug 2025 13:17:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aJsiyPqTOOnrhFnY@yuki.lan>
References: <20190102131913.GA26215@rei.lan>
 <20250806074405.14890-1-liwang@redhat.com>
 <aJMf-6DEu-9NzLAJ@yuki.lan>
 <CAEemH2dFjv2Mn-CfM6HEZxT7BR45PAHuwQcMa6dckxemf0tvzg@mail.gmail.com>
 <aJn8ObtEEaAf1H-a@yuki.lan>
 <CAEemH2ePTzTRQ_Urh0LK33hNFFkxz26CbiW-mX7RjZfyQpaOpA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ePTzTRQ_Urh0LK33hNFFkxz26CbiW-mX7RjZfyQpaOpA@mail.gmail.com>
X-Rspamd-Queue-Id: 7BE3421B1D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_umount: Retry open() after umount to handle
 delayed device release
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
Cc: rafael.tinoco@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> --- a/lib/tst_mkfs.c
> +++ b/lib/tst_mkfs.c
> @@ -107,6 +107,13 @@ void tst_mkfs_(const char *file, const int lineno,
> void (cleanup_fn)(void),
>                         "%s not found in $PATH", mkfs);
>         break;
>         default:
> +               tst_resm_(file, lineno, TINFO,
> +                       "Check if mkfs failed with the (loop) device busy. "
> +                       "Background probing (e.g., udisks2) can cause this.
> \n"
> +                       "Consider temporarily stopping udisks2 during the
> test:\n"
> +                       "  systemctl stop udisks2.service\n"
> +                       "and restart afterward:\n"
> +                       "  systemctl start udisks2.service");

I wouldn't include the systemctl commands in the message, anybody who is
using LTP to test the system should know how to start and stop system
daemons. Let's keep the message short and to the point.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
