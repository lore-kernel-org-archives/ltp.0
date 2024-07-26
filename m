Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8809C3DA4A
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 16:31:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EF513D1CC0
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 18:31:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40BA23CF2B3
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 18:31:18 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7D09D6233F6
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 18:31:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D3EE21BFF;
 Fri, 26 Jul 2024 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722011473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDtQNA8cnxoJkDpudJAd5K8oTv2+ox1mdhrCcoEI44c=;
 b=U57tgNCC5pYcd63wC8Uu5sarHgFzkARBV6BcajV40A4+lR25Zo580JIy75gO/xd4O3FWhl
 fzNfwrRdmjozlKWrKa7LLFFepwTcS2al7Vlha5dyWsm5gIjsbMf53dup7XDar+Y9BgcMfp
 91G8lI6UIzOMg+P80Dz+sVAihsJFAEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722011473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDtQNA8cnxoJkDpudJAd5K8oTv2+ox1mdhrCcoEI44c=;
 b=hAzfPJdIc4BLOJTOcXnxoQDLuZxLqKoFDWz2fKnn3QLfJZd7rBg/ELMOsWcNIZgD6BUUX4
 CvBYJQYn/W6hOLAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U57tgNCC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hAzfPJdI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722011473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDtQNA8cnxoJkDpudJAd5K8oTv2+ox1mdhrCcoEI44c=;
 b=U57tgNCC5pYcd63wC8Uu5sarHgFzkARBV6BcajV40A4+lR25Zo580JIy75gO/xd4O3FWhl
 fzNfwrRdmjozlKWrKa7LLFFepwTcS2al7Vlha5dyWsm5gIjsbMf53dup7XDar+Y9BgcMfp
 91G8lI6UIzOMg+P80Dz+sVAihsJFAEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722011473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDtQNA8cnxoJkDpudJAd5K8oTv2+ox1mdhrCcoEI44c=;
 b=hAzfPJdIc4BLOJTOcXnxoQDLuZxLqKoFDWz2fKnn3QLfJZd7rBg/ELMOsWcNIZgD6BUUX4
 CvBYJQYn/W6hOLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 639D8138A7;
 Fri, 26 Jul 2024 16:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q3M9F1HPo2a5QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jul 2024 16:31:13 +0000
Date: Fri, 26 Jul 2024 18:31:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240726163106.GC1107201@pevik>
References: <20240725-landlock-v4-0-66f5a1c0c693@suse.com>
 <20240725-landlock-v4-3-66f5a1c0c693@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240725-landlock-v4-3-66f5a1c0c693@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 8D3EE21BFF
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/5] Add landlock04 test
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
Cc: mic@digikod.net, gnoack@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
> +static void tester_run_fs_rules(const int rules, const int result)
> +{
> +	if (rules & LANDLOCK_ACCESS_FS_EXECUTE)
> +		_test_exec(result);
> +
> +	if (rules & LANDLOCK_ACCESS_FS_WRITE_FILE)
> +		_test_write(result);
> +
> +	if (rules & LANDLOCK_ACCESS_FS_READ_FILE)
> +		_test_read(result);
> +
> +	if (rules & LANDLOCK_ACCESS_FS_READ_DIR)
> +		_test_readdir(result);
> +
> +	if (rules & LANDLOCK_ACCESS_FS_REMOVE_DIR)
> +		_test_rmdir(result);
> +
> +	if (rules & LANDLOCK_ACCESS_FS_REMOVE_FILE)
> +		_test_rmfile(result);
> +

> +	if (rules & LANDLOCK_ACCESS_FS_MAKE_CHAR)
> +		_test_make(DEV_CHAR0, S_IFCHR, dev_chr, result);
FYI no need to skip vfat and exfat (.skip_filesystems), just certain tests. This
one above would need to be skipped.

> +
> +	if (rules & LANDLOCK_ACCESS_FS_MAKE_BLOCK)
> +		_test_make(DEV_BLK0, S_IFBLK, dev_blk, result);
and this...

> +
> +	if (rules & LANDLOCK_ACCESS_FS_MAKE_REG)
> +		_test_make(FILE_REGULAR, S_IFREG, 0, result);
> +
> +	if (rules & LANDLOCK_ACCESS_FS_MAKE_SOCK)
> +		_test_make(FILE_SOCKET, S_IFSOCK, 0, result);
and this...

> +
> +	if (rules & LANDLOCK_ACCESS_FS_MAKE_FIFO)
> +		_test_make(FILE_FIFO, S_IFIFO, 0, result);
and this...

> +
> +	if (rules & LANDLOCK_ACCESS_FS_MAKE_SYM)
> +		_test_symbolic(result);
and this.

Kind regards,
Petr


> +
> +	if (rules & LANDLOCK_ACCESS_FS_TRUNCATE) {
> +		if ((tst_kvercmp(6, 2, 0)) < 0) {
> +			tst_res(TINFO, "Skip truncate test. Minimum kernel version is 6.2");
> +			return;
> +		}
> +
> +		_test_truncate(result);
> +	}
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
