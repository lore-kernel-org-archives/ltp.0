Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DEFEA3C22
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 10:31:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B84D3E4CF3
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 12:31:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D9623E4CF3
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 12:30:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E5B751A00607
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 12:30:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56B0C5BD25
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775730631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxnEn+24FH/3y6AW04xdH1ckfRCo18RAAvKVLBoiHwk=;
 b=bBMZmXMxNqWeTz82XEpnx/T12VD76n/TErUqVOMkvOOO3FdXIHyFd3dqugQYsxnzYozNsb
 /1Rn+9MKF30GtAg3HC8OAHvlceWdIqcq8896ZCCtK+kjT6tI6JI2WLnNZzgIp6WXili/Xw
 0XzWj0elsgyo/fAMby+ixdEGD+V7/q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775730631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxnEn+24FH/3y6AW04xdH1ckfRCo18RAAvKVLBoiHwk=;
 b=sUMNKbmAKXh9EKUtbB+NE2EHPUDDR4Rl+1MD4Hv098JhyvjUC0CqJvr6gBfolpkoCNxy5N
 9OVBghP8OtdcJADA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775730631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxnEn+24FH/3y6AW04xdH1ckfRCo18RAAvKVLBoiHwk=;
 b=bBMZmXMxNqWeTz82XEpnx/T12VD76n/TErUqVOMkvOOO3FdXIHyFd3dqugQYsxnzYozNsb
 /1Rn+9MKF30GtAg3HC8OAHvlceWdIqcq8896ZCCtK+kjT6tI6JI2WLnNZzgIp6WXili/Xw
 0XzWj0elsgyo/fAMby+ixdEGD+V7/q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775730631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UxnEn+24FH/3y6AW04xdH1ckfRCo18RAAvKVLBoiHwk=;
 b=sUMNKbmAKXh9EKUtbB+NE2EHPUDDR4Rl+1MD4Hv098JhyvjUC0CqJvr6gBfolpkoCNxy5N
 9OVBghP8OtdcJADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4780C4A0B3
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NN1UEMd/12lCEAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 09 Apr 2026 10:30:31 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Apr 2026 12:30:41 +0200
Message-ID: <20260409103041.8253-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260409103041.8253-1-chrubis@suse.cz>
References: <20260409103041.8253-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] syscalls: newuname01: Fix fail on empty domainname
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
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
