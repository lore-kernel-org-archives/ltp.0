Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511B3C369BD
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 22:09:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88ACE3CB7C1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 00:09:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D698F3C2EFA
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 00:08:59 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03A86200128
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 00:08:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 305AE1F6E6;
 Tue, 15 Apr 2025 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744754931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dEbimav1rBWuSIrXL6XjqJNvfMmxFg8qGwPjgpywso=;
 b=OAORcfRilXVSz/MeY122o2hAXKM2sqJRws/WKQ1p0TOp1PJeCgiX4tHDLnNhGIbdyrzxzs
 Onwth17yN5VCvwNkMkAhxcoTi0XvtDdIgsD8A+uzSc0y3EMRmr20AW4V1tu9BTDHYx3JHi
 7Ig0HqQ5dHPHHKqI7CRAC2/YJAWT7Mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744754931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dEbimav1rBWuSIrXL6XjqJNvfMmxFg8qGwPjgpywso=;
 b=z9vOUZn37OkMgDgEx7+MCT6TmEz56SFK0V0WT8qP/QBeBj5y9hEbJeVD8tnkjsAFHLI2S9
 i6OBYmzHPJWp7gCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744754931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dEbimav1rBWuSIrXL6XjqJNvfMmxFg8qGwPjgpywso=;
 b=OAORcfRilXVSz/MeY122o2hAXKM2sqJRws/WKQ1p0TOp1PJeCgiX4tHDLnNhGIbdyrzxzs
 Onwth17yN5VCvwNkMkAhxcoTi0XvtDdIgsD8A+uzSc0y3EMRmr20AW4V1tu9BTDHYx3JHi
 7Ig0HqQ5dHPHHKqI7CRAC2/YJAWT7Mw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744754931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+dEbimav1rBWuSIrXL6XjqJNvfMmxFg8qGwPjgpywso=;
 b=z9vOUZn37OkMgDgEx7+MCT6TmEz56SFK0V0WT8qP/QBeBj5y9hEbJeVD8tnkjsAFHLI2S9
 i6OBYmzHPJWp7gCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0597B13A9F;
 Tue, 15 Apr 2025 22:08:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UL1+APPY/mf/PAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 15 Apr 2025 22:08:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Apr 2025 00:08:45 +0200
Message-ID: <20250415220845.548155-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415220845.548155-1-pvorel@suse.cz>
References: <20250415220845.548155-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-5.52 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_SPAM_SHORT(1.08)[0.362];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] cgroup_regression_test.sh: simplify last
 controller detection
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

Simplify last controller detection by using awk only - replace tail and
pipe with 'END' awk command (works also on Busybox).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/controllers/cgroup/cgroup_regression_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
index c241a5c4fc..276231fe8d 100755
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
@@ -352,7 +352,7 @@ test7()
 		return
 	fi
 
-	subsys=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`
+	subsys=$(awk 'END{ print $1 }' /proc/cgroups)
 
 	# remount to add new subsystems to the hierarchy
 	while [ $i -le 2 ]; do
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
