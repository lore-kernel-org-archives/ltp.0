Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09FDC61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 15:37:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FF2D3E9A65
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 17:37:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69AF03E5E02
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 17:36:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 11CC4200041
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 17:36:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48EC522202;
 Fri, 28 Aug 2026 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787931383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmEIG216iZmzPR0JZZ5K3SuZyeylYsLL1O9od+rKVP4=;
 b=T0YI7eCVdZJsGfMlKHBnuhQpUuLx1kpdPCq3ojNwMMhtDNeEv1+NqHjUPBAfbZFH0yv1kZ
 w4qsxJTlVjarU6ijqX0EGt+vc777qRMWqAVDpShRiPFjKMvHjzqatuYY4cxXerJg/XnYvy
 68038+B7PR/0XtqqRo0/NetztJCm17A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787931383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmEIG216iZmzPR0JZZ5K3SuZyeylYsLL1O9od+rKVP4=;
 b=Eg8elpszn5OnruBcwSXGk8bwTu5TH3ONJ7Xj/43lHlmeE1QMxphrPwpbhsQGHpfKwhLgVc
 SwtY20fFKopyMUAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787931379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmEIG216iZmzPR0JZZ5K3SuZyeylYsLL1O9od+rKVP4=;
 b=V4pJAqXC8rIL0LCzmviWTEOmGNPRSmPR5yKdNZ4Wz+DwRRmz1DFbBKa5m962aH3XPXKDNX
 WcdYIj92WIXApBRohe83KMsMGaw3dl74oXW3ueubWGwaLMsY8eTlpaoxiCJ+RdT5WF/cLr
 wq+r4EUi398ox6JivviHU3C6kyTF3FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787931379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmEIG216iZmzPR0JZZ5K3SuZyeylYsLL1O9od+rKVP4=;
 b=+fAkfi9oB2o2qvOs+mcWx1VtITsCcNJGmTGjn9WYUlJWw42N3XbMpMHPYL5j/ECxsn44cz
 ZYLlTVo44M4CYeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1601613674;
 Fri, 28 Aug 2026 15:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8G1nA/OqkWrebQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 15:36:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 17:36:03 +0200
MIME-Version: 1.0
Message-Id: <20260828-mmap_32bit_coverage-v1-1-7f0b8b589773@suse.com>
References: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
In-Reply-To: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931378; l=479;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Kbo6cWSVaPFng5PBREcH3CaM7huEiOpc5AqqWxxVRZ4=;
 b=IfX/Td2cpzyONe6WGx/FavotHpV6FpVdyk0IHLdoJuK0mIHYFsOdRaPtEBIMuIDLSTdRcqxGv
 GP0ws2cXIJ4AXlIb5xUyeIpNNwI71GxEHS67CIzaHHHG5FTqqm5JjIa
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] lapi/mmap: add MAP_32BIT fallback
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/mmap.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index 3908310f4..f20eb3bd5 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -91,6 +91,10 @@
 # define MAP_DROPPABLE 0x08
 #endif
 
+#ifndef MAP_32BIT
+# define MAP_32BIT 0x40
+#endif
+
 #ifndef MREMAP_DONTUNMAP
 # define MREMAP_DONTUNMAP 4
 #endif

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
