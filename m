Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078D7CCF9F0
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 08:36:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BE3C3CA723
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 09:36:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C8273C9D1E
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 09:36:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D3274600124
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 09:36:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 63203229D0;
 Wed, 29 Oct 2025 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761726970;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xjuFnDgB+laCukMu3akMvIX/hZ3SOqOJmTCX509zRzg=;
 b=QHmU39JCY9dS6M45jWPvYeOl7YYKS39ClgSaH018Uv6jpXM/IlDmCQRtG7ktpRTsM5GpGF
 dkqhjpuR7ZHgl9EHBDrBlXS3OCHWzzWKKLv677gQuVBMdimagM9JfuQDQ9MTx0BenoFGb4
 3GhcgnkvOvgjg7N25uS7sA3es+/+e7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761726970;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xjuFnDgB+laCukMu3akMvIX/hZ3SOqOJmTCX509zRzg=;
 b=35NtgYYC07ZSiaepe9HRqdzcclB5B2/p6A2QFTUzbFjdpYql+zVRhPKLmqxXapGyyWnc5Y
 twChssf55zhs1HAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QHmU39JC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=35NtgYYC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761726970;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xjuFnDgB+laCukMu3akMvIX/hZ3SOqOJmTCX509zRzg=;
 b=QHmU39JCY9dS6M45jWPvYeOl7YYKS39ClgSaH018Uv6jpXM/IlDmCQRtG7ktpRTsM5GpGF
 dkqhjpuR7ZHgl9EHBDrBlXS3OCHWzzWKKLv677gQuVBMdimagM9JfuQDQ9MTx0BenoFGb4
 3GhcgnkvOvgjg7N25uS7sA3es+/+e7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761726970;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xjuFnDgB+laCukMu3akMvIX/hZ3SOqOJmTCX509zRzg=;
 b=35NtgYYC07ZSiaepe9HRqdzcclB5B2/p6A2QFTUzbFjdpYql+zVRhPKLmqxXapGyyWnc5Y
 twChssf55zhs1HAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32F2F1349D;
 Wed, 29 Oct 2025 08:36:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3/agCvrRAWmgSwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 29 Oct 2025 08:36:10 +0000
Date: Wed, 29 Oct 2025 09:36:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251029083608.GA622025@pevik>
References: <20251027150924.17679-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251027150924.17679-1-chrubis@suse.cz>
X-Rspamd-Queue-Id: 63203229D0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test: Fix FS kernel supported check
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

Hi all,

> In case that there is only single filesystem defined in
> tst_test.filesystems we format the device in the setup rather in the
> function that iterates over all filesystems. However we missed a check
> if a filesystem is supported in this shortcut, hence if mkfs for the
> filesystem was installed and kernel support was missing the test failed
> when it attempted to mount the filesystem.

> Tested-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reported-by: Anders Roxell <anders.roxell@linaro.org>
:)

> +++ b/lib/tst_test.c
> @@ -1530,6 +1530,10 @@ static void do_setup(int argc, char *argv[])
>  		tdev.fs_type = default_fs_type();

>  		if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
> +
> +			if (!tst_fs_is_supported(tdev.fs_type))
> +				tst_brk(TCONF, "The %s filesystem is not supported", tdev.fs_type);

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Thanks to both!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
