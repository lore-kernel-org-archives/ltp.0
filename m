Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25867C4332F
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 11:54:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB85B3CB20D
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED1A43CB1A9
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 13:53:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DA313200ACC
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 13:53:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 039721F8E9;
 Fri, 21 Oct 2022 11:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666353219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdRRMoSzcu3yAxjLXziCxyy9oTh8in3YwMEDehHW1jA=;
 b=Vy8tcnbdIkvvYG60aLgmz+wdKM/ZR3subw+NAYH9vQmwHrT2N9te+hQXT1+TrzX8yp9tYK
 RkLCRGfWzkqFhq5wuuLN+PuU8OWIS843MEptVBAm/RLIK3EwZBJfNAncAQSp5UraZSYWrh
 LaJVTLftUkSqTG7ir3e3Ftvm+fn+xUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666353219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdRRMoSzcu3yAxjLXziCxyy9oTh8in3YwMEDehHW1jA=;
 b=lF9xZ0KMWvouRf2bC4Q3tHMotJ0+810Acgus93caC8h2VoBXk9XnC+g334st+oUX9hFzlq
 pYvxa/INxy5FnUAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D05A813A0E;
 Fri, 21 Oct 2022 11:53:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yGkzMUKIUmOdTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Oct 2022 11:53:38 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 21 Oct 2022 13:53:31 +0200
Message-Id: <20221021115333.13725-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221021115333.13725-1-pvorel@suse.cz>
References: <20221021115333.13725-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] Makefile: set LC_ALL and LANG to C
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

* have reproducible builds (no locale dependencies)
* English only output - easier to debug problem

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: if we want to have only reproducible build, but keep localized
messages, we could use kernel approach:
unexport LC_ALL
LC_COLLATE=C
LC_NUMERIC=C
export LC_COLLATE LC_NUMERIC

They deliberately kept LC_CTYPE to have localized messages.

See also
c051346b7db2 ("Makefile: set LC_CTYPE, LC_COLLATE, LC_NUMERIC to C")
07105202bdeb ("Makefile: do not override LC_CTYPE")

 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index d4399bae6..ea11ac7f3 100644
--- a/Makefile
+++ b/Makefile
@@ -21,6 +21,10 @@
 # Ngie Cooper, July 2009
 #
 
+# Avoid funny character set dependencies
+export LANG=C
+export LC_ALL=C
+
 top_srcdir		?= $(CURDIR)
 
 include $(top_srcdir)/include/mk/env_pre.mk
-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
