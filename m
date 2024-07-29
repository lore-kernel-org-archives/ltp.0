Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121C7C3DA4A
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 22:34:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E0B93D1D41
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 00:34:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BD433D1BF9
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 00:34:38 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 331561400434
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 00:34:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F80E21AB3;
 Mon, 29 Jul 2024 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722292477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5hZQNxSo4D5+4sGjnPo2qXs/jLwW3rYYMKkPbChvw6o=;
 b=BIjbSajKTrG4dEKbCuOO/WBYDaPy/RsrC6lFfqoK8BV8FLhaFssZW6VNRSeNx395e2v3QE
 tMBYdPPIvVMjJXrIwERblji0CgD5Il0g78LjwHRMQ2VSdRTPU0g3IRLe7J5kOvkgaUBg/L
 HoHKD5yahthHpw2u3Y1kGSyy1a/nw+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722292477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5hZQNxSo4D5+4sGjnPo2qXs/jLwW3rYYMKkPbChvw6o=;
 b=M+5xorT7H1EO10SSGixiPWhv5c742SWtYcEjMyqGy6IDVTj/ghxoFYhy3EMcnkZbnnFVjK
 toFX2MzO1dTqVgBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722292477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5hZQNxSo4D5+4sGjnPo2qXs/jLwW3rYYMKkPbChvw6o=;
 b=BIjbSajKTrG4dEKbCuOO/WBYDaPy/RsrC6lFfqoK8BV8FLhaFssZW6VNRSeNx395e2v3QE
 tMBYdPPIvVMjJXrIwERblji0CgD5Il0g78LjwHRMQ2VSdRTPU0g3IRLe7J5kOvkgaUBg/L
 HoHKD5yahthHpw2u3Y1kGSyy1a/nw+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722292477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5hZQNxSo4D5+4sGjnPo2qXs/jLwW3rYYMKkPbChvw6o=;
 b=M+5xorT7H1EO10SSGixiPWhv5c742SWtYcEjMyqGy6IDVTj/ghxoFYhy3EMcnkZbnnFVjK
 toFX2MzO1dTqVgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00D18138A7;
 Mon, 29 Jul 2024 22:34:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g5dnOvwYqGbzaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 22:34:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Jul 2024 00:34:31 +0200
Message-ID: <20240729223431.1307306-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.60 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] cachestat01: Reduce required space on 64kb page
 size
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

ppc64le (6.10.1 on Tumbleweed) fails due 64kb page size requiring more
space:

cachestat01.c:39: TINFO: Number of pages: 4096
cachestat01.c:56: TPASS: cachestat(fd, cs_range, cs, 0) passed
cachestat01.c:59: TPASS: cs->nr_cache + cs->nr_evicted == num_pages (4096)
cachestat01.c:38: TINFO: Disable file synchronization
cachestat01.c:39: TINFO: Number of pages: 8192
cachestat01.c:46: TBROK: write(3,0x1000ddb0aa0,65536) failed: ENOSPC (28)

Fixes: 93b28ee69d ("Add cachestat01 test")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
First I thought we should use tst_fs_has_free() in each
test_cached_pages() run, but test uses .all_filesystems, thus it's
always 300 MB. Should we, just in case, use .dev_min_size = 300,
to make sure it runs correctly even we change the DEV_SIZE_MB value?

Or, should we really calculate required space with tst_fs_has_free(),
based on page size num_pages and * 1.1 (reserved space for metadata)?

Kind regards,
Petr

 testcases/kernel/syscalls/cachestat/cachestat01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index f7f6275cbd..edb6335d9e 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -67,7 +67,7 @@ static void test_cached_pages(const unsigned int use_sync, const int num_pages)
 
 static void run(unsigned int use_sync)
 {
-	for (int i = 0; i < 15; i++)
+	for (int i = 0; i < page_size > 4096 ? 13 : 15; i++)
 		test_cached_pages(use_sync, 1 << i);
 }
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
