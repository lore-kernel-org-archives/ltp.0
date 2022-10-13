Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BF7C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 08:23:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16DEA3CAEB2
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 10:23:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 307CE3C04D1
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 10:23:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B9DAD601476
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 10:23:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 764132208F;
 Thu, 13 Oct 2022 08:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1665649382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahxKkf+bJF2XSuBbb2OaWY3OcobSYzRRqO5vc74FPx8=;
 b=Foa1pgIWMP+tPWS0xgQx3a/MIg8OeBq/7la6vBZzUQEjWPScIkhMYiFszCaVCAK5YLRQP+
 JE3BiD7i4eWkJrnbEGeHH8/FVM0vYqeo4Mg4ijw9i0V5Au6X2AruGxDa9bJTilMA3g7SEG
 TboU+xOKZ2M7o9iW+r4/of5hJRulCJ8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37D7A13AAA;
 Thu, 13 Oct 2022 08:23:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +I/CCubKR2POZQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 13 Oct 2022 08:23:02 +0000
To: ltp@lists.linux.it
Date: Thu, 13 Oct 2022 10:21:46 +0200
Message-Id: <20221013082146.14581-4-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221013082146.14581-1-andrea.cervesato@suse.com>
References: <20221013082146.14581-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/2] Merge ltp-aio-stress part2 with part1
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ltp-aio-stress.part[12] have been merged due to tests duplication and
new ltp-aio-stress test rewrite that doesn't require $TMPDIR parameter
anymore.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/{ltp-aio-stress.part1 => ltp-aio-stress} |  3 +++
 runtest/ltp-aio-stress.part2                     | 11 -----------
 2 files changed, 3 insertions(+), 11 deletions(-)
 rename runtest/{ltp-aio-stress.part1 => ltp-aio-stress} (94%)
 delete mode 100644 runtest/ltp-aio-stress.part2

diff --git a/runtest/ltp-aio-stress.part1 b/runtest/ltp-aio-stress
similarity index 94%
rename from runtest/ltp-aio-stress.part1
rename to runtest/ltp-aio-stress
index c389a039d..4b0b81ce2 100644
--- a/runtest/ltp-aio-stress.part1
+++ b/runtest/ltp-aio-stress
@@ -50,3 +50,6 @@ ADS1047 aio-stress -o1 -O -r32 -t8 -f8
 ADS1048 aio-stress -o1 -O -r64 -t8 -f8
 ADS1049 aio-stress -o1 -O -r128 -t8 -f8
 ADS1050 aio-stress -o1 -O -r256 -t2 -f2
+ADS1051 aio-stress -o3 -r8 -t2 -f2
+ADS1052 aio-stress -o3 -r16 -t2 -f2
+ADS1053 aio-stress -o3 -r32 -t4 -f4
diff --git a/runtest/ltp-aio-stress.part2 b/runtest/ltp-aio-stress.part2
deleted file mode 100644
index e8ac60743..000000000
--- a/runtest/ltp-aio-stress.part2
+++ /dev/null
@@ -1,11 +0,0 @@
-# ltp A-sync IO Stress IO tests
-# ADS2001 aio-stress -o2 -r32 -t2 -f2
-ADS2002 aio-stress -o3 -r8 -t2 -f2
-ADS2003 aio-stress -o3 -r16 -t2 -f2
-ADS2004 aio-stress -o3 -r32 -t4 -f4
-# ADS2005 aio-stress -o3 -r64 -t4 -f4
-# ADS2006 aio-stress -o2 -O -r32 -t2 -f2
-# ADS2007 aio-stress -o3 -O -r8 -t2 -f2
-# ADS2008 aio-stress -o3 -O -r16 -t2 -f2
-# ADS2009 aio-stress -o3 -O -r32 -t4 -f4
-# ADS2010 aio-stress -o3 -O -r64 -t4 -f4
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
