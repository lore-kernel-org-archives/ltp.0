Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ED8C021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 17:12:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56E903C9A01
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 18:12:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75E473C9948
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 18:11:46 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F05A1142F2F0
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 18:11:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F0B591F441;
 Mon, 24 Feb 2025 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740417105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vGYJwWE+WwcPzAOgqNJEoFlfK2isgDtUhsRsthBa8sQ=;
 b=c0EumIHMy3HjtKjpQ/8rNVlT/KrIof+fS9sccUUvPgMNNf+N7PJkMxMcNKLPGr/fdmZ6dx
 m8va3811GP/mY+tWMRsY27/AH6Cb4eaTMbsaMc7Ah/spegewutBpeMfQDXyYr5mbNQM7CE
 M7eND5rEsK5rEFAOlZEa5EoSJ6PPe1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740417105;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vGYJwWE+WwcPzAOgqNJEoFlfK2isgDtUhsRsthBa8sQ=;
 b=D1GwOp8uYsfq2fKnsqymJu1ja1cKG3Kyh1wbY2rZzhmrnRUCrwwdXetemV8kb+NKUfQxJ1
 rkVfueBxn0VplADg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740417103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vGYJwWE+WwcPzAOgqNJEoFlfK2isgDtUhsRsthBa8sQ=;
 b=iny3GT/H8KNQuimCho4Yg9SfEy/myQy0dCGwoRLrezrDoBsZCFw4Fljeo+dSqSzGF75xo+
 9dcOT6IeKO/GfN5H6NWubl9DAfGR+c7Y31I4SrmUMuBIbczFESIawgrVi57pWjvW5UV3PR
 DdEWQv5bwsw7H99G1MiTj3UyoG8IGjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740417103;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vGYJwWE+WwcPzAOgqNJEoFlfK2isgDtUhsRsthBa8sQ=;
 b=veTi+f02n7oIp3Wsc4G8IbgzPL95HTE/Jw6F6mwNH/Yg8ly5Pz85df5D50ZVoN+7rBoOp8
 trf1vVEyrCrqnCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B885913332;
 Mon, 24 Feb 2025 17:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2gCxKk+ovGf2fAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 24 Feb 2025 17:11:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 24 Feb 2025 18:11:37 +0100
Message-ID: <20250224171137.2893480-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ima_kexec.sh: Detect kernel image from BOOT_IMAGE
 from /proc/cmdline
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

Default value was suitable only for x86_64. This helps to use other
archs on distros which set $BOOT_IMAGE.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: this will not help for non-x86_64 archs on distros which don't
specify BOOT_IMAGE on kernel command line (e.g. aarch64 or ppc64le).
But unless I get report it's needed I'm not going to do detection based
on 'uname -m' or 'ls /boot/*linu*-$(uname -r) | head -1'.

 .../security/integrity/ima/tests/ima_kexec.sh | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 5d178494b7..9093ba2d64 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -42,11 +42,32 @@ measure()
 
 setup()
 {
-	tst_res TINFO "using kernel $IMA_KEXEC_IMAGE"
+	local arch
+
+	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
+		for arg in $(cat /proc/cmdline); do
+			if echo "$arg" |grep -q '^BOOT_IMAGE'; then
+				eval "$arg"
+			fi
+		done
+
+		tst_res TINFO "using as kernel BOOT_IMAGE from /proc/cmdline: '$BOOT_IMAGE'"
+
+		# replace grub partition, e.g. (hd0,gpt2) => /boot
+		if echo "$BOOT_IMAGE" |grep -q '(.d[0-9]'; then
+			echo "$BOOT_IMAGE" | sed 's|(.*,.*)/|/boot/|'
+		fi
+
+		if [ -f "$BOOT_IMAGE" ]; then
+			IMA_KEXEC_IMAGE="$BOOT_IMAGE"
+		fi
+	fi
 
 	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
 		tst_brk TCONF "kernel image not found, specify path in \$IMA_KEXEC_IMAGE"
 	fi
+
+	tst_res TINFO "using kernel $IMA_KEXEC_IMAGE"
 }
 
 kexec_failure_hint()
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
