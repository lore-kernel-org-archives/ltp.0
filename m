Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D431C27C75
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 08:32:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5B773D0C4A
	for <ltp@archiver.kernel.org>; Thu, 13 Jun 2024 10:32:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D87B3C7835
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 10:32:05 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 109F21B61052
 for <ltp@lists.linux.it>; Thu, 13 Jun 2024 10:32:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4F1833FD0;
 Thu, 13 Jun 2024 08:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718267523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6NbZxAkWJOUmBnB8/XT4ua9efROpcsuFKlJBwDGCPQA=;
 b=J0VrAwhuVeBdq+XlYniU5Xz5ueXh2AOYgXfQfuYpTBHgDkmcN6J7MjIz1zNDaavuszqdd9
 WzUWFuZfGB1Xb6AD+vzNdMguNrc98ixD5bbg0nWXj5ltNaG8rPtBa/r6Bxp7etK7Sj5l8y
 c0YlAUxVCiKMbj0UDFRNlsS6ZbkDq5g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718267523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6NbZxAkWJOUmBnB8/XT4ua9efROpcsuFKlJBwDGCPQA=;
 b=SNSLyHHh+FYAR+sUUS9P1Z3RZrrTfl0+Aa83krBDFCIMm6Gb++TuddZKxMqf9OrnKeGWT6
 g0hoQ1hdlD0wxyAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718267522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6NbZxAkWJOUmBnB8/XT4ua9efROpcsuFKlJBwDGCPQA=;
 b=rpTK3+JeWld0K8tTUjHwA9fDw8nL9A/S5vc0Z3oztGAcKCTqmC1uBXkja5LW5vOfW0tSsd
 Nj7J9avRPDUgXnFCc0TdbK+6JmrlpX5Sa63eK7VASfpHLKPDj0/Y73FTqwNAX9bB7vvcDe
 +Rg7lPkARW01ih7LHDNPxMWa1NtBgIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718267522;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6NbZxAkWJOUmBnB8/XT4ua9efROpcsuFKlJBwDGCPQA=;
 b=+2VPuV/8J5w5ek2sUfUaWaA89PT7glVZBQjesiiY3Jku5OouwwKn1ROolMz3f5fSGWkkGK
 a7BLGMZ/o35rrkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D470713AB2;
 Thu, 13 Jun 2024 08:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Uj+mMoKuamZTXQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 13 Jun 2024 08:32:02 +0000
Date: Thu, 13 Jun 2024 10:31:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Zmquc-biCPBV2DCr@yuki>
References: <20240530044029.15474-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240530044029.15474-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] msync04.c: Use direct IO to verify the data is
 stored on disk
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Wei Gao <wegao@suse.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> ---
>  testcases/kernel/syscalls/msync/msync04.c | 56 +++++++++++++----------
>  1 file changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/msync/msync04.c b/testcases/kernel/syscalls/msync/msync04.c
> index 1718bd7dc..c0580d1b0 100644
> --- a/testcases/kernel/syscalls/msync/msync04.c
> +++ b/testcases/kernel/syscalls/msync/msync04.c
> @@ -11,6 +11,7 @@
>   * is no longer dirty after msync() call.
>   */
>  
> +#define _GNU_SOURCE
>  #include <errno.h>
>  #include "tst_test.h"
>  
> @@ -43,10 +44,35 @@ static uint64_t get_dirty_bit(void *data)
>  	return pageflag_entry & (1ULL << 4);
>  }
>  
> -static void test_msync(void)
> +static void verify_mmaped(void)
> +{
> +	void *buffer = SAFE_MEMALIGN(getpagesize(), getpagesize());
> +
> +	tst_res(TINFO, "Not see dirty bit so we check content of file instead");
                         ^
			Haven't seen dirty...

> +	test_fd = SAFE_OPEN("msync04/testfile", O_RDONLY | O_DIRECT);
> +	SAFE_READ(0, test_fd, buffer, getpagesize());
> +
> +	char *char_buffer = (char *)buffer;

You can declare the buffer directly as char * instead, there is no need
for this indirection.

> +	if (char_buffer[8] == 'B')
> +		tst_res(TCONF, "write file ok but msync couldn't be tested"
> +				" because the storage was written to too quickly");

This could be shorter and stil to the point:

"Write was too fast, couldn't test msync()"

> +	else
> +		tst_res(TFAIL, "write file failed");

We should free() allocated the memory here.


Other than these minor issues the rest looks good to me.

You can add my Reviewed-by: once these issues are fixed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
