Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE245C433EF
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 20:30:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94AD63C902D
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 21:30:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 005C63C714C
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 21:30:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0249E60215E
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 21:30:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D865F1FC9E;
 Thu,  2 Dec 2021 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638477013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=47jWJdDUiDy8SmOuEUu3TSqH+Ihelhx5RTrI1Z2Ivoc=;
 b=SNaC02UK/y9rIgL90nz8HqxgN8Ch+fnAqdwct5S2j68gxaT/v9AOCtTC2q/dMiRxuHRYJU
 1WJVyqNxL+PW9ZeQx2uSd/sANmBwYI24GXVP8sl6Pp566MifeOh614QnH+oodvzgfpONAm
 xMMvrqyUNI14836Z7UfCfZJb7BmTiJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638477013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=47jWJdDUiDy8SmOuEUu3TSqH+Ihelhx5RTrI1Z2Ivoc=;
 b=XGSM6uqlzAHeVzaDGj0Z/i6jOeu9bNzZkI8S0pbP8xPxhU6I3XtEkPzR5aV/l5pcrnjH6C
 J66Pgs9AcYpTKCBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B15B613EA5;
 Thu,  2 Dec 2021 20:30:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cjGIKdUsqWEtegAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 02 Dec 2021 20:30:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Dec 2021 21:30:06 +0100
Message-Id: <20211202203006.32259-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] configure.ac: Print summary
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

Due many checks of structs, members etc are chosen testsuites,
presence of used libraries and docparser config results quite hidden.
Print them as summary in the end.

Disadvantage of this is need to keep sync m4 macros with configure.ac
also quite easily results can be misinterpreted.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 configure.ac | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/configure.ac b/configure.ac
index 4751b14d2..063a8a9d1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -381,3 +381,26 @@ test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
 LTP_DETECT_HOST_CPU
 
 AC_OUTPUT
+
+cat << EOF
+
+TESTSUITES
+open posix testsuite: ${with_open_posix_testsuite:-no}
+realtime testsuite: ${with_realtime_testsuite:-no}
+
+LIBRARIES
+keyutils: ${have_keyutils:-no}
+libacl: ${have_libacl:-no}
+libaio: ${have_libaio:-no} (aio: ${have_aio:-no})
+libcap: $cap_libs (newer: ${has_newer_libcap:-no})
+libcrypto: $have_libcrypto (sha: ${have_sha:-no})
+libmnl: ${have_libmnl:-no}
+libnuma: ${have_libnuma:-no} (headers: ${have_numa_headers:-no}, v2 headers: ${have_numa_headers_v2:-no})
+libtirpc: ${have_libtirpc:-no}
+glibc SUN-RPC: ${have_rpc_glibc:-no}
+
+METADATA
+metadata generator: $with_metadata_generator
+HTML metadata: $with_metadata_html
+PDF metadata: $with_metadata_pdf
+EOF
-- 
2.34.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
