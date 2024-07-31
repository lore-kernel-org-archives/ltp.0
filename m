Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A36C3DA7F
	for <ltp@archiver.kernel.org>; Wed, 31 Jul 2024 07:34:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE5583D1E90
	for <ltp@archiver.kernel.org>; Wed, 31 Jul 2024 09:34:32 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7766F3D1DFF
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 09:34:17 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3ABE010060A8
 for <ltp@lists.linux.it>; Wed, 31 Jul 2024 09:34:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8A48F21D42;
 Wed, 31 Jul 2024 07:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722411253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6G+xIyU+/olVxkPr1KGPS9wHCSCgFvPugPTqujwXfyQ=;
 b=TPWd/H8eEJnLFu/lqJRJGDFhaFiBIPCS1FRNznuFZDiRyIqaGkalwIh1Zd0RMKdPFWefyA
 yzCkekGg5Y5dpDL6DE7Tw8ftKiI8nL0YQWbAr/TrnPPAHnMQm7IqjkJQu6TaMspfXN3yVm
 wWeJbsFUgs7AAlBFzOckZsAKCBlhuWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722411253;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6G+xIyU+/olVxkPr1KGPS9wHCSCgFvPugPTqujwXfyQ=;
 b=zg7F7R/FEvJJX+joANXBusvuRd0JlinB3Ue4t9QPsY5U4cfiizvmqb4hTWe2nqgaXX0qKC
 XounO9RWYWZhwPDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722411251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6G+xIyU+/olVxkPr1KGPS9wHCSCgFvPugPTqujwXfyQ=;
 b=ED7hMWZN4f7WOTJOeCRA/zwdGeqVKI5jLClVa5QoA6zZKO3odxEiFrwvGP49mWb0BykiUi
 sHEYgWIC6mH8GVoEQMjW15wcZF6ttIc/Mw5/Y76PDCUxAcFUJYA/jHF/qeI6fmu8XhLwLg
 MGazIHoAtEdAqBklkAjprY6rT8xgFOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722411251;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6G+xIyU+/olVxkPr1KGPS9wHCSCgFvPugPTqujwXfyQ=;
 b=ejhudhY8k+zo49+69KWVwkjblNkjv6PWeScebsSZF6bf2+K2OvMG1WiXDpwbQRVJU6gPIL
 +qKRyfw+jSxVX8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 641B21368F;
 Wed, 31 Jul 2024 07:34:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TlUDF/PoqWYjeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jul 2024 07:34:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jul 2024 09:34:03 +0200
Message-ID: <20240731073403.1406035-1-pvorel@suse.cz>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,ozlabs.org:url,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] cachestat01: Reduce required space on 64kb
 page size
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

Therefore use calculation, which enables maximum number of pages 1 << 15
only for 4kb page size, for 64kb set the maximum number of pages 1 << 12
(13 would trigger ENOSPC on XFS and Btrfs).

Fixes: 93b28ee69d ("Add cachestat01 test")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
* calculate number of pages (or more precisely calculate the shift)
@Cyril: I'm not sure, if you like it this way, feel free to further
improve.

v1:
https://patchwork.ozlabs.org/project/ltp/patch/20240729223431.1307306-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20240729223431.1307306-1-pvorel@suse.cz/

Kind regards,
Petr

 testcases/kernel/syscalls/cachestat/cachestat01.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
index f7f6275cbd..287a67f544 100644
--- a/testcases/kernel/syscalls/cachestat/cachestat01.c
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -26,7 +26,7 @@
 #define MNTPOINT "mntpoint"
 #define FILENAME MNTPOINT "/myfile.bin"
 
-static int page_size;
+static int page_size, num_shift;
 static char *page_data;
 static struct cachestat *cs;
 static struct cachestat_range *cs_range;
@@ -67,14 +67,14 @@ static void test_cached_pages(const unsigned int use_sync, const int num_pages)
 
 static void run(unsigned int use_sync)
 {
-	for (int i = 0; i < 15; i++)
+	for (int i = 0; i < num_shift; i++)
 		test_cached_pages(use_sync, 1 << i);
 }
 
 static void setup(void)
 {
 	page_size = (int)sysconf(_SC_PAGESIZE);
-
+	num_shift = MIN(tst_device->size*1024*2.6/page_size, 15);
 	page_data = SAFE_MALLOC(page_size);
 	memset(page_data, 'a', page_size);
 }
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
