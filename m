Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187C0EB64D9
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 11:35:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6731E3CB88C
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 13:35:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A1A83C9C7B
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 13:35:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EE7106003FD
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 13:35:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E4BE1F88F;
 Mon, 19 Jun 2023 11:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687174536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=un7TD4Do28g9E8BYkegFf3Qo0OTx1x8TlVW7QLniAWU=;
 b=viV1gGm5EAaikrxvhnYm6vRtH1rP9E3rgcFsN9v5sGqoG8DhEwbH/qB8VRtUtII6DeG98O
 bxfO4aBqT0dcAr4JDMnnCVku6mWuvSwDEqTZWG+cfGfHltcleguoh0gs66FcsUUKbt8i6z
 NJLh80FU5t0E1bUQm2jZyT6AJ9wxYGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687174536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=un7TD4Do28g9E8BYkegFf3Qo0OTx1x8TlVW7QLniAWU=;
 b=Rg7SBh4F4nZh61x2ED2z2v6YMWI9mHdk2zQ5UlRl1JPt/Zbq/dnWY1wMEBuos6UPpGF06Y
 Jx9UmV9AQT9VEFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3726138E8;
 Mon, 19 Jun 2023 11:35:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +yp0OYc9kGRRXAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 19 Jun 2023 11:35:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 19 Jun 2023 13:35:30 +0200
Message-Id: <20230619113530.136332-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ci/debian.sh: Install docbook2x
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

asciidoc-dblatex dependency is no longer enough for Debian 11 bullseye
(the new Debian oldstable), generating html with asciidoc otherwise fails:

$ cd metadata && make
error : Unknown IO error
warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl"
compilation error: file /etc/asciidoc/docbook-xsl/xhtml.xsl line 12 element import
xsl:import : unable to load http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ci/debian.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/debian.sh b/ci/debian.sh
index da92337fb..7b0361100 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -49,6 +49,6 @@ $apt \
 	pkg-config
 
 $apt ruby-asciidoctor-pdf || true
-$apt asciidoc-dblatex || true
+$apt asciidoc-dblatex docbook2x || true
 
 df -hT
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
