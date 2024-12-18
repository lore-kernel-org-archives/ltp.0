Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50839E77188
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 18:47:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D961A3ED61F
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:47:20 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2D133ED61F
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:45:21 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4EA3E1BCC64B
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 19:45:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1D961F449;
 Wed, 18 Dec 2024 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734547520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVfQI2fDa05LUzm4jfWMIGPYYMVOtaUlifsACIxtp+k=;
 b=1saCVs2mUGRH6f8Z/jX+lwnS7kVou6WPyAQps/iLm5ZY89AiezEaH1cMcbuPE52YyuVLgj
 rVXU9QpmBwmM5sE3JCFBRcq/HctJogPRreDWiPEpyCRj6AYXBiEXOXDuHpeztDNHuD80hj
 grvFeKzYHgt5i+4bcCQaz/nZXOujZUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734547520;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVfQI2fDa05LUzm4jfWMIGPYYMVOtaUlifsACIxtp+k=;
 b=oJycmauBYo2Ml8M6IRGe4jIVAed5maOwuB8p8wMzFoeZmTrj53vgsuF3w8Cw5GqUYE+tA6
 UmVmHrH3IQ8P3yCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iW8Ez0Ae;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xs9kRYAa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734547519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVfQI2fDa05LUzm4jfWMIGPYYMVOtaUlifsACIxtp+k=;
 b=iW8Ez0AeCeJyV07Db1DR1H5CT6GuDRB6uwiRgzxeiXnw7Tdcq/ejHUPmhLaluB2NAXsIXS
 Q2le7yVXEGhakgUmxM84cpGEC80Yqj+irlaOgPH7JmNlMTA2WhHTDUz2hDDToGJyN4pr2r
 s/mSEVSlzZ/n2JWd5aIUzb40NY+a0bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734547519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVfQI2fDa05LUzm4jfWMIGPYYMVOtaUlifsACIxtp+k=;
 b=Xs9kRYAaNt1JpucI9B629MO1OHIKo+3XqqXTQIrw22PGn231m85sl/10kRCmkpfnfriuRy
 1T8Y3IE+5FQBcrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2730137CF;
 Wed, 18 Dec 2024 18:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TMAUKj8YY2dscQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 18:45:19 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 19:45:10 +0100
Message-ID: <20241218184518.16190-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218184518.16190-1-chrubis@suse.cz>
References: <20241218184518.16190-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C1D961F449
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/13] testcases/kernel/mem: Move update_shm_size()
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

Move update_shm_size() from the lib to the libhugetlb.c since the
function is used only by the hugetlb testcases.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/hugetlb/lib/hugetlb.c | 11 +++++++++++
 testcases/kernel/mem/hugetlb/lib/hugetlb.h |  3 +++
 testcases/kernel/mem/include/mem.h         |  2 --
 testcases/kernel/mem/lib/mem.c             | 13 -------------
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 43a677ce9..6a2976a53 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -130,3 +130,14 @@ int do_readback(void *p, size_t size, char *desc)
 	}
 	return 0;
 }
+
+void update_shm_size(size_t * shm_size)
+{
+	size_t shmmax;
+
+	SAFE_FILE_SCANF(PATH_SHMMAX, "%zu", &shmmax);
+	if (*shm_size > shmmax) {
+		tst_res(TINFO, "Set shm_size to shmmax: %zu", shmmax);
+		*shm_size = shmmax;
+	}
+}
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index a694514d2..abc88e25e 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -56,4 +56,7 @@ int getipckey(void);
 int getuserid(char *user);
 void rm_shm(int shm_id);
 int do_readback(void *p, size_t size, char *desc);
+
+void update_shm_size(size_t *shm_size);
+
 #endif /* hugetlb.h */
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 35a1f0834..03dbe91d7 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -68,6 +68,4 @@ void write_memcg(void);
 /* cpuset/memcg - include/tst_cgroup.h */
 void write_cpusets(const struct tst_cg_group *cg, long nd);
 
-void update_shm_size(size_t *shm_size);
-
 #endif
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 06271f5d3..de9388a80 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -590,16 +590,3 @@ void write_cpusets(const struct tst_cg_group *cg, long nd)
 		SAFE_CG_PRINT(cg, "cpuset.cpus", "0");
 	}
 }
-
-/* shared */
-
-void update_shm_size(size_t * shm_size)
-{
-	size_t shmmax;
-
-	SAFE_FILE_SCANF(PATH_SHMMAX, "%zu", &shmmax);
-	if (*shm_size > shmmax) {
-		tst_res(TINFO, "Set shm_size to shmmax: %zu", shmmax);
-		*shm_size = shmmax;
-	}
-}
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
