Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E376E77199
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 14:05:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9699D3C1C0F
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 15:05:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07B643C0273
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 15:05:16 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B72361027853
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 15:05:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18FDD210F6;
 Wed,  8 Jan 2025 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736345114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M5Alk104LudE6zgrklT/YBY7Q7OGrLSaQcKmfumFrQk=;
 b=jE3/2xDipcYXS/aGNSHvKclpuafL9t8Pw8ye986lT9QNKx/qTRCyDzxsVqWgJEOd+XQRau
 MYX8RVmj0xos4FcJB9Lvl4VlwdHMQqvIMMLluhmlrtrU5E3aXiVFSBVYNscTkbnvDT/Yx1
 Ywk6Va5PIX4hsKauPqF4UUj3CTC7Ros=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736345114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M5Alk104LudE6zgrklT/YBY7Q7OGrLSaQcKmfumFrQk=;
 b=Hkg8QJp3BkBdSKQS+Ps1jfbaPXN3St7syrQWIUh+XrbjqUDEKMfqnnxZs7KygUZNvWhRMc
 ebWSg7+5eU239zDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="jE3/2xDi";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Hkg8QJp3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736345114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M5Alk104LudE6zgrklT/YBY7Q7OGrLSaQcKmfumFrQk=;
 b=jE3/2xDipcYXS/aGNSHvKclpuafL9t8Pw8ye986lT9QNKx/qTRCyDzxsVqWgJEOd+XQRau
 MYX8RVmj0xos4FcJB9Lvl4VlwdHMQqvIMMLluhmlrtrU5E3aXiVFSBVYNscTkbnvDT/Yx1
 Ywk6Va5PIX4hsKauPqF4UUj3CTC7Ros=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736345114;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M5Alk104LudE6zgrklT/YBY7Q7OGrLSaQcKmfumFrQk=;
 b=Hkg8QJp3BkBdSKQS+Ps1jfbaPXN3St7syrQWIUh+XrbjqUDEKMfqnnxZs7KygUZNvWhRMc
 ebWSg7+5eU239zDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 084C71351A;
 Wed,  8 Jan 2025 14:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YuFvABqGfmfSQgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Jan 2025 14:05:14 +0000
Date: Wed, 8 Jan 2025 15:05:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z36GDDnXQfhzwZvk@yuki.lan>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-6-e293a8d99cf6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241112-lsm-v1-6-e293a8d99cf6@suse.com>
X-Rspamd-Queue-Id: 18FDD210F6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid,linux.it:url];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email, suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/7] Add lsm_list_modules02 test
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
> +		if (!name)
> +			tst_brk(TBROK, "Unsupported LSM: %lu", ids[i]);
> +
> +		if (strstr(name, lsm_list))

Again here the strstr() is not future proof. There is no lsm with the
name as a substring of a different lsm, but it's not entirely unlikely
that a lsm with name that contains one of the three letter names as a
substring in the future.

So I guess that we may as well break the lsm list into an array of
strings with strtok() in the setup and add a function that loops on the
array and does strcmp() for each entry in that array.

> +			tst_res(TFAIL, "'%s' has not been found", name);
> +		else
> +			tst_res(TPASS, "'%s' is enabled", name);
> +	}
> +
> +	TST_EXP_EQ_LI(*size, counter * sizeof(uint64_t));

So we get literal size in the size and number of elements as the return
value. Sounds good.

> +	TST_EXP_EQ_LI(lsm_num, counter);

Isn't this true by definition? We do tst_brk(TBROK, "") on unknown lsm
so if the counter is not increased on each lsm_num iteration we exit the
test with tst_brk() and never reach this line.

And hat is actually missing here is to compare the number of lsm names
in the /sys/kernel/security/lsm file with the lsm_num. But for that we
have to break the file content into tokens and count them, which we need
to do anyways.

> +}
> +
> +static void setup(void)
> +{
> +	int fd;
> +
> +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> +	fd = SAFE_OPEN("/sys/kernel/security/lsm", O_RDONLY);
> +	SAFE_READ(0, fd, lsm_list, BUFSIZ);
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.min_kver = "6.8",
> +	.bufs = (struct tst_buffers []) {
> +		{&ids, .size = sizeof(uint64_t) * MAX_LSM_NUM},
> +		{&size, .size = sizeof(uint32_t)},
> +		{},
> +	},
> +};
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
