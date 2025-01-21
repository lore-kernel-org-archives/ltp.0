Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE053C02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 16:14:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12CD43C2B1D
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 17:14:42 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FE753C0229
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:14:26 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BA3FF6609F2
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 17:14:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DAE421153;
 Tue, 21 Jan 2025 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737476063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EsiZynk9Fl25bJ7AbsCKhItZIvNYKqf3NOWu8AzjLEE=;
 b=sD1EzUT6VAyjuB6pl4h+1BVgyCLxEkB+xd66zWn8Oh7rheq2nJ1K+Tmxiinw8OLn6nATuP
 7kvY/fbsPcvzrkviac5XST7fhjI8L/T/KfyjNyQboxNEXQxokG0ShbAyodnJ7DcOc2eUR8
 rKdDP+2QX0X4WYd1GFjpt0bVMLtQjOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737476063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EsiZynk9Fl25bJ7AbsCKhItZIvNYKqf3NOWu8AzjLEE=;
 b=F6LRprjV1Z3lV0NmNETT/g228C+xfeENRGWrdCQI1GI9o08l5utubJHWXe7jN5KRU1Q8xT
 SLtv1R0RbSvy7ODA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737476063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EsiZynk9Fl25bJ7AbsCKhItZIvNYKqf3NOWu8AzjLEE=;
 b=sD1EzUT6VAyjuB6pl4h+1BVgyCLxEkB+xd66zWn8Oh7rheq2nJ1K+Tmxiinw8OLn6nATuP
 7kvY/fbsPcvzrkviac5XST7fhjI8L/T/KfyjNyQboxNEXQxokG0ShbAyodnJ7DcOc2eUR8
 rKdDP+2QX0X4WYd1GFjpt0bVMLtQjOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737476063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EsiZynk9Fl25bJ7AbsCKhItZIvNYKqf3NOWu8AzjLEE=;
 b=F6LRprjV1Z3lV0NmNETT/g228C+xfeENRGWrdCQI1GI9o08l5utubJHWXe7jN5KRU1Q8xT
 SLtv1R0RbSvy7ODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C435D13963;
 Tue, 21 Jan 2025 16:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id urWeLd7Hj2cpBgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 21 Jan 2025 16:14:22 +0000
Date: Tue, 21 Jan 2025 17:14:15 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z4_H15ZITj4QVWea@yuki.lan>
References: <20250121082236.5247-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250121082236.5247-1-liwang@redhat.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] eventfd06: add AIO support check
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
> Just like what we did for io_setup01.c to avoid ENOSYS error:
>   eventfd06.c:140: TBROK: io_setup() failed: ENOSYS
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/eventfd/eventfd06.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/eventfd/eventfd06.c b/testcases/kernel/syscalls/eventfd/eventfd06.c
> index 7339dd471..46d7f73d3 100644
> --- a/testcases/kernel/syscalls/eventfd/eventfd06.c
> +++ b/testcases/kernel/syscalls/eventfd/eventfd06.c
> @@ -136,6 +136,8 @@ static void test_poll(void)
>  static void setup(void)
>  {
>  	TEST(io_setup(MAXEVENTS, &ctx));
> +	if (TST_RET == -ENOSYS)
> +		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
>  	if (TST_RET < 0)
>  		tst_brk(TBROK, "io_setup() failed: %s", tst_strerrno(-TST_RET));
>  

Alternatively we can add CONFIG_AIO to the needs_kconfigs but anyways:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
