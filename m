Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23146C25B48
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 08:49:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B73913CCD6D
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 10:49:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D3553CCD53
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 10:49:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F39F110011C3
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 10:49:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1E07B1FE67;
 Tue, 24 Oct 2023 08:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698137367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cEZbQ65cieLzawq43U5UJBlgigUpKm9QvdgojS/7q9U=;
 b=t9Y2D7GWsO1VfiNVZViO0Q93o+R+Slr1a0NlTPfxkgD72yCg54Q/4zixqQtcE34unXA0MY
 TqfEP+IHCmdEWoJbUgO6e42PVuPxaioQk5kfOvf/OihDURU4OvfF6ggN03nl11aZXAA1Sd
 4/PfJV/i13MwyQ+11NhwGACUpt0+xzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698137367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=cEZbQ65cieLzawq43U5UJBlgigUpKm9QvdgojS/7q9U=;
 b=AX+QIDngQh2nIJ685k7RxPfYexEqCIMMDn1wOnD6tAgOImyQj2aB38myGyCiYBRoMOnnma
 qLSaqjf+RwlUPOBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E4CFC1391C;
 Tue, 24 Oct 2023 08:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QVVlNhaFN2UCcAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 Oct 2023 08:49:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 24 Oct 2023 10:49:22 +0200
Message-ID: <20231024084923.217110-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.47 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.37)[97.10%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] stack_clash: Guard functions used only in 64bit
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
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Pavel Boldin <pboldin@cloudlinux.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To avoid "defined but not used" warnings when compiled on 32bit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/cve/stack_clash.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
index 3a99c49bb..56b970a1b 100644
--- a/testcases/cve/stack_clash.c
+++ b/testcases/cve/stack_clash.c
@@ -92,6 +92,7 @@ void segv_handler(int sig, siginfo_t *info, void *data LTP_ATTRIBUTE_UNUSED)
 		_exit(EXIT_SUCCESS);
 }
 
+#ifdef __x86_64__
 static void force_bottom_up(void)
 {
 	FILE *fh;
@@ -134,6 +135,7 @@ static void force_bottom_up(void)
 out:
 	SAFE_FCLOSE(fh);
 }
+#endif
 
 unsigned long read_stack_addr_from_proc(unsigned long *stack_size)
 {
@@ -187,6 +189,7 @@ void __attribute__((noinline)) preallocate_stack(unsigned long required)
 	garbage[0] = garbage[required - 1] = '\0';
 }
 
+#ifdef __x86_64__
 static void do_mmap_placement_test(unsigned long stack_addr, unsigned long gap)
 {
 	void *map_test_gap;
@@ -208,6 +211,7 @@ static void do_mmap_placement_test(unsigned long stack_addr, unsigned long gap)
 		SAFE_MUNMAP(map_test_gap, MAPPED_LEN);
 	}
 }
+#endif
 
 void do_child(void)
 {
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
