Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7EDCCFA1A
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 12:22:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2DC73CF650
	for <ltp@archiver.kernel.org>; Tue, 11 Nov 2025 13:22:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 364EA3CC113
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 13:22:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ADC9B6008C5
 for <ltp@lists.linux.it>; Tue, 11 Nov 2025 13:22:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A468D21D11;
 Tue, 11 Nov 2025 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762863758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kL45rIBQfONtsuNkvTKvafdg+rlSkjL7O/SX6VNHPGI=;
 b=ooosDqMq7X0jgvHjq1an50qxFyAU24iophW9FmYlOuqOCA0l/ggZA5Cxe2NUky4MZAlvL5
 Z1N8GPccHNq8qL5c0eFzvNX6D9lvr5d6a1Kia9VJRzNKXGaHcL+YOUV/A6G/jHVYojtU2E
 rJuMqgCSUPRVf6T6QOAIndUKrHY08UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762863758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kL45rIBQfONtsuNkvTKvafdg+rlSkjL7O/SX6VNHPGI=;
 b=5RCb1wXSccZRiYIa69j7Md9/UW/+taQKW1E7aL3kBdncntBjlFbdPYGpaky4hUbWp45mVs
 k664OoAFCf8qjoCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ooosDqMq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5RCb1wXS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762863758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kL45rIBQfONtsuNkvTKvafdg+rlSkjL7O/SX6VNHPGI=;
 b=ooosDqMq7X0jgvHjq1an50qxFyAU24iophW9FmYlOuqOCA0l/ggZA5Cxe2NUky4MZAlvL5
 Z1N8GPccHNq8qL5c0eFzvNX6D9lvr5d6a1Kia9VJRzNKXGaHcL+YOUV/A6G/jHVYojtU2E
 rJuMqgCSUPRVf6T6QOAIndUKrHY08UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762863758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kL45rIBQfONtsuNkvTKvafdg+rlSkjL7O/SX6VNHPGI=;
 b=5RCb1wXSccZRiYIa69j7Md9/UW/+taQKW1E7aL3kBdncntBjlFbdPYGpaky4hUbWp45mVs
 k664OoAFCf8qjoCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 907BC14957;
 Tue, 11 Nov 2025 12:22:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HOGSIo4qE2knHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Nov 2025 12:22:38 +0000
Date: Tue, 11 Nov 2025 13:22:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251111122237.GB50277@pevik>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
 <20251101012320.24972-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251101012320.24972-3-wegao@suse.com>
X-Rspamd-Queue-Id: A468D21D11
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,tst_format_device.sh:url];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] tst_format_device.sh: Add e2fsprogs
 package for CI test
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

Hi Wei,

> For alpine platform we should mount /dev/loop device before df check.
> Otherwise following error will be triggered

> runtest TINFO: * shell/tst_format_device.sh
> tst_format_device 1 TINFO: Running: tst_format_device.sh
> tst_format_device 1 TINFO: Tested kernel: Linux 0ba9f024d6b7 6.11.0-1018-azure #18~24.04.1-Ubuntu SMP Sat Jun 28 04:46:03 UTC 2025 x86_64 Linux
> tst_format_device 1 TINFO: Using /tmp/LTP_tst_format_device.XXXXOajpgN as tmpdir (UNKNOWN filesystem)
> tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> tst_format_device 1 TINFO: Formatting ext2 with opts='-b 1024 /dev/loop0 5m'
> tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
> tst_format_device 1 TPASS: device formatted
> df: /dev/loop0: can't find mount point
> tst_format_device 2 TFAIL: df /dev/loop0 | grep -q /dev failed unexpectedly
> tst_format_device 3 TINFO: AppArmor enabled, this may affect test results
> tst_format_device 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
> tst_format_device 3 TINFO: loaded AppArmor profiles: none

I see busybox df implementation require mounting (unlike coreutils
implementation).

nit: As this is clearly completely unrelated change (but most of the git commit
message is in the description) it would be clearer to have it as a separate
change (as a previous commit, before adding packages).
+ mention in the commit message it's due busybox.
The subject of commit with ci/* changes could have prefix 'ci' (it's due
tst_format_device.sh, but you modify our CI).

> ---
>  ci/alpine.sh                                | 1 +
>  ci/debian.sh                                | 1 +
>  ci/fedora.sh                                | 1 +
>  ci/tumbleweed.sh                            | 1 +
>  lib/newlib_tests/shell/tst_format_device.sh | 1 +
>  5 files changed, 5 insertions(+)

...
> diff --git a/lib/newlib_tests/shell/tst_format_device.sh b/lib/newlib_tests/shell/tst_format_device.sh
> index dbe4ea9e7..bd4aa2ed9 100755
> --- a/lib/newlib_tests/shell/tst_format_device.sh
> +++ b/lib/newlib_tests/shell/tst_format_device.sh
> @@ -3,6 +3,7 @@
>  # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>

>  TST_FORMAT_DEVICE=1
> +TST_MOUNT_DEVICE=1

nit: TST_MOUNT_DEVICE=1 implies TST_FORMAT_DEVICE=1 (not a mistake, but
TST_FORMAT_DEVICE=1 is not necessary).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
