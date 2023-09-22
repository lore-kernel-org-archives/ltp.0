Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9B2CD4F27
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 07:42:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AA323CDE52
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 09:42:46 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE47F3CA21C
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 09:42:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F11D520091A
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 09:42:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 009891F45B
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 07:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695368542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btObWyCYdg1ec8AcjxtTDftOvutxpV6izjAti4cwseQ=;
 b=AXkELtUmYD0QqOc3wxWyGoDULD3iiJSw04bK/SM0pp2jwi3FV9dVSDYrR4X/V+deO1lIhk
 pRX8iI7WC74pSCEVlZVgnfMHKXMWSSFosSW2+zFWE3f+rtIQnBeohc4tykjwCenAAKJdPn
 /T3l7WkKQ6xPdIGZZ9u25GGeQbSHQko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695368542;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btObWyCYdg1ec8AcjxtTDftOvutxpV6izjAti4cwseQ=;
 b=yIW0ND/Tk2BsnnYQRYbSAf5OimZQ8fB3oSjnXky/Amgykc6pP4YeL/Hqv65Ljbr6w+N3mL
 urlRceMSuvBXiJAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0D4E13478
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 07:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uP3hNV1FDWWHJQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 07:42:21 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 22 Sep 2023 09:42:16 +0200
Message-ID: <20230922074220.12913-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230922074220.12913-1-mdoucha@suse.cz>
References: <20230922074220.12913-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] Fix shell library secureboot and lockdown helpers
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

Negative return value from the helper functions means no check could be
performend. Only positive return value indicates that secureboot/lockdown
is active.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/lib/tst_lockdown_enabled.c   | 2 +-
 testcases/lib/tst_secureboot_enabled.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_lockdown_enabled.c b/testcases/lib/tst_lockdown_enabled.c
index 0e40c428c..30abe3e5e 100644
--- a/testcases/lib/tst_lockdown_enabled.c
+++ b/testcases/lib/tst_lockdown_enabled.c
@@ -8,5 +8,5 @@
 
 int main(void)
 {
-	return !tst_lockdown_enabled();
+	return tst_lockdown_enabled() <= 0;
 }
diff --git a/testcases/lib/tst_secureboot_enabled.c b/testcases/lib/tst_secureboot_enabled.c
index 7c26fb118..dadc0413c 100644
--- a/testcases/lib/tst_secureboot_enabled.c
+++ b/testcases/lib/tst_secureboot_enabled.c
@@ -8,5 +8,5 @@
 
 int main(void)
 {
-	return !tst_secureboot_enabled();
+	return tst_secureboot_enabled() <= 0;
 }
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
