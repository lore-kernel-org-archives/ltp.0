Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08098CAC592
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 10:39:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 676683CC05E
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 12:39:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 227AD3CC05E
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 12:39:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8DD052009A5
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 12:39:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF02F1FF34;
 Mon, 22 Sep 2025 10:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758537579; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=53OqcTGJwIJHDQvX9TYhBXTI8ZSo5fWiVtrzVPCueUI=;
 b=eJwnRfR0faGhCvyMq34MGsHy/FEHb/Lf310DZWGjniNSjXxkQWy5ybeBrIZ4qhtzGuaxMa
 lugdIJML654ry1YE8Q9XYCJrXX7kGhFLiy8Ahr+YLVLAVbKRCHLsCcEyxT/LpsZrpTYK9x
 XoYoZxmbe/Ksk1zcbP6LeqvqONRMlfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758537579;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=53OqcTGJwIJHDQvX9TYhBXTI8ZSo5fWiVtrzVPCueUI=;
 b=b0XTQt9ZTa2cBon5Nm/QJBpJCuzJ6CXRubQEnYzAj9dYiiaPv5+d6yK/shkos+B7elI174
 a3OFHtggpPpzMeCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iA2phKGy;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RAcwbYvz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758537577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=53OqcTGJwIJHDQvX9TYhBXTI8ZSo5fWiVtrzVPCueUI=;
 b=iA2phKGy0DqRyPjcdDFM7XdfDZezvbzaMXKuADn0+DjKEIJ8iKyENdWxbqyNt6OTJd5tr1
 jMnCUhFyi1r0oOFm49/xoDVlhV7DPLV7h82RjuCe42VHyhtFNq8eYYyTjYWNNo8fusWAyK
 /iVh2IIaDiacmKit+6uxNtIGeiMgeOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758537577;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=53OqcTGJwIJHDQvX9TYhBXTI8ZSo5fWiVtrzVPCueUI=;
 b=RAcwbYvzzQrJiRDTbVlVv91eX01WX1VzkpZExCR3ToUBwNrK526xtWtTOugpYBAANr9C+X
 4h4KqcZSVdB6z5AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B80A11388C;
 Mon, 22 Sep 2025 10:39:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sR/+J2kn0WgCQQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Sep 2025 10:39:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Sep 2025 12:39:36 +0200
MIME-Version: 1.0
Message-Id: <20250922-kirk_2-3-v1-1-af3fc729bbdf@suse.com>
X-B4-Tracking: v=1; b=H4sIAGgn0WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyMj3ezMoux4I11jXWPDFNPUtGQLA0PzRCWg8oKi1LTMCrBR0bG1tQC
 cx2NYWgAAAA==
X-Change-ID: 20250922-kirk_2-3-31d5efc8017a
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758537577; l=615;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=eMREXlFR2Ie73dWkwQWZ+qNmiLX1Rq7a5rbn/9H2la4=;
 b=TzYytaxO7iejxmOst/Q+Wr38J0BjoPhaCurOoK8OO0gitzmHHNIFzyumRdSMfnKprku3UodL9
 bViALA5Dq/SD/5x4zNYqMmfgdMO2FtAiHp2Kq9F6qXLbzrnRjLfiKlZ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: EF02F1FF34
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kirk: upgrade to v2.3
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
 tools/kirk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk b/tools/kirk
index 20b1870b964c9b8b83aa0a9cc860a5bbd146559c..2b5d0be7f0cddfc05d9c606656219c7a0326512c 160000
--- a/tools/kirk
+++ b/tools/kirk
@@ -1 +1 @@
-Subproject commit 20b1870b964c9b8b83aa0a9cc860a5bbd146559c
+Subproject commit 2b5d0be7f0cddfc05d9c606656219c7a0326512c

---
base-commit: 2f208c00cfc4a1d7d5d957ac2b866e1248623aa6
change-id: 20250922-kirk_2-3-31d5efc8017a

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
