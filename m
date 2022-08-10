Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FE6C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 10:36:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8835A3C95ED
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 12:36:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEBB83C6D89
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 12:35:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D68D110009A1
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 12:35:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 13D32203E4;
 Wed, 10 Aug 2022 10:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660127745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skBG76PH0SSdLRueuvXtDX8gWzLwwWZaU41Bz3ofhuM=;
 b=0Iq2Q4TOzEcUIZCu0CKmVsXTD6EbRjHVN2mak6Xvq3f21YOq9dPHGrJ4vL8nHV43x1At3p
 XHPQrE88U0FicE2PnMPL0fuh1HoPtsNxToIuX8AobJHoN33FqoRviku5YjF5pa+JybKKoI
 yBOPHJX+od6q56uotswHGspWONYlL7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660127745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skBG76PH0SSdLRueuvXtDX8gWzLwwWZaU41Bz3ofhuM=;
 b=U5RrbY7ZZvhfSpLR5ZpNLnVWnPVEkqOH4WMT+4RG9lhieR/z4TlxJSMT50wbj03oezJ/Qf
 maLy9Z2KYds/i8AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F03E713A7E;
 Wed, 10 Aug 2022 10:35:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +cjYOQCK82KbPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 10 Aug 2022 10:35:44 +0000
Date: Wed, 10 Aug 2022 12:37:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YvOKbt1urOeVwQ57@yuki>
References: <20220810092804.5771-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220810092804.5771-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor aiocp using new LTP API
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
The runtime changes do not unfortunatelly work as expected.

First of all we have to check for the runtime in the function that
prepares the file with a random data, since that is quite slow as well.
Since that is done from the test setup it actually runs in a separate
runtime window so I would do just:

diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index 816407284..2b34d8bbe 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -66,6 +66,9 @@ static void fill_with_rand_data(int fd, long long size)
        srand(time(NULL));

        while (i < size) {
+               if (!tst_remaining_runtime())
+                       tst_brk(TCONF, "Out of runtime!");
+
                for (j = 0; j < bufsize; j++) {
                        buf[j] = (rand() % (upper - lower + 1)) + lower;
                        i++;


Also the rand() function is way to slow, it's almost 10x faster for
500MB buffer if you move the buffer intialization out of the loop, i.e.
initialize the buffer with random data once and then write it over and
over.

Then again we would have to check in the async_run() otherwise we will
keep pushing new read request over and over until the queue has
finished.

Lastly we silently skip the check and report PASS when we are out of
runtime, that's not nice. I would be inclined to report TCONF if we end
up out of time before we managed to check that the data was copied
correctly. That wouldn't provide people with a false security.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
