Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BD0C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 12:55:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62A1A3C954D
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 13:55:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7ABD93C8849
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 13:55:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 76C7C2005C3
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 13:55:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DE001F3D2;
 Fri, 14 Jan 2022 12:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642164918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OXlQBPyEsFoXEApGaQXdhNDlo+VQ/X/FcwYA0w8+oKc=;
 b=ac7bc0PmZnFmSIYk3hSjDCLV+AOMj71spz00C1trhSHPro18+V+A01ejkIGcqwq5hk/t4i
 B5nwCfr0idHTXUOwyzle7bSHa5GiFID9stzCtcvWjSzLPEz9jpKSJ97N64/QUK4FamkgnN
 nlsRpxiX3DZ1WGf6vEYU8wuGE3LIzUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642164918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OXlQBPyEsFoXEApGaQXdhNDlo+VQ/X/FcwYA0w8+oKc=;
 b=6/ndwyXf1k9DNR9/NMCxanlAQfxKvJxlkQyp0fr23o61Ef76L0mKiKzJ7Suc0kIVCsl8fq
 V81vMaJs6vW5vWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7427313BF9;
 Fri, 14 Jan 2022 12:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tg+XGrZy4WFzegAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 12:55:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Jan 2022 13:55:13 +0100
Message-Id: <20220114125513.895-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] configure.ac: Fix summary for disabled metadata
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

Previously with --disable-metadata output didn't mention that metadata
are disabled and printed config which was not used. Now:

$ ./configure --disable-metadata
...
METADATA
metadata disabled

$ ./configure
...
METADATA
metadata generator: asciidoctor
HTML metadata: yes
PDF metadata: no

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 3c56d19224..5b9e3c1781 100644
--- a/configure.ac
+++ b/configure.ac
@@ -404,7 +404,14 @@ libtirpc: ${have_libtirpc:-no}
 glibc SUN-RPC: ${have_rpc_glibc:-no}
 
 METADATA
+EOF
+
+if test "x$enable_metadata" = xyes; then
+cat << EOF
 metadata generator: $with_metadata_generator
 HTML metadata: $with_metadata_html
 PDF metadata: $with_metadata_pdf
 EOF
+else
+echo metadata disabled
+fi
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
