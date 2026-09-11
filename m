Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4ADC88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:31:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 320253E9211
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 17:31:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5142C3E9219
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:30:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2D8622002C7
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:30:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4885721BF7;
 Fri, 11 Sep 2026 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789140600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/lv5krkxYgPIHwRmX3t4gxCN3cIFnZSrYr7DjyR8fM=;
 b=rb5tTTcAmBpjGc86RD2ORMkHJPG4d3I6l01DJOqsEdonMmHCZHKm4y1TfYQ2vu4npayli/
 mWcuQEJ7g8kS56gUwuVBmRIi7FZlGvcufZiVP6pfbkQ2kfFoJUTv3YtpRs/o7qeH47oGdS
 3p1xXLp+Xtv5ObQgDKgXsGF83dua0tE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789140600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/lv5krkxYgPIHwRmX3t4gxCN3cIFnZSrYr7DjyR8fM=;
 b=LniCFhxUdwX00T9AbG3NH4CqqSHWK/6zWWCJDfCjh8J8MY53w4DTkl8r911aaxu6vE7yVw
 OGolQg35J2muT6Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ov50lvHC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6VNzg+wU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789140596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/lv5krkxYgPIHwRmX3t4gxCN3cIFnZSrYr7DjyR8fM=;
 b=Ov50lvHCBvd1o2WG6dS5iewTs3dzvMaB7q7+J8EvitQ4glA+KIZOgh9sOdQh4Patq15zxi
 2ixFleK64cHtJy1X/fVonhoEWpB629CEwZMFdlYVhbZFkG2RmOyQ1cTIGB7unFNzCwx0m+
 klPaJ2Gh/Va3mX1sVaZv//Bhow7VPV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789140596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/lv5krkxYgPIHwRmX3t4gxCN3cIFnZSrYr7DjyR8fM=;
 b=6VNzg+wU1L1+HH4+YLIQ18gzWLRQHeu3aEmBjOFO8aHskxPzRNLzh+wuwcHoi34fws/3CA
 cX4xnvOeKiAyOECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 053B713715;
 Fri, 11 Sep 2026 15:29:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yOQhO3MepGoNOAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 15:29:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 17:29:53 +0200
MIME-Version: 1.0
Message-Id: <20260911-mmap_32bit_coverage-v3-1-b0608349556d@suse.com>
References: <20260911-mmap_32bit_coverage-v3-0-b0608349556d@suse.com>
In-Reply-To: <20260911-mmap_32bit_coverage-v3-0-b0608349556d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789140595; l=521;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=1ZYJGk6v6bX4bg4E4zCa1T/wtQKlecGjJtahQZotoaw=;
 b=fyJCyB/D2u/KP8IRkxr8j4DrtLV5u7fSRysqGKgONTQgNlNj0IMqcOEWexstc3xkaeWGZujjd
 tc44Aj+/cpVA6kriTTdVqfXYm/UcLnzRzdCK+ubOPmwcwxu4RxwX+Ts
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 4885721BF7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.cz:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] lapi/mmap: add MAP_32BIT fallback
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
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
