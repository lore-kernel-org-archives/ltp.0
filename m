Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13617EE800F
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 14:35:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EDD93CC7EE
	for <ltp@archiver.kernel.org>; Fri,  8 Sep 2023 16:35:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76B3C3C9274
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 16:34:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BAB951A010F4
 for <ltp@lists.linux.it>; Fri,  8 Sep 2023 16:34:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DE591FEE9;
 Fri,  8 Sep 2023 14:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694183694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AgMJKqkW0GIvPsXQovDIzqGgBERQOxTClN91mS/Q6Sw=;
 b=BBJJ99rQfwigFjQAtMSEVu6+fwCmcnbkn+JYJ52ua6ZpbqTcsXyq62en1g+r8OnirR6f+g
 vAqRamICzL//w/Td0y7TTmmYTeI6AocqtmPUjTx14KFrYip4+rVzYR2zsfmH9sYR8q7wuJ
 u10vd8skhdWH77T5mTQvPhSaGFhd/aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694183694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AgMJKqkW0GIvPsXQovDIzqGgBERQOxTClN91mS/Q6Sw=;
 b=LS3ZAERIB9ygaTSfG7SQxXgQ425Sn+zzFm1t7DNoGnsz1DerQ6ev6m9+Rs65xPjQVCw2gH
 D0Mqd8G8qRmtV/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82383132F2;
 Fri,  8 Sep 2023 14:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0UmfHQ4x+2T0egAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 08 Sep 2023 14:34:54 +0000
Date: Fri, 8 Sep 2023 16:35:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZPsxN4hnjVbIIdvm@yuki>
References: <ZPCLZ5eIPQZ8sWoX@yuki>
 <20230901055756.7057-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230901055756.7057-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mmap06: Add testcases for EINVAL
 scenarios
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
Pushed with a minor change, thanks.

I did change the messages a bit so that we have sligtly nicer output
with:

diff --git a/testcases/kernel/syscalls/mmap/mmap06.c b/testcases/kernel/syscalls/mmap/mmap06.c
index 1a0c8e3cf..615743fa7 100644
--- a/testcases/kernel/syscalls/mmap/mmap06.c
+++ b/testcases/kernel/syscalls/mmap/mmap06.c
@@ -62,9 +62,9 @@ static void run(unsigned int i)
 		tst_res(TFAIL, "mmap() was successful unexpectedly");
 		SAFE_MUNMAP(TST_RET_PTR, MMAPSIZE);
 	} else if (TST_ERR == tc->exp_errno) {
-		tst_res(TPASS, "mmap() failed with expected errno");
+		tst_res(TPASS | TERRNO, "mmap() failed with");
 	} else {
-		tst_res(TFAIL | TERRNO, "mmap() failed but unexpected errno");
+		tst_res(TFAIL | TERRNO, "mmap() failed unexpectedly");
 	}
 }
 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
