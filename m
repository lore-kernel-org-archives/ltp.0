Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86EFECD6C4
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 16:07:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CEAC3CEE98
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 17:06:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C756D3CACFD
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 17:06:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F6E91A00921
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 17:06:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A49845BDDD;
 Wed, 11 Feb 2026 16:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770825998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=47hTrsUwJs+/aVyKKwMjM8AIq8wc+V7yTvQSS4wPJ0Q=;
 b=xlaCfnjadeYeNXMV/T6rTbl5Z96hGxKxKm0MVapvtHfrKT/z7GHmDn+0cb0I1LJHweweZ1
 NUacWuUls35Ymuu9jUOWFR41fPj0nJgMQbUvASBw8m5tnX8jVqn1LsT/kjZnsQ27PWA3c4
 Wpsaj1aETLKzN40qZFdWbBHQLdxaIxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770825998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=47hTrsUwJs+/aVyKKwMjM8AIq8wc+V7yTvQSS4wPJ0Q=;
 b=SaoLtloREZW4gOP/ZlN/b/VIPOB1AYI3VjaNRgGJcwxxr3rETvw7PNCHsdsbEpZGTcTJ7y
 pFbQqhR6zI0bYxAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770825998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=47hTrsUwJs+/aVyKKwMjM8AIq8wc+V7yTvQSS4wPJ0Q=;
 b=xlaCfnjadeYeNXMV/T6rTbl5Z96hGxKxKm0MVapvtHfrKT/z7GHmDn+0cb0I1LJHweweZ1
 NUacWuUls35Ymuu9jUOWFR41fPj0nJgMQbUvASBw8m5tnX8jVqn1LsT/kjZnsQ27PWA3c4
 Wpsaj1aETLKzN40qZFdWbBHQLdxaIxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770825998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=47hTrsUwJs+/aVyKKwMjM8AIq8wc+V7yTvQSS4wPJ0Q=;
 b=SaoLtloREZW4gOP/ZlN/b/VIPOB1AYI3VjaNRgGJcwxxr3rETvw7PNCHsdsbEpZGTcTJ7y
 pFbQqhR6zI0bYxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E9E743EA62;
 Wed, 11 Feb 2026 16:06:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R+HmKg2pjGmaHAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 11 Feb 2026 16:06:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 11 Feb 2026 17:06:34 +0100
MIME-Version: 1.0
Message-Id: <20260211-fix_doc_build-v1-1-42897785e0c7@suse.com>
X-B4-Tracking: v=1; b=H4sIAAqpjGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0ND3bTMiviU/OT4pNLMnBRdQwMLA8sUizQz4xRzJaCegqJUoAKwedG
 xtbUAaTZcgV8AAAA=
X-Change-ID: 20260211-fix_doc_build-10809d8f63d7
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770825997; l=969;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=k+csePspl+l35Z1YE2js1/TcOtCYkaengq6g8USFxEs=;
 b=bVVfyDBjGUtTbj7+gS6zanToEik7zT2sH7kJc+cDjDsSXSfa2/Kfrr6zrJ9OQw9QlU414rMPV
 Zz2zPzX0PzDDR4UV5Snu31XwmkYdrBwPQK8fuT/Kz99wMPZsVS6+CaQ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: fix documentation build with latest setuptools
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

Force setuptools to version 81.0.0, which is the last one where linuxdoc
still can be installed. Also, from python 3.12 setuptools is not
available anymore when creating a new virtualenv, so we need to force
its installation to ensure that documentation will be built.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Link: https://docs.python.org/3/whatsnew/3.12.html
---
 doc/requirements.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/requirements.txt b/doc/requirements.txt
index ed9e31601da3e0bd3b88c1cf682a68f22da0f9cd..dba3baeba5aedb81f420a8f13134af8dba2d553d 100644
--- a/doc/requirements.txt
+++ b/doc/requirements.txt
@@ -5,3 +5,5 @@ sphinx-rtd-theme==2.0.0
 
 linuxdoc==20240924
 sphinxcontrib-spelling==7.7.0
+
+setuptools==81.0.0

---
base-commit: f9c96b60dfcc227bc7b3052d666540a7d84d949a
change-id: 20260211-fix_doc_build-10809d8f63d7

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
