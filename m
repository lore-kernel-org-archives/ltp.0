Return-Path: <SRS0=uAqx=PY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363EFC433F5
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 11:22:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61ECC61252
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 11:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61ECC61252
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E7EE3C757D
	for <ltp@archiver.kernel.org>; Fri,  5 Nov 2021 12:22:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 852593C55CE
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 12:22:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8D7660121B
 for <ltp@lists.linux.it>; Fri,  5 Nov 2021 12:22:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F03C91FD47;
 Fri,  5 Nov 2021 11:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636111356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zex7vbEu9624CRrUqrKCzY85uDm2Va+aLYUjxDF93Hs=;
 b=KXIa6+SYFj9P41TvzTvyaZgcQfwxF15b2HQ2acUyUrHOhPRWbjjSRYgYXKh+nFWtcwwsKZ
 VMx0fFSUYGr3/HQDiHPZKnSelqWzgpzpfZxn+pYKMxBeb6fExTKa3CHXfXZZQnqwZx7Iup
 GPwMXhlzz9jpgRuTKoyvE1vaYf/54i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636111356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zex7vbEu9624CRrUqrKCzY85uDm2Va+aLYUjxDF93Hs=;
 b=0gSN/VDKlotxY4nboEtlDcLgtPTm3RV56smXUsSE8aS/mTglgKGbHK134pfoOa/wiYwWL0
 6LNbgvInEZ7v5iDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C212413B97;
 Fri,  5 Nov 2021 11:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id byKULfwThWFeJAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 11:22:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  5 Nov 2021 12:22:32 +0100
Message-Id: <20211105112232.15537-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] make: Add test-metadata target
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

And run it as part of make test.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Cyril,

I slightly modified source, thus sent to ML.

Kind regards,
Petr

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 63010d531..a94e0da9a 100644
--- a/Makefile
+++ b/Makefile
@@ -207,6 +207,7 @@ ifneq ($(build),$(host))
 	$(error running tests on cross-compile build not supported)
 endif
 	$(call _test)
+	$(MAKE) test-metadata
 
 test-c: lib-all
 ifneq ($(build),$(host))
@@ -220,6 +221,9 @@ ifneq ($(build),$(host))
 endif
 	$(call _test,-s)
 
+test-metadata:
+	$(MAKE) -C $(abs_srcdir)/metadata/ test
+
 ## Help
 .PHONY: help
 help:
-- 
2.33.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
