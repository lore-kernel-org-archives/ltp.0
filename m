Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED41FC02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 14:51:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49C4A3C939C
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 15:51:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE28D3C089D
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 15:50:37 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 192BF20B0DC
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 15:50:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B67981F454
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoRcB7ZNoCYb6lAdyCYXKQzaZrCh9Yv+SvhG6ei2XFY=;
 b=FPI6KnCM791MMOQi3PwLnL+1NvYQ9SmTakNj0O0EwQmvpB7NI+/sCUM/OBpRP9zv5wyGls
 xaixWVM7OBSYGvyQh2JRiiYD5mdTaZ/1YDnUg8YzCVLNFJXXmkrkm/OTPlEwcqRDFDbTH0
 eWUgUBAig3CrBGwgO30UB7Wzj3B9+9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoRcB7ZNoCYb6lAdyCYXKQzaZrCh9Yv+SvhG6ei2XFY=;
 b=fITvVsuIAT/QqnwiMe9h4/KFBwvaZOOsZ305ocXul8vEHsgv8Unoa8/3cQGZ/EcN62ernG
 b+oGGyo2A38S1uDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FPI6KnCM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fITvVsuI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738939836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoRcB7ZNoCYb6lAdyCYXKQzaZrCh9Yv+SvhG6ei2XFY=;
 b=FPI6KnCM791MMOQi3PwLnL+1NvYQ9SmTakNj0O0EwQmvpB7NI+/sCUM/OBpRP9zv5wyGls
 xaixWVM7OBSYGvyQh2JRiiYD5mdTaZ/1YDnUg8YzCVLNFJXXmkrkm/OTPlEwcqRDFDbTH0
 eWUgUBAig3CrBGwgO30UB7Wzj3B9+9E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738939836;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xoRcB7ZNoCYb6lAdyCYXKQzaZrCh9Yv+SvhG6ei2XFY=;
 b=fITvVsuIAT/QqnwiMe9h4/KFBwvaZOOsZ305ocXul8vEHsgv8Unoa8/3cQGZ/EcN62ernG
 b+oGGyo2A38S1uDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1C8513AC0
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 14:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OAG6JbwdpmcdQgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 07 Feb 2025 14:50:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Feb 2025 15:50:35 +0100
MIME-Version: 1.0
Message-Id: <20250207-mmap_suite_refactoring-v1-6-d006d921e4d5@suse.com>
References: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
In-Reply-To: <20250207-mmap_suite_refactoring-v1-0-d006d921e4d5@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738939835; l=690;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=AKaAxPuf+Qd7k6NUbMJIufz+4u3XLKfFTetnUtJkPHQ=;
 b=qhcDom3BfiFASs65m4+0EluZVTPfeoPwG8fTxINz5zzs6Ix+FNqvyyf+7bUMB40TQczIIvlPz
 1+cs388pc5pDzxHbaFPjhKdquPOBizBHsN+oDxac3LMlcnVjRuO0ihJ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: B67981F454
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/8] Cleanup mmap19 test
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
