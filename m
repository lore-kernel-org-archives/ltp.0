Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF0C606A885
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iuKM5WuL;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=o8nBMOEu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=iuKM5WuL;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=o8nBMOEu
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6D373EAC5E
	for <ltp@archiver.kernel.org>; Wed, 11 Nov 2026 14:57:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4AD93EA0D8
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 14:57:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E929D1400B6B
 for <ltp@lists.linux.it>; Wed, 11 Nov 2026 14:57:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F1D28349FB;
 Wed, 11 Nov 2026 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794405457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2EyAgH8CDMRF1/huCcO82BaiQyFna2Q1DoLc5N5xlnQ=;
 b=iuKM5WuLOh1FP7xUNruG/5VyoCBnNZySMMN/9jLkeqfu64x1qu5xQomBonIUzOZsWbVxcf
 hG9AGLpgiziEpxWet2AXKwPTL/rC3J7hsh1BNb1FiyO8Jl8ODgMQjroRAMfeSJZs6nKgjg
 Ji+4My8SGnlutxt2uViw/p5HXxPpado=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794405457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2EyAgH8CDMRF1/huCcO82BaiQyFna2Q1DoLc5N5xlnQ=;
 b=o8nBMOEu66AxplsrOVb/ywV7bnjPMEWKE7GbLVkYczlPdkdbSr/myPrttfieVo5ga/JJ7G
 h7Hc+GxzWJotFlDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794405457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2EyAgH8CDMRF1/huCcO82BaiQyFna2Q1DoLc5N5xlnQ=;
 b=iuKM5WuLOh1FP7xUNruG/5VyoCBnNZySMMN/9jLkeqfu64x1qu5xQomBonIUzOZsWbVxcf
 hG9AGLpgiziEpxWet2AXKwPTL/rC3J7hsh1BNb1FiyO8Jl8ODgMQjroRAMfeSJZs6nKgjg
 Ji+4My8SGnlutxt2uViw/p5HXxPpado=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794405457;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2EyAgH8CDMRF1/huCcO82BaiQyFna2Q1DoLc5N5xlnQ=;
 b=o8nBMOEu66AxplsrOVb/ywV7bnjPMEWKE7GbLVkYczlPdkdbSr/myPrttfieVo5ga/JJ7G
 h7Hc+GxzWJotFlDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77CE7134E5;
 Wed, 11 Nov 2026 13:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Gx2DElB09GrnbQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Nov 2026 13:57:36 +0000
Date: Wed, 11 Nov 2026 14:57:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Changwei Zou <changwei.zou@canonical.com>
Message-ID: <20261111135730.GA748268@pevik>
References: <20261105005506.76889-1-changwei.zou@canonical.com>
 <20261105005506.76889-2-changwei.zou@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261105005506.76889-2-changwei.zou@canonical.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 1/1] cpuset_memory_spread: rewrite as a C test
 using the LTP cgroup library
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Changwei Zou,

...
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.skip_filesystems = (const char *const []){ "tmpfs", "ramfs", NULL },
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
> +	.needs_cgroup_ver = TST_CG_V1,
> +};
> +
> +#else
> +TST_TEST_TCONF("test requires libnuma >= 2");
IMHO at least this suggestion by agent in v7 was wrong. You should have kept
using:
TST_TEST_TCONF(NUMA_ERROR_MSG);

BTW on which Ubuntu version do you test which still uses v1 and have libnuma2?

Kind regards,
Petr
> +#endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
