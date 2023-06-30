Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6FBEB64DA
	for <ltp@archiver.kernel.org>; Fri, 30 Jun 2023 19:38:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFF5B3CC2E2
	for <ltp@archiver.kernel.org>; Fri, 30 Jun 2023 21:38:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 759263CC286
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 21:38:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1969B10009C3
 for <ltp@lists.linux.it>; Fri, 30 Jun 2023 21:38:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45E0621867;
 Fri, 30 Jun 2023 19:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688153883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wwQ7cM0BK7yVg5yQ8b9GI1dx4xcQ+YC6psSAttdDTAQ=;
 b=w341/SmOTGVuEv2cUGsszVjM+BWIVz7OJXZVhQKIChUXu17XCzM8ZR2j/HeWYorBzz1+iM
 j2uDjIjB+d1l2ZMUtA3MEZ9Axi5b2GbyfbfgGUOsnXysQLVACXwsHhxrM3/0NPxye4oN7I
 lp/XkzXqqBfZP2+MxO7GsVRI1QcnqKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688153883;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wwQ7cM0BK7yVg5yQ8b9GI1dx4xcQ+YC6psSAttdDTAQ=;
 b=5+qmeUI5/pEdsAf/kf1D8kPDTMupAapxsJqRSSy9+5I+xMbdVs3Wl/Iy6GQqmIaFKHRDi4
 HSLq12oqeoOuNaDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 212FD13915;
 Fri, 30 Jun 2023 19:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kDZ4BRsvn2SYAgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Jun 2023 19:38:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 30 Jun 2023 21:37:42 +0200
Message-Id: <20230630193742.310416-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED][PATCH 1/1] runtest: Move fanotify23 from staging
 to syscalls
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

fanotify23 is a test for FAN_MARK_EVICTABLE, prepared for v5.19-rc1.
We forget to move it after v5.19 being released.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Obviously we forget to check the file after several kernel releases :(.
I'm sorry.

Kind regards,
Petr

 runtest/staging  | 1 -
 runtest/syscalls | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/staging b/runtest/staging
index 88dcea79b..ef1cdea15 100644
--- a/runtest/staging
+++ b/runtest/staging
@@ -1,2 +1 @@
 # Tests for features that are not yet in the stable kernel ABI
-fanotify23 fanotify23
diff --git a/runtest/syscalls b/runtest/syscalls
index d902af500..b29151186 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -612,6 +612,7 @@ fanotify19 fanotify19
 fanotify20 fanotify20
 fanotify21 fanotify21
 fanotify22 fanotify22
+fanotify23 fanotify23
 
 ioperm01 ioperm01
 ioperm02 ioperm02
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
