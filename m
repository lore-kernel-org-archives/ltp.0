Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FF5CDB474
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 11:09:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C1423CEDC0
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 13:09:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D8043CD00B
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 13:09:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2E669610230
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 13:09:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3417021A37;
 Fri, 20 Oct 2023 11:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697800162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TD4I+VrgqsGL3cdpUky4HV/qhSfh3mr7TJArR6tuqAg=;
 b=KoxZdWLFRIUFXL8Vd6lQnhHcHTDSLqRN3kUEN6DbTc8DbUK7cRIHlI95tNnZCXJaPhkMOY
 nPT8wzUQTJZv0xgGHeNcEpXe9bbnwnG+XC+1c1Rq6AdaEZqF8LjfPbIJY0gvng55esVOsu
 cTmVZjVNogRu8AycPkm87WOkzxPoZ/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697800162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TD4I+VrgqsGL3cdpUky4HV/qhSfh3mr7TJArR6tuqAg=;
 b=yt+3M1rOKxAGax/w15WikYyxqHF/n9ZZitRx8+gKMOGfWm88Y8S6wsY8iK0/dPDC+sqnUR
 DlVUdSM4VxzggxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB1E6138E2;
 Fri, 20 Oct 2023 11:09:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qhONMeFfMmXZZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 Oct 2023 11:09:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 20 Oct 2023 13:09:17 +0200
Message-ID: <20231020110918.26066-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.08 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.98)[99.89%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lapi/{socket,
 tcp}.h: Add fallback definition for setsockopt10.c
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Both SOL_TLS and TCP_ULP definitions are from Linux 4.13, it were added
in glibc 2.27.  We still support compiling on older glibc, thus add this
definition.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/socket.h | 4 ++++
 include/lapi/tcp.h    | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index 794dee49f..23e7ba6cf 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -62,6 +62,10 @@
 # define SOL_ALG		279
 #endif
 
+#ifndef SOL_TLS
+# define SOL_TLS         282
+#endif
+
 #ifndef HAVE_STRUCT_MMSGHDR
 struct mmsghdr {
 	struct msghdr msg_hdr;
diff --git a/include/lapi/tcp.h b/include/lapi/tcp.h
index bb98f28f0..87c5636f6 100644
--- a/include/lapi/tcp.h
+++ b/include/lapi/tcp.h
@@ -12,6 +12,10 @@
 # define TCP_FASTOPEN	23
 #endif
 
+#ifndef TCP_ULP
+# define TCP_ULP          31
+#endif
+
 #ifndef TCP_FASTOPEN_CONNECT
 # define TCP_FASTOPEN_CONNECT	30	/* Attempt FastOpen with connect */
 #endif
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
