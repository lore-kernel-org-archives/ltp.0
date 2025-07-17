Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D27CC83F1A
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 09:42:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF3CF3CC22F
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 11:42:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 509933CC16E
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:42:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BAA41600048
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:42:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D167021746;
 Thu, 17 Jul 2025 09:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752745319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbGxXKk8iCt3PT730/FmTFYC0T/G1tyZa+L8UXTGDc4=;
 b=bRSSETDx9Pgik4usONc70ezGOqcU3ZnAmxhBAIwWp5V55rN86Ud/BXZzreHPWGOKCkofDy
 uKKXjmuU30y4i9Z8Eez4U0ApaifTwTTzA9Pg7SzdL8vvABfIjN24h9cVuARUgosCbJmeNS
 DbGBjQWGLNwFjqjaL52ETEL3h2E6zdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752745319;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbGxXKk8iCt3PT730/FmTFYC0T/G1tyZa+L8UXTGDc4=;
 b=FtYcxW2yfDCCjMIDCaUtJzYFN8DSGjg3xC1cIqfq16qKEGBInGMYGGzpDgA4fEpPDQacPG
 8/0RTdoXDiFPo5Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A9eSUty5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OXHEJby9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752745318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbGxXKk8iCt3PT730/FmTFYC0T/G1tyZa+L8UXTGDc4=;
 b=A9eSUty5sRFdykpG23ATMGvoU1rhyFVnpgBfYneKGuOOo7J1EFx7STpBgqc6I4CJox3AA+
 vp9C/eS1Q9gBNGDWq9e/mZ8woL/a79cNFsjT4/1GRJHqWMNdaaMPTmSFIBnpVU7eUcIpk/
 B0Ri007gBECNd13AyNF74enzRsO7qsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752745318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbGxXKk8iCt3PT730/FmTFYC0T/G1tyZa+L8UXTGDc4=;
 b=OXHEJby9Wfch/5zVIOY4880ImByo7swyK/PioHvVpdExmVZscEarWaSpSQ3CRdDV2RqEh6
 hC6Ioka61ltjKWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AED2213A75;
 Thu, 17 Jul 2025 09:41:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2Ce5KGbFeGjdWwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 17 Jul 2025 09:41:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 17 Jul 2025 11:41:57 +0200
MIME-Version: 1.0
Message-Id: <20250717-clock_nanosleep05-v3-1-6934fc1a2505@suse.com>
References: <20250717-clock_nanosleep05-v3-0-6934fc1a2505@suse.com>
In-Reply-To: <20250717-clock_nanosleep05-v3-0-6934fc1a2505@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752745318; l=1623;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=trOfrZwu7PkqQL5Yh3mIlY9jnpqCiFvV2lAnSTaiHLQ=;
 b=wynb+0PbAr5PElfVMvTjTv9MDbM4oUFAPLRrIIRYXfFgg9qoA+nmCb1QCVS91KeVE0RhA/8/q
 H8ynbnAJrRZAJqN7I5v7TDE00zlgUUdbtumZBNV430TaiaqP79bx/kw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D167021746
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Add SAFE_CLOCK_NANOSLEEP macro utility
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
 include/tst_safe_clocks.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/tst_safe_clocks.h b/include/tst_safe_clocks.h
index 5661ce57bf7c7b2b0eb3ada9d01049abdd99dab0..5b0e8c5b8c2baad9b41e7f3bf56274d94ebddc7e 100644
--- a/include/tst_safe_clocks.h
+++ b/include/tst_safe_clocks.h
@@ -73,6 +73,26 @@ static inline int safe_clock_settime(const char *file, const int lineno,
 	return rval;
 }
 
+static inline int safe_clock_nanosleep(const char *file, const int lineno,
+	clockid_t clockid, int flags, const struct timespec *ts,
+	struct timespec *remain)
+{
+	int ret;
+
+	errno = 0;
+	ret = clock_nanosleep(clockid, flags, ts, remain);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"clock_nanosleep() failed");
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid clock_nanosleep() return value %d", ret);
+	}
+
+	return ret;
+}
+
 static inline int safe_timer_create(const char *file, const int lineno,
 	clockid_t clockid, struct sigevent *sevp, timer_t *timerid)
 {
@@ -159,6 +179,9 @@ static inline int safe_timer_delete(const char *file, const int lineno,
 #define SAFE_CLOCK_SETTIME(clk_id, tp)\
 	safe_clock_settime(__FILE__, __LINE__, (clk_id), (tp))
 
+#define SAFE_CLOCK_NANOSLEEP(clockid, flags, ts, remain)\
+	safe_clock_nanosleep(__FILE__, __LINE__, clockid, flags, ts, remain)
+
 #define SAFE_TIMER_CREATE(clockid, sevp, timerid)\
 	safe_timer_create(__FILE__, __LINE__, (clockid), (sevp), (timerid))
 

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
