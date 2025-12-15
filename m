Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C56D5B16C
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 14:22:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CC293D01EA
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 15:22:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAA3A3C1817
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 15:22:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A9AF764784B
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 15:22:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81E0C5BD29;
 Mon, 15 Dec 2025 14:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765808548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cytt8MrysE13XgN60+kN7Sl5sGdCxWKfzm1WvKB8bcQ=;
 b=YQFqjkIlKA6h7e7GzBqOebwOQ1Q8mXk2IyU41I8hmDY2qYYahjBvzDEmJNjU3tofRCq3CW
 Czs0zZUvKQAQ/tT9P5Vnt8YXrs1rjZo09mh3WAOm8yQfie59wqG7+cGTq3FIwzi56zpole
 xb/nPJHPoORXi2wKKjul7tfoOnRImIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765808548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cytt8MrysE13XgN60+kN7Sl5sGdCxWKfzm1WvKB8bcQ=;
 b=S81sv1+O8km3syyl4ENF4AUWhBuDWyRWhLp71IGpf5/slDpG0I7eBQvjmjRp7EF4AbckTf
 jR7J+VkuHRYHcIDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YQFqjkIl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=S81sv1+O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1765808548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cytt8MrysE13XgN60+kN7Sl5sGdCxWKfzm1WvKB8bcQ=;
 b=YQFqjkIlKA6h7e7GzBqOebwOQ1Q8mXk2IyU41I8hmDY2qYYahjBvzDEmJNjU3tofRCq3CW
 Czs0zZUvKQAQ/tT9P5Vnt8YXrs1rjZo09mh3WAOm8yQfie59wqG7+cGTq3FIwzi56zpole
 xb/nPJHPoORXi2wKKjul7tfoOnRImIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1765808548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Cytt8MrysE13XgN60+kN7Sl5sGdCxWKfzm1WvKB8bcQ=;
 b=S81sv1+O8km3syyl4ENF4AUWhBuDWyRWhLp71IGpf5/slDpG0I7eBQvjmjRp7EF4AbckTf
 jR7J+VkuHRYHcIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 584403EA63;
 Mon, 15 Dec 2025 14:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F/2vEqQZQGkZGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Dec 2025 14:22:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 15 Dec 2025 15:22:27 +0100
MIME-Version: 1.0
Message-Id: <20251215-fix_ci-v1-1-792d418fc240@suse.com>
X-B4-Tracking: v=1; b=H4sIAKIZQGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0NT3bTMivjkTF2zFMPUlBQjM0NLixQloOKColSgDNig6NjaWgAxVHx
 6WAAAAA==
X-Change-ID: 20251215-fix_ci-6d1edd26198d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765808548; l=1444;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=mao58lkd0zQsVgrjGK/9+11EGau5GWLKKFcNIhEAq7M=;
 b=FwjZF1ONni6z59zj6O56X2BhWWkNkD4OAvR8rFHEmlo/zxW4fj1efby9n6U1M3wyyQ40k6MDo
 XBIm67EBdlEAIVURgcQiXXtHAiOOEo9r2MRy5Q+aI17bciixOzbIc/u
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,safe.directory:url,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 81E0C5BD29
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ci: fix patch download when using curl
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

curl started to fail on CI after bots have been introduced to verify
that a human is interacting with patchwork. This creates an issue when
we need to download patches, since at the very first redirection we will
miss the server hosting our patches. By using `--location-trusted`, we
trust the bots redirection and we make sure that it's possible to
download the patch which is going to be applied via `git am`.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .github/workflows/ci-docker-build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index 09eb8bb6d446b3e7100f43844942a5dd3976badb..408eb9a69f5cbebf725751633db46169be288bb8 100644
--- a/.github/workflows/ci-docker-build.yml
+++ b/.github/workflows/ci-docker-build.yml
@@ -155,7 +155,7 @@ jobs:
         git config --global --add safe.directory "$GITHUB_WORKSPACE"
 
         git checkout -b review_patch_series_"${{ inputs.SERIES_ID }}"
-        curl -k "${{ inputs.SERIES_MBOX }}" | git am
+        curl -k -L --max-redirs 1 --location-trusted "${{ inputs.SERIES_MBOX }}" | git am
 
         ./ci/tools/patchwork.sh state "${{ inputs.SERIES_ID }}" "needs-review-ack"
 

---
base-commit: d0e0426529619868195ff1dc8decd88c8259090c
change-id: 20251215-fix_ci-6d1edd26198d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
