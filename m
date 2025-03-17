Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A18A4C282EC
	for <ltp@archiver.kernel.org>; Mon, 17 Mar 2025 15:36:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0FED3CAB40
	for <ltp@archiver.kernel.org>; Mon, 17 Mar 2025 16:36:24 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C7CB3CAB2B
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 16:36:07 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3FC2520033D
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 16:36:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83A8621C5C;
 Mon, 17 Mar 2025 15:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742225765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gT17pwD8cBOd2hdibkdFU6rLMHoGZ8z6APs4okfQknA=;
 b=MhsTIggfDtGgW9k2D4ACPShbiTvjsineOALcBiEa+qh3S4ySYa0n++Uv7PuwyjM/0AIoNx
 oAxiB9498+Xk+VhcNEMUgBO2oKpu9K4rQ3dHPfocDGIw8h881FvhgYER53pSCwGHDLOtUy
 OPrUu7WWOugXFEK4iVH80T3bOvxlch8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742225765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gT17pwD8cBOd2hdibkdFU6rLMHoGZ8z6APs4okfQknA=;
 b=lWyhjnx7QymrhuOPDidkqhnH2U27X7J6Q6zbmq8FcIPYWZPhonWT1plzx2gzLBc8bF7az5
 D1n9nv7tSlaCYWDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1742225765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gT17pwD8cBOd2hdibkdFU6rLMHoGZ8z6APs4okfQknA=;
 b=MhsTIggfDtGgW9k2D4ACPShbiTvjsineOALcBiEa+qh3S4ySYa0n++Uv7PuwyjM/0AIoNx
 oAxiB9498+Xk+VhcNEMUgBO2oKpu9K4rQ3dHPfocDGIw8h881FvhgYER53pSCwGHDLOtUy
 OPrUu7WWOugXFEK4iVH80T3bOvxlch8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1742225765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gT17pwD8cBOd2hdibkdFU6rLMHoGZ8z6APs4okfQknA=;
 b=lWyhjnx7QymrhuOPDidkqhnH2U27X7J6Q6zbmq8FcIPYWZPhonWT1plzx2gzLBc8bF7az5
 D1n9nv7tSlaCYWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75134132CF;
 Mon, 17 Mar 2025 15:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SeCEG2VB2GfsBgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 17 Mar 2025 15:36:05 +0000
Date: Mon, 17 Mar 2025 16:36:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z9hBdgjhuu_lkV6y@yuki.lan>
References: <20250313-mmap_suite_refactoring-v4-0-efd682ece39a@suse.com>
 <20250313-mmap_suite_refactoring-v4-8-efd682ece39a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250313-mmap_suite_refactoring-v4-8-efd682ece39a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 8/8] Refactor mmap001 test and move it to mmap21
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
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +	SAFE_READ(0, fd, buff, memory_size);
> +	SAFE_CLOSE(fd);
> +
> +	for (int i = 0; i < memory_size; i++) {
> +		if (buff[i] != (char)i) {
> +			tst_res(TFAIL, "Mapped file has not been updated at byte %d", i);
> +			goto exit;
> +		}
> +	}
> +
> +	tst_res(TPASS, "Mapped file has been updated");
> +
> +exit:
> +	SAFE_MUNMAP(memory_data, memory_size);

Here we miss:

	memory_data = NULL;


So that we do not attempt to unmap it again if SAFE_UNLINK() has failed.

> +	SAFE_UNLINK(FILE_NAME);
> +}
> +
> +static void setup(void)
> +{
> +	if (tst_parse_filesize(str_pages, &pages, 1, LLONG_MAX))
> +		tst_brk(TBROK, "Invalid number of pages: %s", str_pages);
> +
> +	memory_size = pages * getpagesize();
> +
> +	buff = SAFE_MALLOC(memory_size);
> +}

The rest looks good:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
