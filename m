Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A15CC4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 14:22:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 709E33CFCE6
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 16:22:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6C023CFC1A
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:22:05 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0B83020B64E
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:22:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0FC045CC01;
 Thu, 18 Apr 2024 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713450124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4L5UOP5m8+suBNlPwnZWH6EuSDU8XzLTAtaYMVZRkS8=;
 b=NJPwdW3v5eE0NxEmj6q1FKqaeuPzypgQBfQo0FIRpNjdDI82HOa+YXm6KAgn/FWbTXSuF3
 YD4YdH1z12ut7667XoQ/3es0nOkVIHiH12iQb06FvAVMyeeFs3IuU7Nvhh3kxu8NWommL6
 wJDchmjJjUHdAbD8L1v6idio7zlARts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713450124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4L5UOP5m8+suBNlPwnZWH6EuSDU8XzLTAtaYMVZRkS8=;
 b=SfviXWGh2NFjianWcIN6vZg4HIgRbU1/r+q3EY6uatsvXYSGpjRGm448FF46PqS7RqHa4n
 rCWDACFbbvz4mrDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713450124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4L5UOP5m8+suBNlPwnZWH6EuSDU8XzLTAtaYMVZRkS8=;
 b=NJPwdW3v5eE0NxEmj6q1FKqaeuPzypgQBfQo0FIRpNjdDI82HOa+YXm6KAgn/FWbTXSuF3
 YD4YdH1z12ut7667XoQ/3es0nOkVIHiH12iQb06FvAVMyeeFs3IuU7Nvhh3kxu8NWommL6
 wJDchmjJjUHdAbD8L1v6idio7zlARts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713450124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4L5UOP5m8+suBNlPwnZWH6EuSDU8XzLTAtaYMVZRkS8=;
 b=SfviXWGh2NFjianWcIN6vZg4HIgRbU1/r+q3EY6uatsvXYSGpjRGm448FF46PqS7RqHa4n
 rCWDACFbbvz4mrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2A8713687;
 Thu, 18 Apr 2024 14:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u7WANossIWbrIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Apr 2024 14:22:03 +0000
Date: Thu, 18 Apr 2024 16:22:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240418142202.GA100561@pevik>
References: <20240411044645.29938-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240411044645.29938-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-2.80)[99.15%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] zram01.sh: Increase timeout for
 check_read_mem_used_total
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

> Increase timeout value to let case pass on our low ppc64le
nit: s/low/low resource/
> machine.

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/device-drivers/zram/zram01.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
> index 0c100b706..959dab217 100755
> --- a/testcases/kernel/device-drivers/zram/zram01.sh
> +++ b/testcases/kernel/device-drivers/zram/zram01.sh
> @@ -155,7 +155,7 @@ zram_fill_fs()
>  			continue
>  		fi

> -		TST_RETRY_FUNC "check_read_mem_used_total /sys/block/zram$i/mm_stat" 0
> +		TST_RETRY_FN_EXP_BACKOFF "check_read_mem_used_total /sys/block/zram$i/mm_stat" 0 10

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Sounds ok for me to avoid timeout.
@Cyril, @Li WDYT? Or do you smell bug we try to cover?

Kind regards,
Petr

>  		mem_used_total=$(read_mem_used_total /sys/block/zram$i/mm_stat)
>  		tst_res TINFO "mem_used_total: $mem_used_total"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
