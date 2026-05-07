Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DBBCD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 07:50:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 760D43E2876
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 09:50:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BEEC3E2C39
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:50:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6DB0610000FB
 for <ltp@lists.linux.it>; Thu,  7 May 2026 09:50:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F17316C1B2
 for <ltp@lists.linux.it>; Thu,  7 May 2026 07:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778140205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oIhY6uwskztWXLAQfAbirv6DN7hXW1+lBSal5lW2CU=;
 b=BqcJUSWI8Zao4raGnz5lmVx0LzuS9yXqhnalr1K9rnlfrytq487dQ8fGia5ruj3inXbAnv
 WI+PKS3+Mr74sOKVLU1LiiXaLiYMdDOoJj9Gkk+x8X25uI9nYRQT7Hfn+pB3HwAc0747Ye
 EWsAY1x2Y7puSojTdMvaFibXhE6kRVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778140205;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oIhY6uwskztWXLAQfAbirv6DN7hXW1+lBSal5lW2CU=;
 b=KLfi9UgqkgjNK32EFl2HnSBfB+Uxp5L7LFhhAxK6oQdOEXDSmqE91eRx4kjBccz0FLKhku
 E371lO7yGymcguAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KrTtetQk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pBRjXB3V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778140204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oIhY6uwskztWXLAQfAbirv6DN7hXW1+lBSal5lW2CU=;
 b=KrTtetQkbZEidkvoUjm+7PgBfIpf3wkmZDEPxU3yVr648YnezShmLABhk2AwdCYii9qmFr
 IyG8OscAgdl+ZQ0c5dxtNwTzxw8CTjuLAGPSJ6NyQBXDYuXdYtBQDdF3VpRcdmb9yVIvQ2
 1AmeTN5rWgOAx+yToq1p9sBoF5q9ZPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778140204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oIhY6uwskztWXLAQfAbirv6DN7hXW1+lBSal5lW2CU=;
 b=pBRjXB3VIe9nBP07Tq7zOmFoi9+wUPWLLkvyGuaPpL3mn1Ks3Hn+GggY3QnqjAV0jcJZsH
 ilMI29wybfEzPBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E1FE5593A7
 for <ltp@lists.linux.it>; Thu,  7 May 2026 07:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +cQ+NixE/GkBHgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 07 May 2026 07:50:04 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  7 May 2026 09:50:06 +0200
Message-ID: <20260507075006.8690-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507075006.8690-1-chrubis@suse.cz>
References: <20260507075006.8690-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: F17316C1B2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] syscalls: newuname01: Fix fail on empty
 domainname
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

The domainname can be empty hence we cannot use scanf() string for
format for reading the file. Use the newly added SAFE_FILE_READ_STR()
to read the strings from procfs instead.

Fixes: https://github.com/linux-test-project/ltp/issues/1304
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/newuname/newuname01.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/newuname/newuname01.c b/testcases/kernel/syscalls/newuname/newuname01.c
index 37058023a..995ea978e 100644
--- a/testcases/kernel/syscalls/newuname/newuname01.c
+++ b/testcases/kernel/syscalls/newuname/newuname01.c
@@ -31,16 +31,16 @@ static void run(void)
 
 	TST_EXP_EQ_STR(name->sysname, "Linux");
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/hostname", "%1023[^\n]", proc_val);
+	SAFE_FILE_READ_STR("/proc/sys/kernel/hostname", proc_val, sizeof(proc_val));
 	TST_EXP_EQ_STR(name->nodename, proc_val);
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/osrelease", "%1023[^\n]", proc_val);
+	SAFE_FILE_READ_STR("/proc/sys/kernel/osrelease", proc_val, sizeof(proc_val));
 	TST_EXP_EQ_STR(name->release, proc_val);
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/version", "%1023[^\n]", proc_val);
+	SAFE_FILE_READ_STR("/proc/sys/kernel/version", proc_val, sizeof(proc_val));
 	TST_EXP_EQ_STR(name->version, proc_val);
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/domainname", "%1023[^\n]", proc_val);
+	SAFE_FILE_READ_STR("/proc/sys/kernel/domainname", proc_val, sizeof(proc_val));
 	TST_EXP_EQ_STR(name->domainname, proc_val);
 }
 
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
