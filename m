Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DF9C433F5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 18:31:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EF2B3C6D9E
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 19:31:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 713263C23B0
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 19:31:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BE5C0200065
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 19:31:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F2210210E6;
 Tue, 22 Feb 2022 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645554690;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrM6vaRGH1h8r4+rq2r68pf5XOB4QcyFD0YpvlcQ93o=;
 b=AEYEppuoZFr9e6Bn7YPGUoEKwEev9nBy7I36cFsxwSJLu8fDHxDkCTYex8Ux+jvd+7R+6w
 DxZy9A/dU8taoMg08p4kGbRt5R47OyvDipgocb1TJHitZqKIPCgDuVw7bbTqQHGMG4Ta7M
 YQSbSRrSgwmHch4e/KXYXai4hUCcQmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645554690;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrM6vaRGH1h8r4+rq2r68pf5XOB4QcyFD0YpvlcQ93o=;
 b=6rUoZqRtJrtAJQ967g7bwIGYlbZe9kHS3pVSA1VTUYTZva/joJF4XRyVWa8WFA/SO6J7KS
 obhGiKBKnRYTx5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C38A713C09;
 Tue, 22 Feb 2022 18:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wfkNLgIsFWJudwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 22 Feb 2022 18:31:30 +0000
Date: Tue, 22 Feb 2022 19:31:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YhUsAQKHl8w9AyRq@pevik>
References: <20220222155514.2255913-1-nikita.yushchenko@virtuozzo.com>
 <YhUKtWP8dwNBAcmy@yuki>
 <26fe8a19-8557-5a63-7e5f-fb126e8eed95@virtuozzo.com>
 <YhUe1yp0ukdUJs1V@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YhUe1yp0ukdUJs1V@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] testcases/lib: introduce sysctl wrapper
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
Cc: kernel@openvz.org, ltp@lists.linux.it,
 Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Nikita,

> Hi!
> > LTP sometimes uses sysctl under 'tst_net_run' wrapper

> > Using shell redirection under wrapper is quite tricky if possible at all.
Can you be more specific when sysctl with tst_net_run does not work?

> Ah, right. But I guess that adding a simple tool that would behave just
> as echo but the first parameter would be filename may be cleaner
> solution than wrapping around the sysctl command.
+1. If really requested please create C binary testcases/lib/tst_sysctl.c.
Code which use simple SAFE_FILE_PRINTF() as many C code does would be fairly
simple, more portable and probably faster than shell script. FYI we tend to
rewrite shell code into C.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
