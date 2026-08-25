Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13477C61DC2
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 12:44:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EC523C59DD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 14:44:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20A213C55FC
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 14:44:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9530A1A0090C
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 14:44:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DEF2D1F7F0;
 Tue, 25 Aug 2026 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787661855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+r8r3Ht4Hu5bDVzQboGhsbAgFitfB8mhLpnJuFWLgbc=;
 b=zbuB6p/AsUMjNxuf+wrq3RhrtBXUOOSwsPzl9Ey+d74UymZLgJEJqNs3///3LZ3irPc5nI
 h65waOoR6mU0NlNw07aS75VyOTzdroXOh/Ox0mr+fT4E5cDMAxPTunDoQf9ZWk152qOnGN
 uBesGLxQqtv/fwCEfXrAfS7me8CuQSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787661855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+r8r3Ht4Hu5bDVzQboGhsbAgFitfB8mhLpnJuFWLgbc=;
 b=z/EVMLrAvzZnyZn9c2iX+4IJ6jqzv/z0WB0f36wJm0fnJAVK7KEV0KfbsJN+NGtCvxkpPh
 1xJAIyi9bohl3rDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787661850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+r8r3Ht4Hu5bDVzQboGhsbAgFitfB8mhLpnJuFWLgbc=;
 b=x1BXWZMxUt0n3t7Xfm+KF2O5WofvL2xK9hI8xbI0OO4iTJC9a90XllBdFHq0nwhu21py/r
 cH9HLYGc/bJaATBr3ICoZPd0VF6sUVy2Fgq6kQOmQ+NugWnXx3jvGYzaI+206QUPAkbBB5
 plgiXrok7ORI5y7IB4QHDfZnI50yqWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787661850;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+r8r3Ht4Hu5bDVzQboGhsbAgFitfB8mhLpnJuFWLgbc=;
 b=sAKz3dAei8I/7ShBDcS14PXpdNJkx/QrRr4zr8zdS3JL4aJUpnrqWETUze9W9vwTXMhWo1
 gyry7EE66w74wdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C750E13332;
 Tue, 25 Aug 2026 12:44:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r3Y3LxqOjWpWDAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 25 Aug 2026 12:44:10 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 25 Aug 2026 14:44:02 +0200
MIME-Version: 1.0
Message-Id: <20260825-sctphantom_fix-v1-1-6504f91fd7f5@suse.com>
X-B4-Tracking: v=1; b=H4sIABGOjWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyNT3eLkkgKgREl+bnxaZoVualqqgUWShXGyWZKFElBTQVEqUBhsYHQ
 shF9cmpSVmlwCMkWpthYAG9Ii5nIAAAA=
X-Change-ID: 20260825-sctphantom_fix-efe08b83c6b8
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787661850; l=2391;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=eKy05PNyxsoO7Ui5XTkjaOfx7AJ8a226+s9PiTjRcMw=;
 b=AjT7wEl5DtqiTSBfedcbPiv9l00wR1yxLYEbYZzWyEiSat8+byabyKOw962uBAhr/sOAXsTDz
 g2bOr9EtliHBItHGlwgTtjcRsA1kmdDXky0OXysChJyR1iCpcI1K3aq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cve/sctphantom: fix EINVAL on pre-v4.19 kernels
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The test passed its 156 byte mirror of struct sctp_paddrparams, which
includes the spp_ipv6_flowlabel and spp_dscp tail, to
SCTP_PEER_ADDR_PARAMS. Kernels older than v4.19 only accept
optlen == sizeof(struct sctp_paddrparams), which is 152 there, so the
setsockopt() failed and the test broke:

    sctphantom.c:361: TBROK: setsockopt(6, 132, 9, 0x..., 156) failed: EINVAL (22)

Drop the tail fields from the mirrored struct so that the option length
matches the pre-v4.19 layout. That length is also accepted by v4.19 and
newer kernels as the compat size introduced along with the tail fields
by upstream commit 0b0dce7a36fb ("sctp: add spp_ipv6_flowlabel and
spp_dscp for sctp_paddrparams"), provided the SPP_DSCP and
SPP_IPV6_FLOWLABEL flags are not set, which the test never does.

Fixes: 567528e2f809 ("cve/sctphantom: Add reproducer for CVE-2026-64564")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/cve/sctphantom.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/testcases/cve/sctphantom.c b/testcases/cve/sctphantom.c
index 9cda48556..a772012e0 100644
--- a/testcases/cve/sctphantom.c
+++ b/testcases/cve/sctphantom.c
@@ -62,17 +62,19 @@
 #define ADDR_DUMMY	"127.0.0.254"	/* third path to keep transport_count > 1 */
 #define ADDR_SPOOF	"127.0.0.3"	/* forged ASCONF packet source */
 
-/* Mirror of the uapi struct sctp_paddrparams */
+/*
+ * Mirror of the uapi struct sctp_paddrparams without the spp_ipv6_flowlabel
+ * and spp_dscp tail added in v4.19: older kernels require optlen == 152,
+ * while v4.19 and newer also accept the pre-v4.19 length.
+ */
 struct tst_sctp_paddrparams {
-	int32_t		spp_assoc_id;
+	int32_t			spp_assoc_id;
 	struct sockaddr_storage	spp_address;
-	uint32_t	spp_hbinterval;
-	uint16_t	spp_pathmaxrxt;
-	uint32_t	spp_pathmtu;
-	uint32_t	spp_sackdelay;
-	uint32_t	spp_flags;
-	uint32_t	spp_ipv6_flowlabel;
-	uint8_t		spp_dscp;
+	uint32_t		spp_hbinterval;
+	uint16_t		spp_pathmaxrxt;
+	uint32_t		spp_pathmtu;
+	uint32_t		spp_sackdelay;
+	uint32_t		spp_flags;
 } __attribute__((packed, aligned(4)));
 
 /* Mirror of the uapi struct sctp_paddrinfo */

---
base-commit: 4c0cfb849f19beed68175de9fb7d02df55987084
change-id: 20260825-sctphantom_fix-efe08b83c6b8

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
