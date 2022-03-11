Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A99C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 15:30:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A72723C8B2E
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 16:30:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C65913C8B2E
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 16:30:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E7C2C1001180
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 16:30:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 294C51F381;
 Fri, 11 Mar 2022 15:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647012644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iik8gJSuQaWwD4UnKObhhm6WWXwYqQzceT7K2A9xC7Y=;
 b=iuXtb4th+osBO5wunKVhnpcRbJ17PfnwWZ/2fGJ8EOCLWaQtFC3mXbvwQb9rlwKmmWJlAW
 5OQ0doHJ5X2Fm85ceCkbwRl1V9mMXKZjcwNsvP3KtSVwe7pYLk/DqNJYHCRZB+dVO7i7Uk
 gdlDOJs0JA+h6AOO0VBK1+rgjm3Z/n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647012644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Iik8gJSuQaWwD4UnKObhhm6WWXwYqQzceT7K2A9xC7Y=;
 b=hWhZCCqVfBVHaHbAIgy0zpfy0D9B6zYiDcO8m+W9+CTS/OqYaLQGBdmRLm9G6CcmqNdbxQ
 qdZo2++UA1aYgDBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E77913A8E;
 Fri, 11 Mar 2022 15:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id byLEOiNrK2KwEQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 11 Mar 2022 15:30:43 +0000
Date: Fri, 11 Mar 2022 16:33:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Bogdan Lezhepekov <blezhepekov@suse.de>
Message-ID: <YitrrpkBJheQdUAa@yuki>
References: <20220311123957.30998-1-blezhepekov@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220311123957.30998-1-blezhepekov@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kernel/pty06: Skip test when TTY not available
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
> Since TTYs under test are hardcoded, they
> might not be available in some systems.

Is the system you are running the tests on completely without ttys?

> Signed-off-by: Bogdan Lezhepekov <blezhepekov@suse.de>
> ---
>  testcases/kernel/pty/pty06.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/pty/pty06.c b/testcases/kernel/pty/pty06.c
> index b621f584f..250c38f6b 100644
> --- a/testcases/kernel/pty/pty06.c
> +++ b/testcases/kernel/pty/pty06.c
> @@ -45,8 +45,6 @@ static struct tst_fzsync_pair fzp;
>  
>  static void *open_close(void *unused)
>  {
> -	sprintf(tty_path_b, "/dev/tty%d", test_tty_port);
> -
>  	while (tst_fzsync_run_b(&fzp)) {
>  		tst_fzsync_start_race_b(&fzp);
>  		int fd = SAFE_OPEN(tty_path_b, O_RDWR);
> @@ -60,7 +58,6 @@ static void *open_close(void *unused)
>  
>  static void do_test(void)
>  {
> -	sprintf(tty_path_a, "/dev/tty%d", test_tty_port + 1);
>  	int fd = SAFE_OPEN(tty_path_a, O_RDWR);
>  
>  	tst_fzsync_pair_reset(&fzp, open_close);
> @@ -80,6 +77,12 @@ static void do_test(void)
>  
>  static void setup(void)
>  {
> +	sprintf(tty_path_a, "/dev/tty%d", test_tty_port + 1);
> +	sprintf(tty_path_b, "/dev/tty%d", test_tty_port);
> +
> +	if (access(tty_path_a, F_OK) != 0 || access(tty_path_b, F_OK) != 0)
> +		tst_brk(TCONF, "TTY(s) under test not available in system");

There is no need for the != 0 could be simplified just to:

	if (access(...) || access(...))
		tst_brk(TCONF, ...);

>  	tst_fzsync_pair_init(&fzp);
>  }
>  
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
