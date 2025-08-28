Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC783C8303F
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 11:28:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69DCF3CD003
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 13:28:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9643B3C4F42
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 13:28:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C31751000611
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 13:28:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1AAA920B2B;
 Thu, 28 Aug 2025 11:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756380482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4cJd6RX193g9hBK26AiMQmNXfW2w2UvLTL4ii4cFzk=;
 b=c5qiungWI9ZnYN9rPnH10e31gG05LDgolPT/fyJ1SYlAp7QXjtftncSgQPJeOFYCtkY5gg
 7N+MTADosIb3FfQJ6AgxrthmeFmR1zmtasNI0f6mmcYYeBZamzZ8ldM+CeN/hgMiLlWlHs
 QwHb0NsXeOPNiK5niUCff/cljABHku0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756380482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4cJd6RX193g9hBK26AiMQmNXfW2w2UvLTL4ii4cFzk=;
 b=hTCOEP6azorMLLOYG69bEArG2L+MGhXU24Uyg9bhH82hPpnvyzeivbCblgazGiqTokJvIr
 G2UmrEOArIS2gcBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=c5qiungW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hTCOEP6a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756380482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4cJd6RX193g9hBK26AiMQmNXfW2w2UvLTL4ii4cFzk=;
 b=c5qiungWI9ZnYN9rPnH10e31gG05LDgolPT/fyJ1SYlAp7QXjtftncSgQPJeOFYCtkY5gg
 7N+MTADosIb3FfQJ6AgxrthmeFmR1zmtasNI0f6mmcYYeBZamzZ8ldM+CeN/hgMiLlWlHs
 QwHb0NsXeOPNiK5niUCff/cljABHku0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756380482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M4cJd6RX193g9hBK26AiMQmNXfW2w2UvLTL4ii4cFzk=;
 b=hTCOEP6azorMLLOYG69bEArG2L+MGhXU24Uyg9bhH82hPpnvyzeivbCblgazGiqTokJvIr
 G2UmrEOArIS2gcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F342F1368B;
 Thu, 28 Aug 2025 11:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dKQ7OkE9sGggZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 28 Aug 2025 11:28:01 +0000
Date: Thu, 28 Aug 2025 13:28:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ricardo =?iso-8859-1?Q?B=2E_Marli=E8re?= <rbm@suse.com>
Message-ID: <aLA9ZbNA8erKn7Qh@yuki.lan>
References: <20250828-conversions-lchown-v4-0-60dd9a0145f3@suse.com>
 <20250828-conversions-lchown-v4-2-60dd9a0145f3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250828-conversions-lchown-v4-2-60dd9a0145f3@suse.com>
X-Rspamd-Queue-Id: 1AAA920B2B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] syscalls: lchown01: Convert to new API
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
> -struct test_case_t {
> +static struct test_case_t {
>  	char *desc;
>  	uid_t user_id;
>  	gid_t group_id;
> +} test_cases[] = {
> +	{ "Change Owner/Group ids", 700, 701 },
> +	{ "Change Owner id only", 702, 0 },
> +	{ "Change Owner/Group ids", 703, 701 },
> +	{ "Change Group id only", 0, 704 },
> +	{ "Change Group/Group ids", 703, 705 },
> +	{ "Change none", 0, 0 },
>  };
>  
> -static struct test_case_t test_cases[] = {
> -	{"Change Owner/Group ids", 700, 701},
> -	{"Change Owner id only", 702, -1},
> -	{"Change Owner/Group ids", 703, 701},
> -	{"Change Group id only", -1, 704},
> -	{"Change Group/Group ids", 703, 705},
> -	{"Change none", -1, -1},
> -	{NULL, 0, 0}
> -};

This actually changes what the test does. To cite manual page:

"If the owner or group is specified as -1, then that ID is not changed."

The -1 values there were correct, all we need to do in case we have -1
in there is to lstat() the file before lchonw() and use that value for
the check.


> -	cleanup();
> -	tst_exit();
> +	struct test_case_t *tc = &test_cases[i];
> +	uid_t user_id = tc->user_id;
> +	gid_t group_id = tc->group_id;
> +
> +	tst_res(TINFO, "%s", tc->desc);
> +	SAFE_LCHOWN(SFILE, user_id, group_id);
> +	SAFE_LSTAT(SFILE, &stat_buf);
> +	TST_EXP_EQ_LI(stat_buf.st_uid, user_id);
> +	TST_EXP_EQ_LI(stat_buf.st_gid, group_id);

So this would look like:

	uid_t usr_id = tc->user_id;
	gid_t grp_id = tc->group_id;

	SAFE_LSTAT(SFILE, &stat_buf);

	uid_t cmp_usr_id = usr_id == -1 ? stat_buf.st_uid : usr_id;
	uid_t cmp_grp_id = grp_id == -1 ? stat_buf.st_gid : grp_id;

	SAFE_LCHOWN(SFILE, user_id, group_id);
	SAFE_LSTAT(SFILE, &stat_buf);
	TST_EXP_EQ_LI(stat_buf.st_uid, cmp_user_id);
	TST_EXP_EQ_LI(stat_buf.st_gid, cmp_group_id);

And this is exactly what the code was done before.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
