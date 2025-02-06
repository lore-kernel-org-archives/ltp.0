Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9110EC02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 12:45:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF26E3C928D
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 13:45:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 386F23C1BCB
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 13:45:06 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BEB0810363CF
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 13:45:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5CEEA1F38D;
 Thu,  6 Feb 2025 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738845902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zq4j2sYCOkN4Q6NA/qIqV6YJ8PMrC2CBrvznYWTHtQY=;
 b=LEcTDOJY+NBtSOCDhiMoMstb11xkURfWu/vK1Ls8FXUBk1mTwlI4fuIu5+woC1GbQBIkyq
 I9P20AzV++IIIoh8l/jY6ygz9pJ1zl5uDHVnIBDkO3btRld5pTpXqDzHJ3CwonKYOHe3WL
 r5HGhj7nwTyoB0efBgdRXwjjMI6jOuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738845902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zq4j2sYCOkN4Q6NA/qIqV6YJ8PMrC2CBrvznYWTHtQY=;
 b=4Ne6LAf31SKkq/pde4BpVHewBAP8Ql1p02Dvh1rl+pgxGbbEjOUAHwgF61wMXkkZTZVVLC
 ACwvWuslOstiqBCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738845902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zq4j2sYCOkN4Q6NA/qIqV6YJ8PMrC2CBrvznYWTHtQY=;
 b=LEcTDOJY+NBtSOCDhiMoMstb11xkURfWu/vK1Ls8FXUBk1mTwlI4fuIu5+woC1GbQBIkyq
 I9P20AzV++IIIoh8l/jY6ygz9pJ1zl5uDHVnIBDkO3btRld5pTpXqDzHJ3CwonKYOHe3WL
 r5HGhj7nwTyoB0efBgdRXwjjMI6jOuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738845902;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zq4j2sYCOkN4Q6NA/qIqV6YJ8PMrC2CBrvznYWTHtQY=;
 b=4Ne6LAf31SKkq/pde4BpVHewBAP8Ql1p02Dvh1rl+pgxGbbEjOUAHwgF61wMXkkZTZVVLC
 ACwvWuslOstiqBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A7AF13694;
 Thu,  6 Feb 2025 12:45:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZDLYEc6upGdtBAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 06 Feb 2025 12:45:02 +0000
Date: Thu, 6 Feb 2025 13:44:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z6Sux-uScF-o3g7W@yuki.lan>
References: <700f4d3bc73f0deebe7fe0e41305d365135c53eb.1738835278.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <700f4d3bc73f0deebe7fe0e41305d365135c53eb.1738835278.git.jstancek@redhat.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mallinfo02: introduce LTP_VAR_USED to
 avoid optimization
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
> gcc 15 is a bit more clever and noticed that 'buf' isn't used
> for anything so it optimized it out, including call to malloc.
> So, there's also no mmap() call behind it and test fails,
> because nothing was allocated.

Huh, that sounds like the optimizations are getting more and more evil
over the time.

> Introduce LTP_VAR_USED macro, that makes compiler aware of the
> variable and doesn't optimize it out.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  include/tst_common.h                               | 2 ++
>  testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/tst_common.h b/include/tst_common.h
> index b14bbae04077..3de826acd0ec 100644
> --- a/include/tst_common.h
> +++ b/include/tst_common.h
> @@ -13,6 +13,8 @@
>  #define LTP_ATTRIBUTE_UNUSED		__attribute__((unused))
>  #define LTP_ATTRIBUTE_UNUSED_RESULT	__attribute__((warn_unused_result))
>  
> +#define LTP_VAR_USED(p) asm volatile("" :: "m"(p)); p

Shouldn't __attribute__((used)) suffice?

>  #ifndef ARRAY_SIZE
>  # define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>  #endif
> diff --git a/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
> index 90cf4fcb3b89..51783fc22b80 100644
> --- a/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
> +++ b/testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c
> @@ -26,7 +26,7 @@ void test_mallinfo2(void)
>  	char *buf;
>  	size_t size = 2UL * 1024UL * 1024UL * 1024UL;
>  
> -	buf = malloc(size);
> +	LTP_VAR_USED(buf) = malloc(size);
>  
>  	if (!buf)
>  		tst_brk(TCONF, "Current system can not malloc 2G space, skip it");
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
