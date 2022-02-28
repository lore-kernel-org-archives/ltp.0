Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F5EC433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 09:45:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37DD33CA262
	for <ltp@archiver.kernel.org>; Mon, 28 Feb 2022 10:45:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 891B03C2DD2
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 10:44:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 16C711A00913
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 10:44:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD94D21979
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 09:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646041481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZrVc53kJ/WcjckfO1L42XyEJnB4ovuim6yuNs8OZI0=;
 b=Ae6dB1ovqobXZKbUSNLyF7eXKMbu+4KdpX+5XDIheE1ELpBYxgDqVQb9nuE/Pc/b5RZecv
 EQ8ZrOYLP+TbU9hNnKMvEWAHCNuDUY4MWT+Jk6zZCK9FBoIjLQDpiBmEZl84M/vSP1WPJg
 W957Dco3xELUyery2iiJchApHNVws2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646041481;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZrVc53kJ/WcjckfO1L42XyEJnB4ovuim6yuNs8OZI0=;
 b=f5np1DBsRCMTMT7ljjurTipTd6vtUR16T2T5CPbr27JR7G9U3CMLjLWQgoQUVOwRddbbtw
 RASwlpBULUlDO7Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 988B413AA8
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 09:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TxL0JImZHGIbXQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 28 Feb 2022 09:44:41 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 28 Feb 2022 10:46:59 +0100
Message-Id: <20220228094659.21959-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228094659.21959-1-chrubis@suse.cz>
References: <20220228094659.21959-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] ksm06: lock memory about to be merged
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

We have observed sporadic failures of the test in OpenQA in the case
that the memory allocated by the test is large enough (ksm06_2 runs the
test with -n 8000 which on ppc64le with 64k page size amounts to 1GB in
allocated buffers in total) and in the case of bacground load being run
while the test is executed (LTP compilation with suitable -j make
parameter suffices to trigger the conditions).

The culprit is that some of the pages may end up being swapped before
they happen to be merged due to a memory pressure caused by the
background load.

After this patch applied the test seems to be passing regardless the
background load.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/lib/mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 39e3f1791..f1756b34a 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -565,6 +565,9 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
 #endif
 
 		memset(memory[i], 10, length);
+
+		if (mlock(memory[i], length))
+			tst_res(TINFO | TERRNO, "mlock() failed");
 	}
 
 	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
