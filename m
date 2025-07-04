Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D51C83F03
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 11:31:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE09F3C9F2E
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 13:31:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0618B3C9D1D
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 13:30:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8AD8C600D1B
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 13:30:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B1324211B5;
 Fri,  4 Jul 2025 11:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751628645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJASK0F8w7QWGg2Sxm1RR9kqg7DDpbXa5XXWqt/UNt0=;
 b=0TQc7utCBzRz8eZcBFNWrqlmPDIP6DPP3XJbAtAl+pV6KXm2sVrBFzR+4AwpNdm8qlSull
 hA9ExIp65b5IYpDE5P7Wr82MUq+ikC8q+7+fk8pBLQFJHeY9+EA3Cmpb6SeVl4ej6dWNMD
 vkjxYY3uS7Tbul0TP49IwKFoJAEw7Pk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751628645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJASK0F8w7QWGg2Sxm1RR9kqg7DDpbXa5XXWqt/UNt0=;
 b=di+tHQ665GFyo2sD1cgr83v6+xqMqx+ekUmTmnQOoNMRzfyS8ECBSticMRHXrdtnKaEu8p
 kMCUKSYJ1+oQlZBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zxsRTRQU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cKfamboH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751628644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJASK0F8w7QWGg2Sxm1RR9kqg7DDpbXa5XXWqt/UNt0=;
 b=zxsRTRQUTM7gUyRuVZ2Xm3EgxPD3j6YvCZbNQKpff5Y/OsWUI4pcOJxHenQpXOjhBgbEW9
 iTkWDWvN3eGgw1UsYPp/fEBnZ30NjCs+ogF+FAa0pIJwrr1aWK/605smDvZX+LOqjgboJc
 GVn5qYlU4ScNDp3DZzgmA9OM+RkX6dE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751628644;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJASK0F8w7QWGg2Sxm1RR9kqg7DDpbXa5XXWqt/UNt0=;
 b=cKfamboHnJN6ho+rZtF3ywBYe7pyWAISpA/mH0QYt9enV9AykQG/PodmLA7801U3pohHHq
 6uv0wcJVCCYaRSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF32813A8E;
 Fri,  4 Jul 2025 11:30:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uG/0GmO7Z2iTRQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Jul 2025 11:30:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Jul 2025 13:30:39 +0200
MIME-Version: 1.0
Message-Id: <20250704-ioctl_pidfd_suite-v2-1-88a6466d9f62@suse.com>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
In-Reply-To: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751628642; l=1005;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=O5fCVeDp/LCzEl+8eKtUbVHHODmNxjmt5GaF1KDYSog=;
 b=BggLLJAczmH9SV0YvqCJzRryeElrVVMEUPO9zBkvbhggC4j91Js/Q6HSNeZnl4B17NCsYLkUH
 jGuiKRoxl4iA8xnNU3Y6q+12r5Mn44ZTqrjDhoXVNmAizgYRbFMds+Y
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B1324211B5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/8] Provide pidfd parameter in tst_clone_args
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
