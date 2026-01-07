Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6767CCFD65A
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D5ED3C319F
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 16:58:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DFF33C4C05
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 16:57:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A5D5360078F
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 16:57:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B2685C1E5;
 Wed,  7 Jan 2026 15:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767801460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sQ5YAFSHlfq3pMQbXbjIJxX9rfXQL3Q34iK01hGHpWg=;
 b=x/oZaCg8RLunLEe3543B6Q0TvbaNJUfpKpuIweWRvv2HW5v+t1pauQ7rIlH6cnyE78v7tC
 zJAaersM96ogyAIUB93jjVoMdIpP2C60iSYnmXyfcJ8OeZlBY31ZsOMw/nA2ZjUa0kjlcZ
 Hfhop4IidhOmVi8HGuUZkYEiUzuG0PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767801460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sQ5YAFSHlfq3pMQbXbjIJxX9rfXQL3Q34iK01hGHpWg=;
 b=+3wgXU4FV0qw5mZND1xAQo2E/4cuW723OSIkN2VWv8cQJDTDo2gHF03cyWA68W0DDqzYan
 81LfHcrHrfHOqWCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="x/oZaCg8";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+3wgXU4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767801460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sQ5YAFSHlfq3pMQbXbjIJxX9rfXQL3Q34iK01hGHpWg=;
 b=x/oZaCg8RLunLEe3543B6Q0TvbaNJUfpKpuIweWRvv2HW5v+t1pauQ7rIlH6cnyE78v7tC
 zJAaersM96ogyAIUB93jjVoMdIpP2C60iSYnmXyfcJ8OeZlBY31ZsOMw/nA2ZjUa0kjlcZ
 Hfhop4IidhOmVi8HGuUZkYEiUzuG0PY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767801460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sQ5YAFSHlfq3pMQbXbjIJxX9rfXQL3Q34iK01hGHpWg=;
 b=+3wgXU4FV0qw5mZND1xAQo2E/4cuW723OSIkN2VWv8cQJDTDo2gHF03cyWA68W0DDqzYan
 81LfHcrHrfHOqWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07D1E3EA63;
 Wed,  7 Jan 2026 15:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GUDlOHOCXmm9HQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 15:57:39 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Jan 2026 16:57:35 +0100
Message-ID: <20260107155737.791588-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:email, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6B2685C1E5
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] ima_kexec.sh: Detect kernel image
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Sometimes BOOT_IMAGE contains partition which does not point to /boot
e.g. BOOT_IMAGE=(hd0,gpt1)/opensuse-tumbleweed/6.18.3-1-default/linux-30afdbce3ab6d0eff8f42b71df1a66f4baf2daf8
on Tumbleweed aarch64. Therefore detect common kernel image paths.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_kexec.sh | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index d6eb0829d8..7688690af2 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -42,7 +42,7 @@ measure()
 
 setup()
 {
-	local arch
+	local arch f uname
 
 	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
 		for arg in $(cat /proc/cmdline); do
@@ -63,6 +63,32 @@ setup()
 		fi
 	fi
 
+	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
+		uname="$(uname -r)"
+
+		# x86_64
+		f="/boot/vmlinuz-$uname"
+
+		# ppc64le, s390x
+		if [ ! -f "$f" ]; then
+			f="/boot/vmlinux-$uname"
+		fi
+
+		# aarch64
+		if [ ! -f "$f" ]; then
+			f="/boot/Image-$uname"
+		fi
+
+		# aarch64 often uses compression
+		if [ ! -f "$f" ]; then
+			f="$(ls /boot/Image-$uname.* || true)"
+		fi
+
+		if [ -f "$f" ]; then
+			IMA_KEXEC_IMAGE="$f"
+		fi
+	fi
+
 	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
 		tst_brk TCONF "kernel image not found, specify path in \$IMA_KEXEC_IMAGE"
 	fi
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
