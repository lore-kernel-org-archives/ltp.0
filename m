Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A2AC02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:09:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 591EC3C9890
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 10:09:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 172E23C987D
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:13 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B68CB1BC4B9D
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:07:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 28CF01F38F;
 Mon, 10 Feb 2025 09:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoRcB7ZNoCYb6lAdyCYXKQzaZrCh9Yv+SvhG6ei2XFY=;
 b=x5RM4eE67WgmZz7zyNqCTTZ5wqa/J/e1f3SgQRamrFlLCjHsVTvUfMDK/Jn5EKiH/LZTOY
 NeYY3qCXVVsCBTUfSPrwU6VedlF1iZMVFcWY9+PNWKEvLL4uNDL9pvMhbBXkVFbp/bGbZ9
 Rh/aVsH5TEQQKXV4FkvQxsu8Em1F4PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoRcB7ZNoCYb6lAdyCYXKQzaZrCh9Yv+SvhG6ei2XFY=;
 b=hzYcKm3+ALri925p3qqBsR21SVv5Itge0lgV60Adipai526ueqtmioKYYMKZI+6a9LL7Fu
 H9EGpi7tvS2GnpBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x5RM4eE6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hzYcKm3+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739178432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoRcB7ZNoCYb6lAdyCYXKQzaZrCh9Yv+SvhG6ei2XFY=;
 b=x5RM4eE67WgmZz7zyNqCTTZ5wqa/J/e1f3SgQRamrFlLCjHsVTvUfMDK/Jn5EKiH/LZTOY
 NeYY3qCXVVsCBTUfSPrwU6VedlF1iZMVFcWY9+PNWKEvLL4uNDL9pvMhbBXkVFbp/bGbZ9
 Rh/aVsH5TEQQKXV4FkvQxsu8Em1F4PE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739178432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoRcB7ZNoCYb6lAdyCYXKQzaZrCh9Yv+SvhG6ei2XFY=;
 b=hzYcKm3+ALri925p3qqBsR21SVv5Itge0lgV60Adipai526ueqtmioKYYMKZI+6a9LL7Fu
 H9EGpi7tvS2GnpBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4D5A13707;
 Mon, 10 Feb 2025 09:07:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iBHsM7/BqWdQLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Feb 2025 09:07:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Feb 2025 10:07:11 +0100
MIME-Version: 1.0
Message-Id: <20250210-mmap_suite_refactoring-v2-6-6edea3a4363a@suse.com>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
In-Reply-To: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739178429; l=690;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=AKaAxPuf+Qd7k6NUbMJIufz+4u3XLKfFTetnUtJkPHQ=;
 b=ZDwtyIT05cFM7PMT1AMBc+a9dtmjP0e5TOHTTADJ5uHAz10CJHwFTz6IU9VCq4kZoOmlpLDjJ
 Zd3VXaZiienBjKCjzK0E15tu5nQo9NiKZxdeq3TpUQj7E/LKkPQBzxi
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 28CF01F38F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/8] Cleanup mmap19 test
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
Cc: rbm@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/mmap/mmap19.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap19.c b/testcases/kernel/syscalls/mmap/mmap19.c
index 90b3f45b1f6368ad287125db1e2b2e15fffff601..23cb2be62ced846b151d2578acf76db7de527b25 100644
--- a/testcases/kernel/syscalls/mmap/mmap19.c
+++ b/testcases/kernel/syscalls/mmap/mmap19.c
@@ -24,7 +24,7 @@
 #define LEN 64
 
 static int f1 = -1, f2 = -1;
-static char *mm1 = NULL, *mm2 = NULL;
+static char *mm1, *mm2;
 
 static const char tmp1[] = "testfile1";
 static const char tmp2[] = "testfile2";

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
