Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD423CCF9F0
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 08:22:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3445D3CA917
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 09:22:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B5013C9D1E
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 09:22:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8CFF02001DE
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 09:22:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BD86720289;
 Wed, 29 Oct 2025 08:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761726135;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxVtqQ/9m4qbSX3b5yBn5MUt9hEWHYQR/I82sN2a92k=;
 b=AROq+MzqxPoc3RjVWhR9bfN6KIM1MzUbOnQCZzWfvbgkBflE2+VB8X8Huhn69HO3uMhAwq
 l1dPCCpKH8rDstCBFGgr84LS3w0ZJdDQ/Vlfrw7/SATFV+c3t5tZBvITAUFHzaOAxkJx26
 TcIRd7fxb85mehn8uhobsic6zKrmT5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761726135;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxVtqQ/9m4qbSX3b5yBn5MUt9hEWHYQR/I82sN2a92k=;
 b=woNqOf3MmYM/LGSuqCV4MuV9Rl95WlF6U6seBwXiSH5SWRNiqrh4EhNsJX0UBW/3n9CXPF
 VoBffMojjWov5nAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761726134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxVtqQ/9m4qbSX3b5yBn5MUt9hEWHYQR/I82sN2a92k=;
 b=AjvEb8YbDvg1F8i/tBVETWLPv7JYs5JIdHFevbMdofuvEn5rk3ilY4EOUfJIVALao9sc1Z
 NjIG4u2b8184zAl1Gd94AoNa8OLXgdKote3L4KSh6Ahy2Qojv+mw8HPLjV1R0/oVhLKhFn
 aKdwi8FkWQNKDVnU+bu0mBoy8RXrVUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761726134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UxVtqQ/9m4qbSX3b5yBn5MUt9hEWHYQR/I82sN2a92k=;
 b=v50wfxOzojFtV84S3V+r5ue/Oe7Y4PUjTMDeCBAffps21mEODWtQ8B/a/aS/hO9Ex9v35G
 srtXjQBYs5u7tvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 545751396A;
 Wed, 29 Oct 2025 08:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YDS7ErbOAWlXPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Oct 2025 08:22:14 +0000
Date: Wed, 29 Oct 2025 09:22:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20251029082210.GB616441@pevik>
References: <20251027143544.3634170-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251027143544.3634170-1-anders.roxell@linaro.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCHv2] isofs: Add ISO9660 kernel config requirement
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
Cc: ltp@lists.linux.it, benjamin.copeland@linaro.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> The isofs test requires ISO9660 filesystem support to test mounting and
> accessing ISO images. Without CONFIG_ISO9660_FS enabled, the test fails
> with "unknown filesystem type 'iso9660'" errors during mount attempts,
> resulting in 140 failed test cases.

> Add the CONFIG_ISO9660_FS kernel configuration requirement to ensure the
> test properly skips with TCONF on systems without ISO9660 support,
> either built-in or as a module.

> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  testcases/kernel/fs/iso9660/isofs.sh | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
> index 088e062d67c6..3f1426c5ee1f 100755
> --- a/testcases/kernel/fs/iso9660/isofs.sh
> +++ b/testcases/kernel/fs/iso9660/isofs.sh
> @@ -11,6 +11,7 @@

>  TST_NEEDS_CMDS="mount umount"
>  TST_NEEDS_TMPDIR=1

> +TST_NEEDS_KCONFIGS="CONFIG_ISO9660_FS"

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
