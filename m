Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A07CC021A9
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 13:09:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C81C93C9CB4
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 14:09:48 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 729343C9BD5
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:09:21 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 73CAB14867E2
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:08:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C36321114;
 Mon, 17 Feb 2025 13:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739797730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jkZIbwI30YCvku0BCw8K+GbkEBvctLl3zwPxcJYilgM=;
 b=rtPbUbq5KWRpJlmRg2cV8myqojYTzVBJgMfftOZehjaL3VgOiXgzWMeonqik7ugM/QC5GB
 GFLxru3dg+J2aymnVNrR2AwkfoN8E/0A4WaSKlU3K0DbZ1xZaElFGTtHyo/xKJZXgvzgSm
 qpzoUyYFdzFqNi4uBctSMTqAPAI508A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739797730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jkZIbwI30YCvku0BCw8K+GbkEBvctLl3zwPxcJYilgM=;
 b=OHod0wQs42y+kw7Opruz9Q/r4RoV5rKHYgGh9IUAwdm1uqU6QjMy3z080A7pZ5CzWqsQBo
 wMfkuhLHlgYTY9BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739797730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jkZIbwI30YCvku0BCw8K+GbkEBvctLl3zwPxcJYilgM=;
 b=rtPbUbq5KWRpJlmRg2cV8myqojYTzVBJgMfftOZehjaL3VgOiXgzWMeonqik7ugM/QC5GB
 GFLxru3dg+J2aymnVNrR2AwkfoN8E/0A4WaSKlU3K0DbZ1xZaElFGTtHyo/xKJZXgvzgSm
 qpzoUyYFdzFqNi4uBctSMTqAPAI508A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739797730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jkZIbwI30YCvku0BCw8K+GbkEBvctLl3zwPxcJYilgM=;
 b=OHod0wQs42y+kw7Opruz9Q/r4RoV5rKHYgGh9IUAwdm1uqU6QjMy3z080A7pZ5CzWqsQBo
 wMfkuhLHlgYTY9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58D441379D;
 Mon, 17 Feb 2025 13:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HZWaFOI0s2fvBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Feb 2025 13:08:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 17 Feb 2025 14:08:38 +0100
Message-ID: <20250217130839.2392666-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_security.sh: Fix SELinux detection
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

Some SLES15 versions create /selinux directory which fails the detection
if SELinux is actually not enabled. Therefore detect if directory
actually contains the 'enforce' file.

Also drop /selinux directory detection and detect only /sys/fs/selinux,
/sys/fs/selinux mount point was added in kernel 3.0 in commit
7a627e3b9a2b ("SELINUX: add /sys/fs/selinux mount point to put selinuxfs")
14 years is enough, kernel 3.0 is not even supported in current LTP and
we don't even support /selinux in C API (tst_security.c).

Fixes: e7b804df65 ("shell: Add tst_security.sh helper")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_security.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
index 05640234ea..356c28fc73 100644
--- a/testcases/lib/tst_security.sh
+++ b/testcases/lib/tst_security.sh
@@ -127,8 +127,7 @@ tst_get_selinux_dir()
 {
 	local dir="/sys/fs/selinux"
 
-	[ -d "$dir" ] || dir="/selinux"
-	[ -d "$dir" ] && echo "$dir"
+	[ -f "$dir/enforce" ] && echo "$dir"
 }
 
 # Get SELinux enforce file path
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
