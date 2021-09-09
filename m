Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADC6C433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 15:51:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F2B610CE
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 15:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7F2B610CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A3013C91AD
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 17:51:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB1EF3C7F5D
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 17:51:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DFFA910005BF
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 17:51:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A240F201E6
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631202687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qyIhAU0ElMUtaaBA73UrD4ooeHMVGWcVTUjZAIqwb4=;
 b=mtbSn9WWfbBgsooLXC1zjRH5ylegJJu0gcF21PJ1b6KdVaNSl9uC1OCSIqkST3/yLA1kRY
 G8IO5SQGzUEvnGwkJvBvkvqcIYP03fE9DO5BC1SZKksk1iCGNcUbXlaUoxWGzNGHIRShvi
 MCnxftZZGlEc1XEgifNPH6IJCxTZZDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631202687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qyIhAU0ElMUtaaBA73UrD4ooeHMVGWcVTUjZAIqwb4=;
 b=odtmHT37fsi4zuasI1RzbqRswgZwvTkujvpjQ5miS6nmXYGuHEGMW9S9EZiX+3+qjiTZ9U
 1xlCZNetENoYBVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D48613E37
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 15:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gECHIX8tOmFZXwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 09 Sep 2021 15:51:27 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Sep 2021 17:51:20 +0200
Message-ID: <20210909155126.2720-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909155126.2720-1-mdoucha@suse.cz>
References: <20210909155126.2720-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/8] Add SAFE_SETRESUID()/SAFE_SETRESGID() helper
 functions
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
Message-ID: <20210909155120.f4WGJRnAJANOhWdzKJfG-O65AtQjCEJqd7jRge98E7w@z>

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_macros.h | 10 ++++++++++
 lib/tst_safe_macros.c     | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 6fd618597..d99441c86 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -120,6 +120,16 @@ int safe_setreuid(const char *file, const int lineno,
 #define SAFE_SETREUID(ruid, euid) \
 	safe_setreuid(__FILE__, __LINE__, (ruid), (euid))
 
+int safe_setresgid(const char *file, const int lineno,
+	gid_t rgid, gid_t egid, gid_t sgid);
+#define SAFE_SETRESGID(rgid, egid, sgid) \
+	safe_setresgid(__FILE__, __LINE__, (rgid), (egid), (sgid))
+
+int safe_setresuid(const char *file, const int lineno,
+		  uid_t ruid, uid_t euid, uid_t suid);
+#define SAFE_SETRESUID(ruid, euid, suid) \
+	safe_setresuid(__FILE__, __LINE__, (ruid), (euid), (suid))
+
 #define SAFE_GETRESUID(ruid, euid, suid) \
 	safe_getresuid(__FILE__, __LINE__, NULL, (ruid), (euid), (suid))
 
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index fcff6d161..36b5da66f 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -145,6 +145,45 @@ int safe_setreuid(const char *file, const int lineno,
 	return rval;
 }
 
+int safe_setresgid(const char *file, const int lineno,
+	gid_t rgid, gid_t egid, gid_t sgid)
+{
+	int ret;
+
+	ret = setresgid(rgid, egid, sgid);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"setregid(%li, %li, %li) failed", (long)rgid,
+			(long)egid, (long)sgid);
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid setregid(%li, %li, %li) return value %d",
+			(long)rgid, (long)egid, (long)sgid, ret);
+	}
+
+	return ret;
+}
+
+int safe_setresuid(const char *file, const int lineno,
+	uid_t ruid, uid_t euid, uid_t suid)
+{
+	int ret;
+
+	ret = setresuid(ruid, euid, suid);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"setreuid(%li, %li, %li) failed", (long)ruid,
+			(long)euid, (long)suid);
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid setreuid(%li, %li, %li) return value %d",
+			(long)ruid, (long)euid, (long)suid, ret);
+	}
+
+	return ret;
+}
 
 int safe_sigaction(const char *file, const int lineno,
                    int signum, const struct sigaction *act,
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
