Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4003CC433F5
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 15:52:24 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C012961101
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 15:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C012961101
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FD4D3C91A7
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 17:52:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 245213C8D83
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 17:51:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D772A1400514
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 17:51:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B4969201E8
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 15:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631202687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqT2Gq8iTLmmkEY35bXUUl9fRQdDOEd+R7YX93xfpBM=;
 b=RnEYKsn7EVdlPYJ7nDVlgFFuObTec8F9PlvE2A2n4b1X/himaLK5nGyOkVcxg36uotNMLh
 L3hLm2QGPZwhAQBi0R2P9zZOTC/OxwPvAJURyxKP3OSmqoHG+c8xQl1oeGvBIrkPyZUPfL
 LwGoxwPihb3IkjK3GIt52ctQmiivrcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631202687;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sqT2Gq8iTLmmkEY35bXUUl9fRQdDOEd+R7YX93xfpBM=;
 b=7+uOvc4pHlVAsDccc5ZjCnos71mAajij7ab4KOobi9zEbQD4LdoidBhXd3e0wYXI0b/1H5
 AuCruj6PDEWlSkAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A221E13CC8
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 15:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sKGWJn8tOmFZXwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 09 Sep 2021 15:51:27 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Sep 2021 17:51:21 +0200
Message-ID: <20210909155126.2720-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210909155126.2720-1-mdoucha@suse.cz>
References: <20210909155126.2720-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/8] Add tst_check_resuid() and tst_check_resgid()
 helper functions
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
Message-ID: <20210909155121.3-dUqkWuWZDZUaK_g1gK8ZaqAFIm8eBmqi55Q5pwJhc@z>

---
 include/tst_uid.h | 13 ++++++++++++
 lib/tst_uid.c     | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/tst_uid.h b/include/tst_uid.h
index b653d0a1e..e604effce 100644
--- a/include/tst_uid.h
+++ b/include/tst_uid.h
@@ -24,4 +24,17 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip);
 void tst_get_uids(uid_t *buf, unsigned int start, unsigned int size);
 void tst_get_gids(gid_t *buf, unsigned int start, unsigned int size);
 
+/*
+ * Helper functions for checking current proces UIDs/GIDs.
+ */
+int tst_check_resuid_(const char *file, const int lineno, const char *callstr,
+	uid_t exp_ruid, uid_t exp_euid, uid_t exp_suid);
+#define tst_check_resuid(cstr, ruid, euid, suid) \
+	tst_check_resuid_(__FILE__, __LINE__, (cstr), (ruid), (euid), (suid))
+
+int tst_check_resgid_(const char *file, const int lineno, const char *callstr,
+	gid_t exp_rgid, gid_t exp_egid, gid_t exp_sgid);
+#define tst_check_resgid(cstr, rgid, egid, sgid) \
+	tst_check_resgid_(__FILE__, __LINE__, (cstr), (rgid), (egid), (sgid))
+
 #endif /* TST_UID_H_ */
diff --git a/lib/tst_uid.c b/lib/tst_uid.c
index 08855ba46..af4ef8cf7 100644
--- a/lib/tst_uid.c
+++ b/lib/tst_uid.c
@@ -68,3 +68,53 @@ void tst_get_gids(gid_t *buf, unsigned int start, unsigned int count)
 			buf[i++] = id;
 	}
 }
+
+int tst_check_resuid_(const char *file, const int lineno, const char *callstr,
+	uid_t exp_ruid, uid_t exp_euid, uid_t exp_suid)
+{
+	uid_t ruid, euid, suid;
+
+	SAFE_GETRESUID(&ruid, &euid, &suid);
+
+	if (ruid == exp_ruid && euid == exp_euid && suid == exp_suid)
+		return 1;
+
+	if (callstr) {
+		tst_res_(file, lineno, TFAIL, "Unexpected process UID after %s",
+			callstr);
+	} else {
+		tst_res_(file, lineno, TFAIL, "Unexpected process UID");
+	}
+
+	tst_res_(file, lineno, TINFO, "Got: ruid = %d, euid = %d, suid = %d",
+		(int)ruid, (int)euid, (int)suid);
+	tst_res_(file, lineno, TINFO,
+		"Expected: ruid = %d, euid = %d, suid = %d",
+		(int)exp_ruid, (int)exp_euid, (int)exp_suid);
+	return 0;
+}
+
+int tst_check_resgid_(const char *file, const int lineno, const char *callstr,
+	gid_t exp_rgid, gid_t exp_egid, gid_t exp_sgid)
+{
+	gid_t rgid, egid, sgid;
+
+	SAFE_GETRESGID(&rgid, &egid, &sgid);
+
+	if (rgid == exp_rgid && egid == exp_egid && sgid == exp_sgid)
+		return 1;
+
+	if (callstr) {
+		tst_res_(file, lineno, TFAIL, "Unexpected process GID after %s",
+			callstr);
+	} else {
+		tst_res_(file, lineno, TFAIL, "Unexpected process GID");
+	}
+
+	tst_res_(file, lineno, TINFO, "Got: rgid = %d, egid = %d, sgid = %d",
+		(int)rgid, (int)egid, (int)sgid);
+	tst_res_(file, lineno, TINFO,
+		"Expected: rgid = %d, egid = %d, sgid = %d",
+		(int)exp_rgid, (int)exp_egid, (int)exp_sgid);
+	return 0;
+}
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
