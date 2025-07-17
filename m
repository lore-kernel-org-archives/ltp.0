Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F4BC83F1B
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 09:45:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 905BE3CC251
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 11:45:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 237933CACE4
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:45:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7B664600048
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:44:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E0A6F1F7E0;
 Thu, 17 Jul 2025 09:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752745493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbGxXKk8iCt3PT730/FmTFYC0T/G1tyZa+L8UXTGDc4=;
 b=BacltrmF9b8Rt9I6OpSO9jHu6g8bwGm5+L8SJb73qZ10VXVOwvvt3LlcqYdmoX6GpJoFhw
 7rf79taSOwMEEMGeB8FTKGTmhLyXkb8QoB3uviX8hY2tc3Fc1JrlSa3ab2/JuSekbu5Pn8
 JybodOyyjx+1oCt2ERSG86ntZ35q5OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752745493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbGxXKk8iCt3PT730/FmTFYC0T/G1tyZa+L8UXTGDc4=;
 b=YTG3e9bc1EAtY+Xj1DhDecV8EyZBX8jBgmS3Xcw5IhzdQQziBYEfExPKMV6rrlQMOv3dWh
 bBkqGyiTsYQ8k3Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BacltrmF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YTG3e9bc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752745493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbGxXKk8iCt3PT730/FmTFYC0T/G1tyZa+L8UXTGDc4=;
 b=BacltrmF9b8Rt9I6OpSO9jHu6g8bwGm5+L8SJb73qZ10VXVOwvvt3LlcqYdmoX6GpJoFhw
 7rf79taSOwMEEMGeB8FTKGTmhLyXkb8QoB3uviX8hY2tc3Fc1JrlSa3ab2/JuSekbu5Pn8
 JybodOyyjx+1oCt2ERSG86ntZ35q5OM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752745493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WbGxXKk8iCt3PT730/FmTFYC0T/G1tyZa+L8UXTGDc4=;
 b=YTG3e9bc1EAtY+Xj1DhDecV8EyZBX8jBgmS3Xcw5IhzdQQziBYEfExPKMV6rrlQMOv3dWh
 bBkqGyiTsYQ8k3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C46C413A75;
 Thu, 17 Jul 2025 09:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6OkTLhXGeGi2XAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 17 Jul 2025 09:44:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 17 Jul 2025 11:44:52 +0200
MIME-Version: 1.0
Message-Id: <20250717-clock_nanosleep05-v4-1-78bc62df960f@suse.com>
References: <20250717-clock_nanosleep05-v4-0-78bc62df960f@suse.com>
In-Reply-To: <20250717-clock_nanosleep05-v4-0-78bc62df960f@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752745493; l=1623;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=trOfrZwu7PkqQL5Yh3mIlY9jnpqCiFvV2lAnSTaiHLQ=;
 b=HI51zAIyT7uNtMplJ4MZ8eJIpth6B1rxOpnlvysxKCOrVBpLwKlyW//qY51PcM6+L1BDJRZZP
 AjbzXOM21RbBTXeaHUET0VTQEa8U0wR6j+nalMpxYEmQZIJW1r9p9lo
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: E0A6F1F7E0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] Add SAFE_CLOCK_NANOSLEEP macro utility
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
