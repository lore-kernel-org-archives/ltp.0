Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BF2C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 11:09:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1BFB3C9EA0
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 12:09:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF4F03C9EDB
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:08:12 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2609F1A00EAC
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:08:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB5E22118F;
 Thu, 27 Mar 2025 11:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743073680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGuaRRp9JR5G2ULa0iyZcBnV/z/Lo27Kyh7BJ1ZALp8=;
 b=xXJbRGl+2IvhoNyY+Z/rP9ARMiydlgBuvWGk/1qRSSwgPswyvmeZPV9492LP6wIWTk/+7f
 GiZXmktGWmfke7IRuWPDcpmuJEmbHqb4hng1s6OPu+mnyxTrApcT+eBCULwM4B9hOmN6VX
 eocyfw46kV1xo84oHB/kT+bo3E+cVxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743073680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGuaRRp9JR5G2ULa0iyZcBnV/z/Lo27Kyh7BJ1ZALp8=;
 b=zzz2SbQcTCVcRf8VaS2U+cRqxo8ZG7ocJEn4ge/mkvlb6YnR7IqCabZso9KKXooqzjffyS
 +5jZctcec1sl7uBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xXJbRGl+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zzz2SbQc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743073680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGuaRRp9JR5G2ULa0iyZcBnV/z/Lo27Kyh7BJ1ZALp8=;
 b=xXJbRGl+2IvhoNyY+Z/rP9ARMiydlgBuvWGk/1qRSSwgPswyvmeZPV9492LP6wIWTk/+7f
 GiZXmktGWmfke7IRuWPDcpmuJEmbHqb4hng1s6OPu+mnyxTrApcT+eBCULwM4B9hOmN6VX
 eocyfw46kV1xo84oHB/kT+bo3E+cVxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743073680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGuaRRp9JR5G2ULa0iyZcBnV/z/Lo27Kyh7BJ1ZALp8=;
 b=zzz2SbQcTCVcRf8VaS2U+cRqxo8ZG7ocJEn4ge/mkvlb6YnR7IqCabZso9KKXooqzjffyS
 +5jZctcec1sl7uBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0FD11376E;
 Thu, 27 Mar 2025 11:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kNyaJZAx5WfnIQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 27 Mar 2025 11:08:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 27 Mar 2025 12:07:59 +0100
MIME-Version: 1.0
Message-Id: <20250327-landlock_unix_socket-v1-2-584653f66d9c@suse.com>
References: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
In-Reply-To: <20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743073680; l=2178;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=zcfOoJjY/qKsLZok/yFHo6mZpEvVtQgZEo0vPr+SNdc=;
 b=9vB4fEhjA5Z14vu+Hv6Wf7F5/mE7LURLadGA7ExA/4ML5DzlEr/d6x0jVflcNjYNGZUVhCAI2
 IXpz06h+Vh8Auum0TDeVeeM2AxNHF5CdcYVsmQP9vcvzumU3pjGJTHn
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: BB5E22118F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] landlock02: support landlock ABI v6
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
 testcases/kernel/syscalls/landlock/landlock02.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
index 60010f554b001156f3feb30283bb5c22a5fea1fc..601164794109a61714bb005001d6a94de83e41c2 100644
--- a/testcases/kernel/syscalls/landlock/landlock02.c
+++ b/testcases/kernel/syscalls/landlock/landlock02.c
@@ -20,6 +20,7 @@
 
 static struct tst_landlock_ruleset_attr_abi1 *attr_abi1;
 static struct tst_landlock_ruleset_attr_abi4 *attr_abi4;
+static struct tst_landlock_ruleset_attr_abi6 *attr_abi6;
 static struct landlock_path_beneath_attr *path_beneath_attr;
 static struct landlock_path_beneath_attr *rule_null;
 static struct landlock_net_port_attr *net_port_attr;
@@ -145,14 +146,18 @@ static void setup(void)
 	abi_current = verify_landlock_is_enabled();
 
 	attr_abi1->handled_access_fs =
-		attr_abi4->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
+		attr_abi4->handled_access_fs =
+		attr_abi6->handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE;
 
 	if (abi_current < 4) {
 		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
 			attr_abi1, sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
-	} else {
+	} else if (abi_current < 6) {
 		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
 			attr_abi4, sizeof(struct tst_landlock_ruleset_attr_abi4), 0));
+	} else {
+		ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset,
+			attr_abi6, sizeof(struct tst_landlock_ruleset_attr_abi6), 0));
 	}
 }
 
@@ -171,6 +176,7 @@ static struct tst_test test = {
 	.bufs = (struct tst_buffers []) {
 		{&attr_abi1, .size = sizeof(struct tst_landlock_ruleset_attr_abi1)},
 		{&attr_abi4, .size = sizeof(struct tst_landlock_ruleset_attr_abi4)},
+		{&attr_abi6, .size = sizeof(struct tst_landlock_ruleset_attr_abi6)},
 		{&path_beneath_attr, .size = sizeof(struct landlock_path_beneath_attr)},
 		{&net_port_attr, .size = sizeof(struct landlock_net_port_attr)},
 		{},

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
