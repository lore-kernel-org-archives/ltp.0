Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D0606A32F
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=jYXqj5jh;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dV1wns2M;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=jYXqj5jh;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dV1wns2M
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DD0B93E9FD5
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 12:23:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCAEA3E4D10
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 12:23:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EDBE61A00148
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 12:23:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DE76223F5;
 Thu, 19 Nov 2026 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795087422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSN3KVLgX1xl2hFKbRTHsrlAuhZqRKcOcbeyq4v9xTA=;
 b=jYXqj5jhcdlE4BVRduPaKd+FdQ2ya79WjfhI/QrJ4Q5XCX+ZimrciXlWmkW9o6b87nI7+E
 zv5O1wveaISmyi9LOmuv8fYWmxWnyRgpoitBan/00OtPfWwrxGLpTusK6LTAcH0UmUU20f
 j//4z9hcrNNA9dJpecI9tgfOIiuoQ7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795087422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSN3KVLgX1xl2hFKbRTHsrlAuhZqRKcOcbeyq4v9xTA=;
 b=dV1wns2Mu+lOfsN0D9t4q7r4TmS0CsdOfjHi+gVfSr6PPB/uJMV5tk9KO7ucpUCzd5KHv1
 VfBQZpKlYNpagRCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jYXqj5jh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dV1wns2M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1795087422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSN3KVLgX1xl2hFKbRTHsrlAuhZqRKcOcbeyq4v9xTA=;
 b=jYXqj5jhcdlE4BVRduPaKd+FdQ2ya79WjfhI/QrJ4Q5XCX+ZimrciXlWmkW9o6b87nI7+E
 zv5O1wveaISmyi9LOmuv8fYWmxWnyRgpoitBan/00OtPfWwrxGLpTusK6LTAcH0UmUU20f
 j//4z9hcrNNA9dJpecI9tgfOIiuoQ7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1795087422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CSN3KVLgX1xl2hFKbRTHsrlAuhZqRKcOcbeyq4v9xTA=;
 b=dV1wns2Mu+lOfsN0D9t4q7r4TmS0CsdOfjHi+gVfSr6PPB/uJMV5tk9KO7ucpUCzd5KHv1
 VfBQZpKlYNpagRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01BAF1334C;
 Thu, 19 Nov 2026 11:23:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJPtMz3c/mrwRwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Nov 2026 11:23:42 +0000
Date: Thu, 19 Nov 2026 12:24:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Darren Chang <chihsheng@google.com>
Message-ID: <av7cWu2pjC_2yqWx@yuki.lan>
References: <20261118063445.2137150-1-chihsheng@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261118063445.2137150-1-chihsheng@google.com>
X-Rspamd-Queue-Id: 2DE76223F5
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.51
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sys_block_queue01: Accept plain "none" in
 queue/scheduler
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Fixes: f35242c9cc22 ("testcases: sysfs: Add sys_block_queue01")
> Signed-off-by: Darren Chang <chihsheng@google.com>
> ---
>  .../kernel/sysfs/block/sys_block_queue01.c    | 38 ++++++++++++++++---
>  1 file changed, 33 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/sysfs/block/sys_block_queue01.c b/testcases/kernel/sysfs/block/sys_block_queue01.c
> index 38564139a..ce1f945fd 100644
> --- a/testcases/kernel/sysfs/block/sys_block_queue01.c
> +++ b/testcases/kernel/sysfs/block/sys_block_queue01.c
> @@ -16,7 +16,13 @@
>   * - read_ahead_kb, nr_requests and discard_max_bytes are non-negative
>   * - nr_requests is greater than zero
>   * - rotational, add_random, iostats are boolean (0 or 1)
> - * - scheduler is a valid bracketed-choice file with exactly one active scheduler
> + * - scheduler is a valid bracketed-choice file with exactly one active
> + *   scheduler, or plain ``none`` without brackets for devices that do not
> + *   support I/O schedulers (bio-based devices such as dm, ram, zram, pmem on
> + *   kernels prior to 6.5 before commit 6d85ebf95c44 "blk-sysfs: add a new
> + *   attr_group for blk_mq", and blk-mq queues with BLK_MQ_F_NO_SCHED prior to
> + *   6.14 before commit e7602bb4f3a1 "block: remove BLK_MQ_F_NO_SCHED", where
> + *   elv_iosched_show() emits "none\n")
>   *
>   * All checks skip gracefully with TCONF when a particular attribute is not
>   * present, since the set of exported queue attributes differs between kernel
> @@ -36,6 +42,31 @@ static const char *const sched_allowed[] = {
>  	"kyber", "bfq", "anticipatory", NULL
>  };
>  
> +static void check_scheduler(const char *dev)
> +{
> +	char sched[64];
> +
> +	if (!TST_SYSFS_READ_STR(sched, sizeof(sched),
> +				PATH_SYS_BLOCK "/%s/queue/scheduler", dev)) {
> +		tst_res(TCONF, PATH_SYS_BLOCK "/%s/queue/scheduler does not exist",
> +			dev);
> +		return;
> +	}
> +
> +	/*
> +	 * elv_iosched_show() emits plain "none\n" without brackets for queues
> +	 * that do not support I/O schedulers (bio-based devices prior to 6.5,
> +	 * and BLK_MQ_F_NO_SCHED devices prior to 6.14).
> +	 */

The description in the top level comment is enough, I wouldn't add this
comment here.

> +	if (!strcmp(sched, "none")) {
> +		tst_res(TPASS, PATH_SYS_BLOCK "/%s/queue/scheduler = 'none'", dev);
> +		return;
> +	}

If this happens only in older kernels the check should be done only on
older kernels too. So we need tst_kvercmp() in the test setup that would
set allow_plain_none flag.

> +	TST_SYSFS_ASSERT_CHOICE(sched_allowed, NULL, 0,
> +				PATH_SYS_BLOCK "/%s/queue/scheduler", dev);
> +}
> +
>  static void check_cross(const char *dev)
>  {
>  	TST_SYSFS_ASSERT_LE_SUFFIX("logical_block_size", "physical_block_size",
> @@ -50,8 +81,6 @@ static void check_cross(const char *dev)
>  
>  static void check_device(const char *dev)
>  {
> -	char sched[64];
> -
>  	tst_res(TINFO, "Checking block device '%s'", dev);
>  
>  	TST_SYSFS_ASSERT_POW2(PATH_SYS_BLOCK "/%s/queue/logical_block_size", dev);
> @@ -68,8 +97,7 @@ static void check_device(const char *dev)
>  	TST_SYSFS_ASSERT_BOOL(PATH_SYS_BLOCK "/%s/queue/add_random", dev);
>  	TST_SYSFS_ASSERT_BOOL(PATH_SYS_BLOCK "/%s/queue/iostats", dev);
>  
> -	TST_SYSFS_ASSERT_CHOICE(sched_allowed, sched, sizeof(sched),
> -				PATH_SYS_BLOCK "/%s/queue/scheduler", dev);
> +	check_scheduler(dev);
>  
>  	check_cross(dev);
>  }
> -- 
> 2.56.1.703.gf848ed807c-goog
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
