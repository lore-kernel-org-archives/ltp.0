Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC75C02194
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 10:56:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA7593C9378
	for <ltp@archiver.kernel.org>; Fri,  7 Feb 2025 11:56:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5932C3C2F48
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 11:56:04 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 00BC120A082
 for <ltp@lists.linux.it>; Fri,  7 Feb 2025 11:56:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 324E81F397;
 Fri,  7 Feb 2025 10:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738925763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kR00DMFA9Q4e+x/1yaoeh0hH8ayrfPEYY4Qh/a2HMg=;
 b=Lo1SFNKY1PlTuBpskHHUUljOXuOETv1qHuh+Ngn1UXdqcxb1FNaC3fng/zYZ4YeaQSc9H8
 2iVeaZU98Vss09OZUI27JXZy6MjT/Qo+dQ7deivqsczwHiZ5sBTb+nN9J1NM7MgAo7KUhT
 2AoSXzRf4P+MFVj9pZeOmwNY6zU16dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738925763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kR00DMFA9Q4e+x/1yaoeh0hH8ayrfPEYY4Qh/a2HMg=;
 b=J9OiVncVuCFESXu/AmM9o3mE8/1N7e5SCaCTSzPsrk/NswRWMPovvt1dgU9+oVc1eGYBaS
 xJNDVRNV1T4NsICw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738925763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kR00DMFA9Q4e+x/1yaoeh0hH8ayrfPEYY4Qh/a2HMg=;
 b=Lo1SFNKY1PlTuBpskHHUUljOXuOETv1qHuh+Ngn1UXdqcxb1FNaC3fng/zYZ4YeaQSc9H8
 2iVeaZU98Vss09OZUI27JXZy6MjT/Qo+dQ7deivqsczwHiZ5sBTb+nN9J1NM7MgAo7KUhT
 2AoSXzRf4P+MFVj9pZeOmwNY6zU16dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738925763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kR00DMFA9Q4e+x/1yaoeh0hH8ayrfPEYY4Qh/a2HMg=;
 b=J9OiVncVuCFESXu/AmM9o3mE8/1N7e5SCaCTSzPsrk/NswRWMPovvt1dgU9+oVc1eGYBaS
 xJNDVRNV1T4NsICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F58413AC0;
 Fri,  7 Feb 2025 10:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yFi+AsPmpWddeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Feb 2025 10:56:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  7 Feb 2025 11:55:46 +0100
Message-ID: <20250207105551.1736356-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250207105551.1736356-1-pvorel@suse.cz>
References: <20250207105551.1736356-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] create-tarballs-metadata.sh: Remove metadata
 generation
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

1bf344a3db started to generate test catalog as part of online sphinx
documentation, which replaces metadata generation done with
asciidoc{,tor} and docparse/testinfo.pl.

This means that whole docparse/ will be deleted, but tools in metadata/
will stay (JSON is input also for sphinx).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/create-tarballs-metadata.sh | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/create-tarballs-metadata.sh b/tools/create-tarballs-metadata.sh
index d0b9d0d97b..227f7e69f8 100755
--- a/tools/create-tarballs-metadata.sh
+++ b/tools/create-tarballs-metadata.sh
@@ -1,7 +1,7 @@
 #!/bin/sh -eu
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
-# Create tarballs and metadata for uploading after tagging release.
+# Create tarballs for uploading after tagging release.
 # https://github.com/linux-test-project/ltp/wiki/LTP-Release-Procedure
 
 basedir="$(dirname "$0")"
@@ -47,11 +47,4 @@ for alg in $checksums; do
 	done
 done
 
-# metadata documentation
-title "Generate metadata documentation"
-cd $tarball_dir
-rod ./configure --with-metadata-generator=asciidoctor
-rod make -C metadata
-cp -v docparse/metadata.html $dir/metadata.$tag.html
-
 echo "Generated files are in '$dir', upload them to github"
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
