Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD6EC83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:17:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7368C3CCD82
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 16:16:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B86F93CCD63
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 22D1B600849
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 16:16:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8BF581F78E;
 Wed, 23 Jul 2025 14:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ddEWqhohHWhhmDFdtFRKh5OQdNqVfN8NipjsSotqWA=;
 b=P6eBxE79HH3wOF9+cPv5gWDW7Z0h6Sju9kMeW8WoYny2wzp8UQzVZGIwYc2echQi9iHmKM
 f8aPfbl3hbvskfL1Mss+pTJ9AiBMhqhfgTfb+sLppPorKt8JDLocbRuiXEDYbviw/ZVKPm
 HNIhJYJj+9zfmW/wMGEOvJ+5Utth6DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280165;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ddEWqhohHWhhmDFdtFRKh5OQdNqVfN8NipjsSotqWA=;
 b=J65od4ZQri69VaYnB93sBL2HYunj7XzxYkHO8h+Q3Zfjyl/RCBUgcvkSU9EaRx9XlFhOX5
 fQ9uIHJx6avdznCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753280164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ddEWqhohHWhhmDFdtFRKh5OQdNqVfN8NipjsSotqWA=;
 b=PRqBxCPFGIQwlt8ixY2Lus4dz/ZZ88+x4u63uNP0pGVtUsliPrAdpN57zi/bU1HykgIunq
 ruDtjONyIGQ9eCr0dX/Yxfs5o5jkwqe+rREAK+exT9ZOeBHBSnHPF7iaVR34K9VViqYViW
 YCw3x2r6WksrzqHbsTkIfMuzDruRszU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753280164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ddEWqhohHWhhmDFdtFRKh5OQdNqVfN8NipjsSotqWA=;
 b=8U3vKOsD4yEJ7EbXV8WTt58hSRHRwZkRKTmTVUBwzxaldPTZt0AShINfwD8q67AfINl4rM
 Ktv3w2bSZf9A5iAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6611013ADD;
 Wed, 23 Jul 2025 14:16:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2Kk5F6TugGj2LwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 23 Jul 2025 14:16:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 23 Jul 2025 16:15:15 +0200
MIME-Version: 1.0
Message-Id: <20250723-ioctl_pidfd_suite-v4-1-9309eacb1d8c@suse.com>
References: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
In-Reply-To: <20250723-ioctl_pidfd_suite-v4-0-9309eacb1d8c@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753280164; l=1050;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=YT/AK2DD6GTvTuVL3VAK72wIiymtffxVbpiWbFRmdxk=;
 b=s3fdH/jTgDnvbUYEC+RWK56tTCWml12JKK/2OkhB9+HMwU8IHJjPCtJ0KJnJQ8mXAbcMp5nRd
 xHGTf17uZ8PDMHBurkdTg3hocye3nDTJWhyffTsBGGJ+cw9GR6rAMcP
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/8] Provide pidfd parameter in tst_clone_args
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_clone.h | 1 +
 lib/tst_clone.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/tst_clone.h b/include/tst_clone.h
index a57d761ca56dc113dde81a0ed17f15e8f2e58924..a07689c78f575ae6ca87c0952b3e48b3a626012c 100644
--- a/include/tst_clone.h
+++ b/include/tst_clone.h
@@ -12,6 +12,7 @@
 /* The parts of clone3's clone_args we support */
 struct tst_clone_args {
 	uint64_t flags;
+	uint64_t pidfd;
 	uint64_t exit_signal;
 	uint64_t cgroup;
 };
diff --git a/lib/tst_clone.c b/lib/tst_clone.c
index 2aa00beb1a191d8c4a68a96ba529fc48d3777e84..8638052e2ecac2af3a290f01106e10dc8cdc62d1 100644
--- a/lib/tst_clone.c
+++ b/lib/tst_clone.c
@@ -14,6 +14,7 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
 {
 	struct clone_args args = {
 		.flags = tst_args->flags,
+		.pidfd = tst_args->pidfd,
 		.exit_signal = tst_args->exit_signal,
 		.cgroup = tst_args->cgroup,
 	};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
