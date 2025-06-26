Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90DCC7EE32
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 12:36:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 329D23CCBBC
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 14:36:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76EE73CCBB8
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:34:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 528E420005D
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 14:34:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E6948211A8;
 Thu, 26 Jun 2025 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJASK0F8w7QWGg2Sxm1RR9kqg7DDpbXa5XXWqt/UNt0=;
 b=BxqCekL2xiO3gsPKXBVauUBdunIYOUcQJxUJZhORcyJIHYTn6S2RdJANAmVcDInPtt+KvR
 GEtou3/yej2j57sn80TmjMyQfqs2koralzYbrUBiW3/v/j4eGHodfiu2ppHR0zdCfrM9DA
 lR1dYqOSUYSE1L/t9Ha+mGQzMXk9wcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJASK0F8w7QWGg2Sxm1RR9kqg7DDpbXa5XXWqt/UNt0=;
 b=k35aBx/6w8BAOeGtqnpZbds5hvZSgAtYY7lB/oX59T/wsMSr35eOTFzuWDz70VJxTjtRRf
 5lG6/7/BsZwqVBDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750941288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJASK0F8w7QWGg2Sxm1RR9kqg7DDpbXa5XXWqt/UNt0=;
 b=BxqCekL2xiO3gsPKXBVauUBdunIYOUcQJxUJZhORcyJIHYTn6S2RdJANAmVcDInPtt+KvR
 GEtou3/yej2j57sn80TmjMyQfqs2koralzYbrUBiW3/v/j4eGHodfiu2ppHR0zdCfrM9DA
 lR1dYqOSUYSE1L/t9Ha+mGQzMXk9wcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750941288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJASK0F8w7QWGg2Sxm1RR9kqg7DDpbXa5XXWqt/UNt0=;
 b=k35aBx/6w8BAOeGtqnpZbds5hvZSgAtYY7lB/oX59T/wsMSr35eOTFzuWDz70VJxTjtRRf
 5lG6/7/BsZwqVBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEC3813A24;
 Thu, 26 Jun 2025 12:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KFj4LGg+XWhJCQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 26 Jun 2025 12:34:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 26 Jun 2025 14:34:38 +0200
MIME-Version: 1.0
Message-Id: <20250626-ioctl_pidfd_suite-v1-1-165b9abf0296@suse.com>
References: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
In-Reply-To: <20250626-ioctl_pidfd_suite-v1-0-165b9abf0296@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750941288; l=1005;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=O5fCVeDp/LCzEl+8eKtUbVHHODmNxjmt5GaF1KDYSog=;
 b=/QyS5Z6aXXcBawP25ER9f3rMf2y0bTWt3l+sn/jUJeJ5QUogZFu59gSRnWIUNYH7lntmt+4qm
 o/RV/lGo0OHBu0TCp0Q8Dv+ouGrtPlVyGp6vhrhMe57I65yGAoqas+p
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] Provide pidfd parameter in tst_clone_args
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
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
