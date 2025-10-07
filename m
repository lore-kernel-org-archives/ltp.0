Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8A0CCA476
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 15:25:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B6BB3CE49B
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 17:25:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0356F3CE1F8
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 17:25:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 512531A0090D
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 17:25:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4286A33685;
 Tue,  7 Oct 2025 15:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759850727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gyjnj9u1UkGT0vk0vE+5IIT57uSWrV5Xb6KM5+RkhY=;
 b=lswVJBgxwpCNclZrORdJfX+JYqh9QjFT+rpt64YYYojgiMfQz1vEkq6IG4kgBlrFcq7MHc
 iewjl2dJslMDNkuVdEVZyebkkdgBrIrMgDN+nheu+HZXNu5i7cAw7jzeheopxmaMOV2i+T
 WBL9hZKguKFNzxbvlJMwxcvnXKAV76U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759850727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gyjnj9u1UkGT0vk0vE+5IIT57uSWrV5Xb6KM5+RkhY=;
 b=5g3X2hDqURRsKtq1P1gDF9RNrMtG/aoZiguPaQ1yAMgtdqU+dEy3/c6h5GdBIOJHI3496v
 g9Qxkg8xsuwQ4UDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759850727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gyjnj9u1UkGT0vk0vE+5IIT57uSWrV5Xb6KM5+RkhY=;
 b=lswVJBgxwpCNclZrORdJfX+JYqh9QjFT+rpt64YYYojgiMfQz1vEkq6IG4kgBlrFcq7MHc
 iewjl2dJslMDNkuVdEVZyebkkdgBrIrMgDN+nheu+HZXNu5i7cAw7jzeheopxmaMOV2i+T
 WBL9hZKguKFNzxbvlJMwxcvnXKAV76U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759850727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1gyjnj9u1UkGT0vk0vE+5IIT57uSWrV5Xb6KM5+RkhY=;
 b=5g3X2hDqURRsKtq1P1gDF9RNrMtG/aoZiguPaQ1yAMgtdqU+dEy3/c6h5GdBIOJHI3496v
 g9Qxkg8xsuwQ4UDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 329E913693;
 Tue,  7 Oct 2025 15:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xfCuCucw5WhQTgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Oct 2025 15:25:27 +0000
Date: Tue, 7 Oct 2025 17:26:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aOUxGWL0hEw6FfMw@yuki.lan>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-7-bf458fa66358@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251007-xattrat-v2-7-bf458fa66358@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 07/10] lapi: add removexattrat() fallback
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
> +#ifndef HAVE_FUNC_REMOVEXATTRAT
                ^
		And here as well, otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> +static inline int removexattrat(int dfd, const char *pathname,
> +			     unsigned int at_flags, const char *name)
> +{
> +	return tst_syscall(__NR_removexattrat, dfd, pathname, at_flags, name);
> +}
> +#endif
> +
>  #endif /* LAPI_XATTR_H__ */
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
