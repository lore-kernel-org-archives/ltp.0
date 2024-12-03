Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67853E64A9D
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 13:37:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D94113DE0B9
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 14:37:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 601D33DE0C0
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 14:36:47 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6792511E551C
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 14:36:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44C202116D
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 13:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733233006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTX/nS0yeDFC5CeZ8bgm8DuLKijPoTYTrpo6dciPl0I=;
 b=rymTXwB9RTJmaF9mUqKYy8Fuad8x15vRpgW9F23KaVEdEjk+u8SoyCbMf5WT3BEnJ1DEpc
 iDlc8/ZUvyZIPeiuyLzgoqirOyYBo+FUFcHNMpbAzf3PSlq+X3o9zNCTsrC9eKQeu6ak9b
 r5furw5k5IcRS/RF+LMmJ2in7p+CUqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733233006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTX/nS0yeDFC5CeZ8bgm8DuLKijPoTYTrpo6dciPl0I=;
 b=leQS98YRnQRSf0wKySuebcdHSxKcGzwtO6/WJrL/+deBlbtpOJMrkPCe9o0Tuoyn8nJLAX
 +IBXBEm70PBm7oAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733233006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTX/nS0yeDFC5CeZ8bgm8DuLKijPoTYTrpo6dciPl0I=;
 b=rymTXwB9RTJmaF9mUqKYy8Fuad8x15vRpgW9F23KaVEdEjk+u8SoyCbMf5WT3BEnJ1DEpc
 iDlc8/ZUvyZIPeiuyLzgoqirOyYBo+FUFcHNMpbAzf3PSlq+X3o9zNCTsrC9eKQeu6ak9b
 r5furw5k5IcRS/RF+LMmJ2in7p+CUqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733233006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTX/nS0yeDFC5CeZ8bgm8DuLKijPoTYTrpo6dciPl0I=;
 b=leQS98YRnQRSf0wKySuebcdHSxKcGzwtO6/WJrL/+deBlbtpOJMrkPCe9o0Tuoyn8nJLAX
 +IBXBEm70PBm7oAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2E4213A15
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 13:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yEGlLW0JT2fbIgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 13:36:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 03 Dec 2024 14:36:36 +0100
MIME-Version: 1.0
Message-Id: <20241203-madvise_guard_install-v1-1-c0485abbfc73@suse.com>
References: <20241203-madvise_guard_install-v1-0-c0485abbfc73@suse.com>
In-Reply-To: <20241203-madvise_guard_install-v1-0-c0485abbfc73@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733233004; l=637;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=L2S9YhIv97Kzy9Y+qRqKRWcxvvbL5NVx0UQA5xRfU1c=;
 b=RiMaqJSQHXfogys7VaWi8uaoggHiuhqy6O/FB2iGA/JM5BW1BUAJdIPdER0UDfMXJAJVQZs9n
 45w/yUOAnluAQmLHQepZgmOSnkaY+WlN8ualYaVWuwwRsfirNmJuvqk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] Fallback for MADV_GUARD_* definitions
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
 include/lapi/mmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index 7512e9f812a065e5485e042ef0eadd1a05e6b63c..ea9730586234eb0ab4d38ba7450a1e3a30dd49b9 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -38,6 +38,14 @@
 # define MADV_SOFT_OFFLINE 101
 #endif
 
+#ifndef MADV_GUARD_INSTALL
+# define MADV_GUARD_INSTALL 102
+#endif
+
+#ifndef MADV_GUARD_REMOVE
+# define MADV_GUARD_REMOVE 103
+#endif
+
 #ifndef MADV_MERGEABLE
 # define MADV_MERGEABLE   12
 #endif

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
