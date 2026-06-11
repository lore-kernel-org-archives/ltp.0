Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569D4CD98CE
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 12:55:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B22983E2C3F
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 14:55:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21D0A3CB3C2
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 14:55:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6DDC4140075D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 14:55:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7B38B75989;
 Thu, 11 Jun 2026 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781182524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PQ/FtWOdjaTp0yTsMBaWoXlY61cDfuNXPQ8LmITu430=;
 b=BmKXfDuOH7PWOi0rqzveM/iOIR0kH2nGblzNMtUW705LemwnZsx0XnkGUdSEKVf+fZdFd/
 NrnVGZGV80OPJNKhIrGo75tzr2kVkZGcThBV+81Ddjm5Awgc5KGQ40UHI0x14r/b/KYLAy
 9Hi2X7BPV/8GTLKn4ASycZEOd4b/Co0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781182524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PQ/FtWOdjaTp0yTsMBaWoXlY61cDfuNXPQ8LmITu430=;
 b=rXKrSq7f8ICEc0F0YkfiU7ZxOPchB3uirc/T5HkJ7N458vk3ztCnUflj1z/dOB2geapqFr
 qv2beeod/+QnWVCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BmKXfDuO;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rXKrSq7f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781182524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PQ/FtWOdjaTp0yTsMBaWoXlY61cDfuNXPQ8LmITu430=;
 b=BmKXfDuOH7PWOi0rqzveM/iOIR0kH2nGblzNMtUW705LemwnZsx0XnkGUdSEKVf+fZdFd/
 NrnVGZGV80OPJNKhIrGo75tzr2kVkZGcThBV+81Ddjm5Awgc5KGQ40UHI0x14r/b/KYLAy
 9Hi2X7BPV/8GTLKn4ASycZEOd4b/Co0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781182524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PQ/FtWOdjaTp0yTsMBaWoXlY61cDfuNXPQ8LmITu430=;
 b=rXKrSq7f8ICEc0F0YkfiU7ZxOPchB3uirc/T5HkJ7N458vk3ztCnUflj1z/dOB2geapqFr
 qv2beeod/+QnWVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DAC2779A7;
 Thu, 11 Jun 2026 12:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uF1OGjywKmpdcgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Thu, 11 Jun 2026 12:55:24 +0000
Message-ID: <4c043ecf-8cf2-4a81-84a3-960b29b71fa3@suse.cz>
Date: Thu, 11 Jun 2026 14:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260611-fix_xfrm_compat_mode-v1-1-bbb80ee1ad63@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260611-fix_xfrm_compat_mode-v1-1-bbb80ee1ad63@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7B38B75989
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] xfrm: Skip on EOPNOTSUPP in compat mode
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
I would change the TCONF message a bit to something like "xfrm compat 
mode is not available". The compat module may be available but it 
doesn't load automatically. We could try loading it in setup() but then 
we'd either need to check insmod() result or add .needs_root. But since 
the bug is not compat-specific, this patch is good enough.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 6/11/26 11:37, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> A 32-bit binary running on a 64-bit kernel uses the XFRM netlink compat
> layer, which is only available when CONFIG_XFRM_USER_COMPAT is enabled
> (and its module loaded). Without it the kernel returns EOPNOTSUPP for
> any XFRM netlink message, which is a configuration limitation rather
> than a test failure.
> 
> Report TCONF instead of TBROK in that case for xfrm01, xfrm02 and
> xfrm03.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   testcases/network/sockets/xfrm01.c | 3 +++
>   testcases/network/sockets/xfrm02.c | 3 +++
>   testcases/network/sockets/xfrm03.c | 3 +++
>   3 files changed, 9 insertions(+)
> 
> diff --git a/testcases/network/sockets/xfrm01.c b/testcases/network/sockets/xfrm01.c
> index 5490d6b8a9f7fde79478ae0484e6ea8156d07cf3..22244032a521a42331b0c1411ae33f75622e64ce 100644
> --- a/testcases/network/sockets/xfrm01.c
> +++ b/testcases/network/sockets/xfrm01.c
> @@ -126,6 +126,9 @@ static void setup(void)
>   		if (TST_ERR == EPROTONOSUPPORT)
>   			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
>   
> +		if (tst_is_compat_mode() && TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "xfrm netlink unsupported in compat mode (missing CONFIG_XFRM_USER_COMPAT)");
> +
>   		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
>   	}
>   }
> diff --git a/testcases/network/sockets/xfrm02.c b/testcases/network/sockets/xfrm02.c
> index 43edb77d43c8c99e9883fc9922031d559ef31c40..376f6ebe551dd81fbc6a982503eacd68da636f93 100644
> --- a/testcases/network/sockets/xfrm02.c
> +++ b/testcases/network/sockets/xfrm02.c
> @@ -126,6 +126,9 @@ static void setup(void)
>   		if (TST_ERR == EPROTONOSUPPORT)
>   			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
>   
> +		if (tst_is_compat_mode() && TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "xfrm netlink unsupported in compat mode (missing CONFIG_XFRM_USER_COMPAT)");
> +
>   		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
>   	}
>   
> diff --git a/testcases/network/sockets/xfrm03.c b/testcases/network/sockets/xfrm03.c
> index 02ab95c6b7a87f8f206b30a39bb6feb097117998..fa5df9c285d540d5cad0e890a73d43ad9aeba1c2 100644
> --- a/testcases/network/sockets/xfrm03.c
> +++ b/testcases/network/sockets/xfrm03.c
> @@ -202,6 +202,9 @@ static void setup(void)
>   		if (TST_ERR == EPROTONOSUPPORT)
>   			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
>   
> +		if (tst_is_compat_mode() && TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "xfrm netlink unsupported in compat mode (missing CONFIG_XFRM_USER_COMPAT)");
> +
>   		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
>   	}
>   
> 
> ---
> base-commit: c685f1b774fab694c42dfb7522bc42d999904373
> change-id: 20260611-fix_xfrm_compat_mode-0503f1f9bb8d
> 
> Best regards,


-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
