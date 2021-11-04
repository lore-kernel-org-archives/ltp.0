Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D138C433F5
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 18:37:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A8D60EB4
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 18:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8A8D60EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0464E3C7362
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 19:37:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A51123C71C1
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 19:37:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0C39D1A010FA
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 19:37:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 25FA7218A9;
 Thu,  4 Nov 2021 18:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636051057;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4keFsTnducwcVal7BvXpUwr+8DI6ADHh4DX7fdjkfPs=;
 b=nq0O5vHh8ri5yFAbQfV5HAvP6OnX3rZi2ZRkPVyTqGtdVZWMwjV2VemgjGg4GogzRqpRN4
 FKEe2NcorVaebd8T4G/Fhw9W9P+YLjXw5V4VpwJiKvhRbYMNsL1tyVkYcR3igbAmJMXCnX
 qjnfrst/dAl4wZc3Fr24F4V3IWKXhsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636051057;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4keFsTnducwcVal7BvXpUwr+8DI6ADHh4DX7fdjkfPs=;
 b=CQhQRqZ1eu8aCddjLOypeElqr9kSsShFYNWIh/8G3Y60m7oE8zNaWLebzNdM+PrGkS8WD2
 mNFIvEY1RHKBJKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF52913F28;
 Thu,  4 Nov 2021 18:37:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XPx1NHAohGE6SAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Nov 2021 18:37:36 +0000
Date: Thu, 4 Nov 2021 19:37:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YYQobypksa1GZPYo@pevik>
References: <20211104121941.32957-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211104121941.32957-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify: Kill the child process before
 exit
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
Cc: Matthew Bobrowski <repnop@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Before the main process exit abnormally, we need to kill
> the child process.

Amir, Matthew, could you please have a look?

Kind regards,
Petr

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  .../kernel/syscalls/fanotify/fanotify07.c     | 35 ++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
> index cc56d9019..0a0b4f1e4 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify07.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
> @@ -108,6 +108,39 @@ static int setup_instance(void)
>  	return fd;
>  }

> +static int setup_another_instance(void)
> +{
> +	int rval;
> +	int fd = fanotify_init(FAN_CLASS_CONTENT, O_RDONLY);
> +
> +	if (fd == -1) {
> +		stop_children();
> +		tst_brk(TBROK | TERRNO, "fanotify_init() failed");
> +	}
> +
> +	if (fd < -1) {
> +		stop_children();
> +		tst_brk(TBROK | TERRNO,
> +			"invalid fanotify_init() return %d", fd);
> +	}
> +
> +	rval = fanotify_mark(fd,
> +		FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, fname);
> +
> +	if (rval == -1) {
> +		stop_children();
> +		tst_brk(TBROK | TERRNO, "fanotify_mark() failed");
> +	}
> +
> +	if (rval < -1) {
> +		stop_children();
> +		tst_brk(TBROK | TERRNO,
> +			"invalid fanotify_mark() return %d", rval);
> +	}
> +
> +	return fd;
> +}
> +
>  static void loose_fanotify_events(void)
>  {
>  	int not_responded = 0;
> @@ -160,7 +193,7 @@ static void test_fanotify(void)
>  	 * Create and destroy another instance. This may hang if
>  	 * unanswered fanotify events block notification subsystem.
>  	 */
> -	newfd = setup_instance();
> +	newfd = setup_another_instance();

>  	SAFE_CLOSE(newfd);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
