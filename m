Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C98FC44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:40:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1C4B3E1766
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 13:40:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F18AF3E1766
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:39:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5AEF2600829
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:39:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 305087838A;
 Wed, 15 Jul 2026 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784115571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vkmegpFNkXb/DXl6njuau/8gVpJ3JAizXZW2T0iyPs=;
 b=aWn5TD1V1IOn49iV8jho3R9y3YAzYpYPFt5jdAP2Vah+cZ5QYHV62qt2yjatXdGBfnmtYF
 U8yW8+NQsS0GNnZh1Si3p4k95h5u699PZUS/+y6FYPdDbWbJ+Rn/pZjGAgxWVlQ07NXVqW
 pQptL2JjNh/6WYjTqh+Tsac0R5BwjgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784115571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vkmegpFNkXb/DXl6njuau/8gVpJ3JAizXZW2T0iyPs=;
 b=zGKH40sCsfcOJk9ihGxUkeTZ8IDgAKLA4jvD+/WQRQ8ZTi2gksoBr3YO+hHUd6SJRcp+oF
 CBNkCz3iL8ATyvAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784115571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vkmegpFNkXb/DXl6njuau/8gVpJ3JAizXZW2T0iyPs=;
 b=aWn5TD1V1IOn49iV8jho3R9y3YAzYpYPFt5jdAP2Vah+cZ5QYHV62qt2yjatXdGBfnmtYF
 U8yW8+NQsS0GNnZh1Si3p4k95h5u699PZUS/+y6FYPdDbWbJ+Rn/pZjGAgxWVlQ07NXVqW
 pQptL2JjNh/6WYjTqh+Tsac0R5BwjgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784115571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vkmegpFNkXb/DXl6njuau/8gVpJ3JAizXZW2T0iyPs=;
 b=zGKH40sCsfcOJk9ihGxUkeTZ8IDgAKLA4jvD+/WQRQ8ZTi2gksoBr3YO+hHUd6SJRcp+oF
 CBNkCz3iL8ATyvAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 092D9779AE;
 Wed, 15 Jul 2026 11:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GESGO3JxV2qHIgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 15 Jul 2026 11:39:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 15 Jul 2026 13:39:26 +0200
MIME-Version: 1.0
Message-Id: <20260715-hugemmap35-v1-1-1d5911d1f2cf@suse.com>
References: <20260715-hugemmap35-v1-0-1d5911d1f2cf@suse.com>
In-Reply-To: <20260715-hugemmap35-v1-0-1d5911d1f2cf@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784115570; l=567;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=SDXmBgGHsadwm/TDln7AULDIAZX+yoz3JiaRYI8vMgQ=;
 b=PzMmQ+dd4CsN4ccWmK76pEV5JywnyVW2BGACptFqprNbjD6CYZ1KJHRK9Zf5XCGZ9ZdBXO8CX
 xHqe7PtdbXoDPy66ohrMPfKPsA82TGVW4AKKfP2bDkwbW6npKixuCsY
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lapi: add PROT_MTE fallback
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
 include/lapi/mman.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/mman.h b/include/lapi/mman.h
index edd517c6e0ebad98f01530b9ac2a7c90cdcaced8..ca72ffd484129b9e8c9165816544da0d8d0ea06a 100644
--- a/include/lapi/mman.h
+++ b/include/lapi/mman.h
@@ -11,6 +11,10 @@
 #include "config.h"
 #include "lapi/syscalls.h"
 
+#ifndef PROT_MTE
+# define PROT_MTE 0x20
+#endif
+
 #ifndef HAVE_STRUCT_CACHESTAT_RANGE
 struct cachestat_range {
 	uint64_t off;

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
