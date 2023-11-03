Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879FDC4332F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 10:47:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 514023CC81F
	for <ltp@archiver.kernel.org>; Fri,  3 Nov 2023 11:47:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2E933CB4DB
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 11:47:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3D6276008B4
 for <ltp@lists.linux.it>; Fri,  3 Nov 2023 11:47:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0EAA1FD65;
 Fri,  3 Nov 2023 10:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699008444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBZXrE8D6/Hdri8cAJI+lgOrpNhfc/0NuM3nGL9p2ws=;
 b=CQs48cjSuVzW+sJO6YwQE1uqFzrb4pwCH1EH4tM8eR6oWNFsFfDjVdJEr3cKHUStQc0rpJ
 Vde880vMd3Jm/z4lybK58c6IBcUCKvQzZs9/l3ykmPFyYyYeGUASSiYiZv9jmidoVHUNCP
 b2NTPbezLTzNhSjClZBpgTvOULVEEng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699008445;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IBZXrE8D6/Hdri8cAJI+lgOrpNhfc/0NuM3nGL9p2ws=;
 b=aEMlGc+j7mDQ8yUTYLjnPbXAYUaTeSWe46cZp6Ftdavgi3FIxVA6y8zrdTYwM61ubiMgv6
 cpKt9nk3mWIGN1AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD0681348C;
 Fri,  3 Nov 2023 10:47:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gaPBNbzPRGWfIAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 03 Nov 2023 10:47:24 +0000
Date: Fri, 3 Nov 2023 11:47:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <ZUTP3YcexuyOd3ye@yuki>
References: <20231102230054.3195864-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231102230054.3195864-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] madvise11: Allow test to skip if
 MADV_SOFT_OFFLINE is not supported
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> madvise11 will exit with TFAIL if CONFIG_MEMORY_FAILURE is not
> configured.  Skip the TFAIL if EINVAL is returned by madvise.

Does it make sense to keep the test running if the config option is not
present? As far as I can tell we are trying to reproduce a race there
that depends on the madvise being able to soft offline the pages.

What about this then?

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 74caadc44..50ab935c9 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -426,6 +426,10 @@ static struct tst_test test = {
                "rmmod",
                NULL
        },
+       .needs_kconfigs = (const char *[]) {
+                "CONFIG_MEMORY_FAILURE=y",
+                NULL
+        },
        .max_runtime = 30,
        .needs_checkpoints = 1,
        .setup = setup,


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
