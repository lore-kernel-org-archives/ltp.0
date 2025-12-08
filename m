Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A140D3B7F2
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 15:06:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 983C83CF58D
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 16:06:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C17183CF522
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 16:05:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4FD80140007F
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 16:05:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 686E033690;
 Mon,  8 Dec 2025 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765206346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUdumIijUKnhb8zahfmFQtsfxhXJm4jgP4eswYQuKKA=;
 b=FMfcuZuXq3o3vxrt0d3QZy1FE1gZIbogr0bCPSfYNqlQGhtUoXp1NHiJcEy4K5x7S3VBL9
 cE4cYh12lvqlqi+DL7jDmaBBpWgJOB7FDdENBwtVLuUOSQyeW4OEKgmt9B5eqxOjnNqDHN
 T7kvmnkALpzOKjiawPvHyJIqdqwwtgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765206346;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUdumIijUKnhb8zahfmFQtsfxhXJm4jgP4eswYQuKKA=;
 b=nd2vvB/To3WSVStiGEQkONCk/UazlNtopuQAjQFMwB3+A/FvdsEtTpiE70P/EULB+7+Nvw
 flX4ayolfvn8VxDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765206346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUdumIijUKnhb8zahfmFQtsfxhXJm4jgP4eswYQuKKA=;
 b=FMfcuZuXq3o3vxrt0d3QZy1FE1gZIbogr0bCPSfYNqlQGhtUoXp1NHiJcEy4K5x7S3VBL9
 cE4cYh12lvqlqi+DL7jDmaBBpWgJOB7FDdENBwtVLuUOSQyeW4OEKgmt9B5eqxOjnNqDHN
 T7kvmnkALpzOKjiawPvHyJIqdqwwtgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765206346;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUdumIijUKnhb8zahfmFQtsfxhXJm4jgP4eswYQuKKA=;
 b=nd2vvB/To3WSVStiGEQkONCk/UazlNtopuQAjQFMwB3+A/FvdsEtTpiE70P/EULB+7+Nvw
 flX4ayolfvn8VxDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43D293EA63;
 Mon,  8 Dec 2025 15:05:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GCaZD0rpNmnCWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Dec 2025 15:05:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Dec 2025 16:05:42 +0100
Message-ID: <20251208150542.704006-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251208150542.704006-1-pvorel@suse.cz>
References: <20251208150542.704006-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.979]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email,chinatelecom.cn:email];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] wqueue0*: Use SAFE_KEYCTL()
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
Cc: Mingyu Li <limy83@chinatelecom.cn>, Meng Yang <yangm50@chinatelecom.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Using SAFE_KEYCTL() helps to TCONF on EOPNOTSUPP, which is a
configuration issue.

Reported-by: Meng Yang <yangm50@chinatelecom.cn>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/watchqueue/common.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/watchqueue/common.h b/testcases/kernel/watchqueue/common.h
index 92e8f079cd..0921dce9a6 100644
--- a/testcases/kernel/watchqueue/common.h
+++ b/testcases/kernel/watchqueue/common.h
@@ -85,8 +85,8 @@ static inline key_serial_t wqueue_add_key(int fd)
 	if (key == -1)
 		tst_brk(TBROK, "add_key error: %s", tst_strerrno(errno));
 
-	keyctl(KEYCTL_WATCH_KEY, key, fd, 0x01);
-	keyctl(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02);
+	SAFE_KEYCTL(KEYCTL_WATCH_KEY, key, fd, 0x01, 0);
+	SAFE_KEYCTL(KEYCTL_WATCH_KEY, KEY_SPEC_SESSION_KEYRING, fd, 0x02, 0);
 
 	return key;
 }
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
