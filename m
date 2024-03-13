Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619FBC54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 10:01:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B48763CFD1F
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 11:01:29 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D31BF3CE770
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 11:01:14 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 07C14100CD11
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 11:01:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64D401F7BF;
 Wed, 13 Mar 2024 10:01:13 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 557D61397F;
 Wed, 13 Mar 2024 10:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pJXRE2l58WUEAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Mar 2024 10:01:13 +0000
Date: Wed, 13 Mar 2024 10:59:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZfF45PrePj-RujiR@rei>
References: <20240313092331.18069-1-andrea.cervesato@suse.de>
 <20240313092331.18069-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240313092331.18069-2-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 64D401F7BF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Add SAFE_MPROTECT() macro
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
> +static inline int safe_mprotect(const char *file, const int lineno,
> +	char *addr, size_t len, int prot)
> +{
> +	int rval;
> +	char *prot_buf;
> +
> +	prot_buf = (char*) safe_malloc(file, lineno, 0, 512);
> +	prot_to_str(prot, prot_buf);
> +
> +	tst_res_(file, lineno, TDEBUG,
> +		"mprotect(%p, %ld, %s(%x))", addr, len, prot_buf, prot);
> +
> +	free(prot_buf);
> +
> +	rval = mprotect(addr, len, prot);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"mprotect() failed");
> +	} else if (rval) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid mprotect() return value %d", rval);
> +	}


Ah, and can we please print the whole parameter list for mprotect() in
these two cases as well?

> +	return rval;
> +}
> +#define SAFE_MPROTECT(addr, len, prot) \
> +	safe_mprotect(__FILE__, __LINE__, (addr), (len), (prot))
> +
>  static inline int safe_ftruncate(const char *file, const int lineno,
>                                   int fd, off_t length)
>  {
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
