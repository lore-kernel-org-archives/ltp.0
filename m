Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26343C3DA49
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 10:40:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C8CC3D1C06
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 12:40:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 156513D0EA8
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 12:40:30 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8A379600085
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 12:40:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DF5F41F8B0;
 Tue, 23 Jul 2024 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721731228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ch7cuVLR9DYB+TqGWEmK2hxaNf/gkTWUf6NprCtRqYE=;
 b=V131yXo5V7CfD+9FRscsoeu5q45P07waf/JWkIQoX/Q6pgQaXLp9THMqL/tPOzjshIMotq
 DFSi+cknJsn5eSg+o7CB9KoUTbkj73ZVGXuJoLn6o7ZvIs3ZrOO4tAT6rv3QLAyGk55CQp
 38hEPqTD4YrtGG/WKDgnZwTycx+s4X0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721731228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ch7cuVLR9DYB+TqGWEmK2hxaNf/gkTWUf6NprCtRqYE=;
 b=J/cpDBY8I9ubro1/DiMU+2bUmRhmpS0NCtUefyelgKky0EGgyB9gCM6o4K0/qMcCu37c0p
 tk+Yg0WYiy2C5vCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721731227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ch7cuVLR9DYB+TqGWEmK2hxaNf/gkTWUf6NprCtRqYE=;
 b=XqDVfQuvozO/qQFqPKdtJrCbro2loJmerQQATEKNlKlWfw8un08ltfiEUcpOI1Zdvkr/1Z
 +yseIbaE+WnMK9kFjVrcCJEaQwNemZe993yrFlJzH43hclbeBOgTwms8GXzizRe6oEYH06
 y0gd67EJNbqOGbJo3zMnnwOeDp4+Fqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721731227;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ch7cuVLR9DYB+TqGWEmK2hxaNf/gkTWUf6NprCtRqYE=;
 b=Bk16Ng20X4s5OmUuaTGfY0NUpitbz5rTefBzZiDSE8cFNFYFLAEt6aP4t/GGKFx2LVpr3M
 +2tiugihZ6CqzdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C768013874;
 Tue, 23 Jul 2024 10:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wx3cLpuIn2adEQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 23 Jul 2024 10:40:27 +0000
Date: Tue, 23 Jul 2024 12:40:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zp-Igy54VYXix3eR@yuki>
References: <20240722-cachestat-v3-0-a0386f7cdaaa@suse.com>
 <20240722-cachestat-v3-2-a0386f7cdaaa@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240722-cachestat-v3-2-a0386f7cdaaa@suse.com>
X-Spamd-Result: default: False [-0.60 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/5] Add cachestat01 test
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
Pushed with a two minor changes, thanks.

> +static void test_cached_pages(const unsigned int use_sync, const int num_pages)
> +{
> +	int fd;
> +
> +	tst_res(TINFO, "%s file synchronization", use_sync ? "Enable" : "Disable");
> +	tst_res(TINFO, "Number of pages: %d", num_pages);
> +
> +	memset(cs, 0, sizeof(struct cachestat));
> +
> +	fd = SAFE_OPEN(FILENAME, O_RDWR | O_CREAT, 0600);
> +
> +	for (int i = 0; i < num_pages; i++)
> +		SAFE_WRITE(0, fd, page_data, page_size);
> +
> +	if (use_sync)
> +		fsync(fd);
> +
> +	cs_range->off = 0;
> +	cs_range->len = page_size * num_pages;
> +

I've added memset(cs, 0xff, sizeof(*cs)) here to make sure that the
structure is initialized with bogus data before the syscall. With that
we will make sure that the nr_dirty have been written to (the tst_bufers
are initialized to zero to begin with).

> +	TST_EXP_PASS(cachestat(fd, cs_range, cs, 0));
> +	print_cachestat(cs);
> +
> +	TST_EXP_EQ_LI(cs->nr_cache + cs->nr_evicted, num_pages);
> +
> +	if (use_sync)
> +		TST_EXP_EQ_LI(cs->nr_dirty, 0);
> +
> +	SAFE_CLOSE(fd);
> +	SAFE_UNLINK(FILENAME);
> +}
> +
> +static void run(unsigned int use_sync)
> +{
> +	for (int i = 0; i < 15; i++)
> +		test_cached_pages(use_sync, 1 << i);
> +}
> +
> +static void setup(void)
> +{
> +	page_size = (int)sysconf(_SC_PAGESIZE);
> +
> +	page_data = SAFE_MALLOC(page_size);
> +	memset(page_data, 'a', page_size);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (page_data)
> +		free(page_data);

free(NULL) is no-op so I've removed the if ().

> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = 2,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.min_kver = "6.5",
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []) {
> +		"fuse",
> +		"tmpfs",
> +		NULL
> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&cs, .size = sizeof(struct cachestat)},
> +		{&cs_range, .size = sizeof(struct cachestat_range)},
> +		{}
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
