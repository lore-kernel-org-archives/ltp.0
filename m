Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B0BC00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 14:47:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F38A3C966D
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 16:47:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D8843C95DD
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 16:47:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E6416100034A
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 16:47:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1032337590;
 Mon, 15 Aug 2022 14:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660574867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2Tqi27/XiB0YsKiLznKcKRdMpVlARo0f85GyaydwOk=;
 b=aqqsxYpSgbzv0I8TDG7c09fjcS1miv3CvP8clCRNtR6EBHE0zAwQdgip6GSNL+VPVPuHH4
 7FLWyWPGlC1zRGMf7O03Dse1myTg0tmxN1bSSaz/TCVqV57LBkqW5tRjd7ts0Y+BcT7XYC
 HausGNN8NmuGZgJORhbl9N3JeKDXUF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660574867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2Tqi27/XiB0YsKiLznKcKRdMpVlARo0f85GyaydwOk=;
 b=kQwJKWd2lLlAYYigUdr/CUcj1cy2fv/ZohThWstXucF3d0fUJPCieWSyXv0gIWrFtnT3n7
 5SR7Wj8dzeh7d4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0B9A13A99;
 Mon, 15 Aug 2022 14:47:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EMYxKpJc+mIBaQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 15 Aug 2022 14:47:46 +0000
Date: Mon, 15 Aug 2022 16:49:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YvpdBVnJGs6OVKag@yuki>
References: <20220811113640.8499-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220811113640.8499-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor pidns32 test using new LTP API
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
Pushed with one fix, thanks.

I moved the *nested = 1 from setup to the run() function, otherwise the
test would be no-op on second and subsequent iterations with -i option.

Diff:

diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/cont
index cbc91df68..333e1fcad 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -43,13 +43,14 @@ static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 static void setup(void)
 {
        level = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED
-       *level = 1;
 }

 static void run(void)
 {
        int ret, status;

+       *level = 1;
+
        ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);
        if (ret < 0)
                tst_brk(TBROK | TERRNO, "clone failed");


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
